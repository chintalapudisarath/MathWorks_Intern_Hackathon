function realTimeOilPainting(noOfBins,windowN)
    w = webcam();
    for k = 1:100
        img = snapshot(w);
        resize_img = imresize(img,0.8);   
        clear img;
        tic
        oilPaintingImageFrame = oilPaintingMode(resize_img,noOfBins,windowN);
        toc
        imshow(oilPaintingImageFrame);
        drawnow;
    end
end
