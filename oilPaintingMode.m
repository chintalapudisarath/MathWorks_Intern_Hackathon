function oilPaintingImageFrame = oilPaintingMode(inputImg,noOfBins,windowN)
    imageRGB = inputImg;
    [height, width, depth] = size(imageRGB);
    no_of_bins = noOfBins; %variable 5 (for 4 bins)
    N = windowN; % variable 5
    oilPaintingImageFrame = uint8(zeros(height,width));

    parfor dep=1:depth
        resize_image_R = imageRGB(:,:,dep);
        % Initializations
        ids = 1:256;
        values = zeros(1,256);
        Histogram_Map = containers.Map(ids,values);
        total = 0;
        binSize = ceil(height*width/no_of_bins);

        %% Dividing given image into bins
        lastVal = 1;
        binCounter = 1;
        binArray = {0,0,0,0};
        binTotal = {0,0,0,0};
        diffCount = 0;
        for i = ids
            Histogram_Map(i) = sum(resize_image_R(:) == i-1);
            total = total + Histogram_Map(i);
            if (total > binSize)
                if ((total-binSize) == 1)
                    binArray{binCounter} = lastVal;
                    if (diffCount == 0)
                        binTotal{binCounter} = Histogram_Map(lastVal);
                    else
                        binTotal{binCounter} = diffCount;
                        diffCount = 0;
                    end
                    for m=lastVal+1:i-1
                        binArray{binCounter}(end+1) = m;
                        binTotal{binCounter}(end+1) = Histogram_Map(m);
                    end
                    binArray{binCounter}(end+1) = i;
                    binTotal{binCounter}(end+1) = Histogram_Map(i);            
                    total = 0; 
                    binCounter= binCounter+1; 
                    lastVal = i+1;
                else
                    binArray{binCounter} = lastVal;
                    binTotal{binCounter} = Histogram_Map(lastVal);                        
                    for m=lastVal+1:i-1
                        binArray{binCounter}(end+1) = m;
                        binTotal{binCounter}(end+1) = Histogram_Map(m);
                    end
                    diffCount = total-binSize;
                    binArray{binCounter}(end+1) = i;
                    binTotal{binCounter}(end+1) = Histogram_Map(i) - diffCount;
                    total = diffCount; 
                    binCounter= binCounter+1; 
                    lastVal = i;
                end      
            end
        end

        %% Weighted Mean of Each Bin
        meanArray = [0, 0, 0, 0];
        for i=1:no_of_bins-1
            meanArray(i) = floor(sum(binArray{i}.*binTotal{i})/sum(binTotal{i}));
        end

        %% Substituting Bin values weighted mean into new Image
        checkCount = 1;
        final_Resize_image_R = imageRGB(:,:,dep); %initialisation
        for i=1:length(meanArray)
            for j = 1:length(binArray{i})-1
                if checkCount == 1
                    final_Resize_image_R(imageRGB(:,:,dep) == binArray{i}(j)) = meanArray(i);
                else
                    final_Resize_image_R(~find(imageRGB(:,:,dep) == binArray{i}(j),binTotal{i}(j),'first')) = meanArray(i);
                    checkCount = 1;
                end
            end
            if(j == length(binArray{i}))
                final_Resize_image_R(find(imageRGB(:,:,dep) == binArray{i}(end),binTotal{i}(end),'first')) = meanArray(i);
                if any(intersect(binArray{i},binArray{i+1}))
                    checkCount = 0;
                end
            end
        end

        %% Boundary expansion in the new image based on Filter Size N
        floorN = floor(N/2);
        oilPaintFrameWidthHeight = padarray(final_Resize_image_R,[floorN floorN],0,'both');
        %% frequent value subtitution
        tempVal = colfilt(oilPaintFrameWidthHeight,[N N],'sliding',@mode);
        oilPaintingImageFrame(:,:,dep) = tempVal(floorN+1:height+floorN,floorN+1:width+floorN);
    end
 end