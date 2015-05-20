%% Analysing SMEAR Images
% Description:
% Analysing and extracting information out of SMEAR Images.
%

clc
clear all
close all hidden
%% Loading and showing data

cd .\Data
[Filename,~,FilterIndex] = uigetfile({'*.mat';'*.jpg';'*.bmp'},'Select File');
if((FilterIndex == 1) || (FilterIndex == 3))
    img = importdata(Filename);
elseif(FilterIndex == 2)
    img = imread(Filename);
end
cd ..\

imshow(img);

%% Add Input control of quality
%

% redHist = imhist(img(:,:,1));
% redHistMean = mean(redHist);
% if (redHistMean < (1.0594E+03 - (706.2978))) || (redHistMean > (1.0594E+03 - (706.2978)))
%     boxH = msgbox('Quality of Picture is to low. Program stops !','Error','error');
%     return
% end
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

% Test algorithm with |bwconncomp|
% cc = bwconncomp(bw_fill,4);
% cc.NumObjects
RadMin = 10;
RadMax = 25;
if verLessThan('matlab','8.3.0.532')
    [CircleCenter, CircleRad] = CountCircles(img_adjust, RadMin, RadMax);
else
    [CircleCenter, CircleRad] = CountCircles(bw_fill, RadMin, RadMax);
end
circ_h = viscircles(CircleCenter, CircleRad,'EdgeColor','b');
%% check if white blood cells where counted aswell