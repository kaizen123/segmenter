close all
clc

% D = load('DEV.mat');
% DEV = D.DEV;

for i = [[1:7],[10:18]]
    BW = load(DEV(i).BW);
    SEG = BW.BW;
    Eroded = imerode(SEG,strel('square',2));
    Eroded = imerode(Eroded,strel('square',2));
    imtool(Eroded)
end

