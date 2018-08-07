%% Read Input Video
v = VideoReader('C:\Users\schintal\Desktop\InternHackathon\input_Wildlife.mp4');
noOfBins = 5;
windowN = 5; %(for 4 bins give 5)

%% creating output directory
workingDir = pwd;
mkdir(workingDir)
imgFolder = 'Images';
mkdir(workingDir,imgFolder)

%% image file creation counter
ii = 1;

while hasFrame(v)
    % image Name preparation
    filename = [sprintf('%04d',ii) '.jpg'];
    fullname = fullfile(workingDir,imgFolder,filename);
    % reading Frames
    vidFrame = readFrame(v);
    img = image(vidFrame,'visible','off');
    resize_img = imresize(img.CData,0.5);   
    clear img;
    oilPaintingImageFrame = oilPaintingMode(resize_img,noOfBins,windowN);
    % writing images into folder
    imwrite(oilPaintingImageFrame,fullname)
    ii = ii+1;    
end

%% converting images into array
imageNames = dir(fullfile(workingDir,imgFolder,'*.jpg'));
imageNames = {imageNames.name}';

%% creating output file object
outputVideo = VideoWriter(fullfile(workingDir,'oilPaintingVideo_Out'));
outputVideo.FrameRate = v.FrameRate;
open(outputVideo)

%% writing into output file
for ii = 1:length(imageNames)
   img = imread(fullfile(workingDir,imgFolder,imageNames{ii}));
   writeVideo(outputVideo,img)
end

%% close video
close(outputVideo)
close all;