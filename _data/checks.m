clear all
close all
clc

A = round(checkerboard(8));
figure
spy(A)
figure
B = SpatialStatsFFT(A);
figure
surface(B)
grid off

%% Autocorrelation
figure
[fA xx] = SpatialStatsFFT(A==1);
figure
[fAshift xxshift] = SpatialStatsFFT(A==1,[],...
                                    'shift', true);