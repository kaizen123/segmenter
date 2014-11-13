clear all
close all
clc

% IMG = imread('10%_2min.tif');
% IMG = rgb2gray(IMG);
% 
% Full_Seg(IMG,0.8,2000);

[SEG,ORIENT,CONF] = Full_Seg2('10%_2min.tif');

% BIGF = imread('15%_2min.tif');
% BIGF = im2bw(BIGF,0.52);
% RP = regionprops(BIGF,'Area','Eccentricity','Solidity');
% 
% figure
% plot([RP(:).Area],[RP(:).Eccentricity],'ob')
% imtool(BIGF)