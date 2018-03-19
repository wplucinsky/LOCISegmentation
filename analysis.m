%% ECES 486 - Term Project Analysis

% Will Plucinsky
% ECES 486
% LOCI - CLC GFP

clear, close all, clc, imtool close all;

%% Method
%{
    -> sharpen 
    -> medfilt2 
    -> dilate 
    -> threshold 
    -> bwdist 
    -> watershed 
    -> bwboundaries 
    -> combine
%}

%% Work

fname = 'CLC-GFP A19 0.5MS root1.tif';
info = imfinfo(fname);
num_images = numel(info);

% num_images = 1; % used for testing

figure; hold on;
a=[]; b=[]; c=[];
for i = 1:num_images % image slices
    if ( num_images > 10 )
        draw = ~true(1);
    else
        draw = true(1);
    end
    
    src = imread(fname,i);
    im = src;
    
% sharpen
    sharp = imsharpen(im,'Radius',8,'Amount',4);
 
% medfilt2
    med = medfilt2(sharp, [3 3]);

% dilate
    se = strel('disk',1,0);
    dil = imdilate(med,se);

% threshold
    dil2 = dil;
    dil2(find(dil2<3000)) = 0;

% bwdist
    D = bwdist(~dil2);
    D = -D;
    D(~dil2) = Inf;

% watershed
    L = watershed(D); 
    L(~dil2) = 0;
    L(find(L>0)) = 1; % convert to one solid color
   
% bwboundaries
    L_bw = imbinarize(L);
    B = bwboundaries(L_bw);
 
% combine
    x=[]; y=[];
    for k = 1:length(B)
       boundary = B{k};
       
       if (polyarea(boundary(:,2), boundary(:,1)) <= 1.5)
           continue;
       end
       
       % single images
       x = [x polyarea(boundary(:,2), boundary(:,1))];
       y = [y length(boundary(:,2)) + length(boundary(:,1))];
       
       % all images
       a = [a polyarea(boundary(:,2), boundary(:,1))];
       b = [b length(boundary(:,2)) + length(boundary(:,1))];
    end
    c = [c length(B)];
    col = hsv(length(x));
    scatter(x,y,[],col);
end

title('Perimeter and Area Comparison of Segmentation')
xlabel('Area (px)')
ylabel('Perimeter (px)')
mdl = fitlm(x,y);
hold off; 


figure;
histogram(a);
title('Area Comparison of Segmentation')
xlabel('Area (px)')
ylabel('Count')

figure;
histogram(b);
title('Perimeter Comparison of Segmentation')
xlabel('Perimeter (px)')
ylabel('Count')

figure;
histogram(c);
title('Comparison of Segmentation Counts')
xlabel('Number of Segmentations')
ylabel('Count')