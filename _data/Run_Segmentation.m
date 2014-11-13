clear all
close all
clc

load('DEV.mat');

for i = 4:length(DEV)
    [SEGi,ORIENTi,CONFi] = Full_Seg2(DEV(i).File);
    DEV(i).Seg = SEGi;
end

