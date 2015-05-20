%% Analysing SMEAR Images
% Description:
% Analysing and extracting information out of SMEAR Images.
%

clc
clear all
close all hidden
%% Loading and showing data

cd .\Data
[Filename,~,FilterIndex] = uigetfile({'*.mat';'*.jpg'},'Select File');
if(FilterIndex == 1)
    img = importdata(Filename);
elseif(FilterIndex == 2)
    img = imread(Filename);
end
cd ..\

imshow(img);

%% Add Input control of quality
%

redHist = imhist(img(:,:,1));
redHistMean = mean(redHist);
if (redHistMean < (1.0594E+03 - (2*706.2978))) || (redHistMean > (1.0594E+03 - (2*706.2978)))
    boxH = msgbox('Quality of Picture is to low. Program stops !','Error','error');
    return
end
%% Analysing Image
% Test bwboundaries function to find boundaries of croped image to get
% cropped image use imcrop function.
% 
% Make black and white image for further analysis

img_gray = rgb2gray(img);
background = imopen(img_gray,strel('disk',40));
img_gray2 = img_gray - background;
img_gray_comp = imcomplement(img_gray2);
img_adjust = imadjust(img_gray_comp);

background2 = imopen(img_adjust,strel('disk',15));
img_adjust2 = img_adjust - background;
%imshow(im_adjust2)

level = graythresh(img_adjust2);
bw = im2bw(img_adjust2,level);
bw_fill = imfill(bw,'holes');
%imshow(bw_fill)

% Test algorithm with |bwconncomp|
% cc = bwconncomp(bw_fill,4);
% cc.NumObjects

if verLessThan('matlab','8.3.0.532')
    [accum, circen, cirrad] = CircularHough_Grd(bw_fill,[10,25]);
    circ_h = viscircles(circen,cirrad,'EdgeColor','b');
else
    % Find cells with |imfindcircles| parameter where chossen by testing
    [centers, radii] = imfindcircles(bw_fill,[10,25],'ObjectPolarity','bright','Sensitivity',0.8);
    circ_h = viscircles(centers, radii,'EdgeColor','b');
end
title(['Number of detected cells: ' num2str(max(size(centers)))])

%% check if white blood cells where counted aswell