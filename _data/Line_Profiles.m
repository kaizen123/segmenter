close all
clear all
clc
%% 5% co-solvent, 2min ultrasonication
% 
% D5 = imread('5%_2min.tif');
% D5side = 2E-6; % size of the frame
% D5gray = rgb2gray(D5);
% D5bw = im2bw(D5gray,0.4);
% D5clean = bwareaopen(D5bw,100);
% %D5bw = AUTO_THRESH(D5gray);
% 
% figure
% imshow(D5clean);
% figure
% [DH DV AH AV] = LineProf(D5clean,D5side);
% 

% %% 3% Acetone
% C3 = imread('Cha_3.png');
% C3side = 2E-6; % meters per side
% C3gray = rgb2gray(C3);
% C3bw = im2bw(C3gray,0.4);
% C3clean = bwareaopen(C3bw,20);
% figure
% imshow(C3);
% figure
% imshow(C3bw);
% figure
% imshow(C3clean);
% figure
% [DH1 DV1 AH1 AV1] = LineProf(C3clean,C3side);

% 5 minute UV bath
C5m = imread('Cha_3.png');
figure
imshow(C5m)
C5mside = 2E-6;
C5mgray = rgb2gray(C5m);
figure
imshow(C5mgray)
C5mbw = AUTO_THRESH(C5mgray);

break
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
figure
imshow(C5mbw)
C5mclean = bwareaopen(C5mbw,40);
figure
imshow(C5mclean)
figure
% C5mseg = Classify_Fibers(C5mclean);
% figure
% imshow(C5mseg)
% [DH5 DV5 AH5 AV5] = LineProf(C5mclean,C5mside);

[G1,G2,gabout1,gabout2] = gaborfilter2(C5mclean,10,2,0,0);
figure
imshow(gabout1)
figure
imshow(gabout2)
figure
imshow(G1)
figure
imshow(G2)
%% Simulated morphologies
% 
% DalHor = imread('side_side.jpg');
% DHgray = rgb2gray(DalHor);
% DHbw = imcomplement(im2bw(DHgray,0.4));
% figure
% imshow(DalHor)
% figure
% [SideH SideV] = LineProf(DHbw,100E-9);
% DalVert = imread('up_down.jpg');
% DVgray = rgb2gray(DalVert);
% DVbw = imcomplement(im2bw(DVgray,0.4));
% figure
% imshow(DalVert)
% figure
% [VertH VertV] = LineProf(DVbw,100E-9);
% DalDiag = imread('tilt.jpg');
% DDgray = rgb2gray(DalDiag);
% DDbw = imcomplement(im2bw(DDgray,0.4));
% figure
% imshow(DalDiag)
% figure
% [DiagH DiagV] = LineProf(DDbw,100E-9);
