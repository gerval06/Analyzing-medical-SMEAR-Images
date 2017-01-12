%% Analysing SMEAR Images
% Description:
% Analysing and extracting information out of SMEAR Images.

clc
clear all
close all hidden
%% Loading and showing data
% Loading data with |uigetfile| function. Loading is done depending on
% file index.

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
% if ~(redHistMean < (1.0594E+03 - (706.2978))) || (redHistMean > (1.0594E+03 + (706.2978)))
%     boxH = msgbox('Quality of Picture is to low. Program stops !','Error','error');
%     return
% end
%% Analysing Image
% Adjusting Image by improving background and adjusting background

img_gray = rgb2gray(img);
background = imopen(img_gray,strel('disk',40));
img_gray2 = img_gray - background;
img_gray_comp = imcomplement(img_gray2);
img_adjust = imadjust(img_gray_comp);

background2 = imopen(img_adjust,strel('disk',15));
img_adjust2 = img_adjust - background;

%% Counting circles
% Defining min and max radii and using Hough transform for detecting
% circles. 

RadMin = 10;
RadMax = 25;
[CircleCenter, CircleRad] = CountCircles(img_adjust, RadMin, RadMax);
%circ_h = viscircles(CircleCenter, CircleRad,'EdgeColor','b');
%% check if white blood cells where counted aswell