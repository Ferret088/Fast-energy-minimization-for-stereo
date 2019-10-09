function [ newimg ] = GraphCutStereo( imgname1, imgname2, scaler )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    img1 = imread(imgname1);
    img2 = imread(imgname2);
    img1 = rgb2gray(img1);
    img2 = rgb2gray(img2);
    [m1, n1] = size(img1);
    [m2, n2] = size(img2);
    if (m1 ~= m2 || n1 ~= n2) 
        display('input images have different dimensions');
        return;
    end
    
    newimg = zeros(m1,n1);
    %%%%%%ERROR%%%%%%%%%
    %m1 = 1;
    for i=1:m1
        newimg(i, :) = process_row(img1, img2, i, n1, scaler);
    end
    
    imshow(uint8(newimg));
end

function disparity = process_row(img1, img2, row, n, scaler)
    row1 = img1(row, :);
    row2 = img2(row, :);
    
    disparity = zeros(1, n);
    
    %initial labeling
    for i=1:n
        disparity(i) = (i * 255)/(scaler * n);
    end
    
    success = true;
    count = 0;
    E = 0;
    while (success) 
        success = false;
        count = count + 1;
        count;
        for i=1:255
            [disparity1, E1] = alpha_expansion(row1, row2, disparity, i/scaler);
            
            if( E == 0 ||  E1 < E)
                disparity = disparity1;
                E = E1;
                success = true;
            end
            
        end
        %%%%%%ERROR%%%%%%%%%%%%
        %success = false;
    end
    
end


