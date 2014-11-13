clear all
close all
clc

C5m = imread('Cha_8min.png');
C5mgray = rgb2gray(C5m);

points = 50;
C5E = edge(C5mgray,'Canny');
THRESH = linspace(0,1,points);
T_Store = struct();

figure
hold on
for i = 1:points
    T_Store(i).image = im2bw(C5mgray,THRESH(i));
    T_Store(i).overlap = sum(sum(T_Store(i).image .* C5E));
    plot(THRESH(i),T_Store(i).overlap,'ob')
end
hold off

% figure
% hold on
% for j = 1:2000
%     plot(j,bwarea(bwareaopen(T_Store(6).image,j)),'-b')
% end
% hold off

% for i = 10:-1:5
%     figure
%     imshow(T_Store(i).image)
% end
figure
hold on
for i = 1:points
CCi = bwconncomp(T_Store(i).image);
plot(THRESH(i),CCi.NumObjects,'ob')
end
hold off

figure
imshow(C5m)
figure
imshow(C5E)