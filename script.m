%% ECES 486 - Term Project

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


% num_images = 25;


for i = 1:num_images % image slices
    if ( num_images > 10 )
        draw = ~true(1);
    else
        draw = true(1);
    end
    
    src = imread(fname,i);
    im = src;
    
    % sharpen -> medfilt2 -> dilate -> threshold -> bwdist -> watershed ->
    % bwboundaries -> combine
    
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
    figure; imagesc(src);
    if ~draw
        set(gcf, 'Visible', 'off');
    end
    hold on;
    for k = 1:length(B)
       boundary = B{k};
       
       if (polyarea(boundary(:,2), boundary(:,1)) <= 1.5)
           continue;
       end
       
       plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
    end
    set(gcf,'position',[0 500 length(L)*4 length(L(:,1))*4]);
    hold off;
    
    dir = 'Segmentations';
    saveas(gcf, fullfile(dir, int2str(i)),'jpeg');
    fprintf('Image # %d \n',i);
end