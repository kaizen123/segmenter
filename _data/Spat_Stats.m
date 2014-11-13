close all
clear all
clc

D = load('DEV.mat');
DEV = D.DEV;
SSMAT = zeros(16,2161^2+751);
MOB = zeros(16,1);
count = 0;

for i = [[1:7],[10:18]]
    count = count+1;
    IM = load(DEV(i).BW);
    IM = IM.BW;
    [T,xx] = SpatialStatsFFT(IM,[],'periodic',false);
    DEV(i).SS = T(:)';
    SSMAT(count,1:2161^2) = DEV(i).SS;
    SSMAT(count,2161^2+1:end) = DEV(i).UV;
    MOB(count,1) = DEV(i).Mob;
end

[Coef, Score] = pca(SSMAT);

figure
plot(Score(:,1),Score(:,2),'ob')

figure
plot(Score(:,1),MOB,'ob')

figure
scatter3(Score(:,1),Score(:,2),MOB,'ob')

REL = [Score(:,1),Score(:,2),Score(:,3),MOB];
sorted = sortrows(REL,4);

%% Display the PCs

figure
pcolor(fftshift(xx{2}),fftshift(xx{1}),fftshift(reshape(Coef(1:2161^2,1),2161,2161)));
hc = colorbar; shading flat; axis equal;