clear all
close all
clc

%% 

C5m = imread('Cha_5min.png');
% figure
% imshow(C5m)
C5mside = 2E-6;
C5mgray = rgb2gray(C5m);
% figure
% imshow(C5mgray)
% thresh = graythresh(C5mgray);
% THRESH = multithresh(C5mgray,3);
% C5mQuant = imquantize(C5mgray,THRESH);
% figure
% imshow(C5mQuant)
% C5mOtsu = im2bw(C5mgray,thresh);
% figure
% imshow(C5mOtsu)
% 
% 
% 
% figure
% imhist(C5mgray)
% 
% break

C5mbw = im2bw(C5mgray,0.28);
% figure
% imshow(C5mbw)
C5mclean = bwareaopen(C5mbw,40);
% figure
% imshow(C5mclean)
% C5mseg = Classify_Fibers(C5mclean);
% figure
% imshow(C5mseg)
% [DH5 DV5 AH5 AV5] = LineProf(C5mclean,C5mside);
% 
% [G1,G2,gabout1,gabout2] = gaborfilter2(C5mclean,10,2,0,0);
% figure
% imshow(gabout1)
% figure
% imshow(gabout2)
% figure
% imshow(G1)
% figure
% imshow(G2)

% EDGES = edge(C5mgray,'canny');
% figure
% imshow(EDGES)
% break

RGB = C5m;
% BW = C5mclean;
BW = edge(C5mclean,'Canny');
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89.5);
peaks = houghpeaks(H);
lines = houghlines(BW, T,R, peaks);

% Display the original image.
subplot(2,1,1);
imshow(RGB);
title('Gantrycrane Image');

% Display the Hough matrix.
subplot(2,1,2);
imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough Transform of Gantrycrane Image');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot);