% clear all
% close all
% clc
% 
% D = load('DEV.mat');
% DEV = D.DEV;

for i = [[1:7],[10:18]]
    RGB = imread(DEV(i).File);
%     R = RGB(:,:,1);
    G = rgb2gray(RGB);
    Params = DEV(i).Params;
    bwinit = im2bw(G,Params(1));
    BW = bwareaopen(bwinit,Params(2));
    
%     if i ==1
%         BW = im2bw(G./255,0.45);
%     elseif i == 20
%         BW = im2bw(G./255,0.35);
%     elseif i == 7
%         BW = im2bw(G./255,0.45);
%     elseif i == 6
%         BW = im2bw(G./255,0.45);
%     elseif i == 17
%         BW = im2bw(G./255,0.43);
%     elseif i == 16
%         BW = im2bw(G./255,0.45);
%     else
%         BW = im2bw(G./255,0.4);
%     end
%     disp('about to run kmeans')
%     [IDX, Cent] = kmeans(G(:),2);
%     BW = zeros(2160);
%     Cent = [Cent, [1:2]'];
%     Centsort = sortrows(Cent,1);
%     BW = BW + reshape(IDX==Centsort(2,2),2160,2160);
%     
%     imtool(BW)
    
    DEV(i).BW = [DEV(i).File(1:end-4), 'bw.mat'];
    save(DEV(i).BW,'BW')
end
%     
save('DEV.mat','DEV')

%% None of this shit works
%     B = RGB(:,:,3);
%     edgeR = edge(R./255,'canny');
%     edgeG = edge(G./255,'canny');
%     edgeB = edge(B./255,'canny');
%     figure
%     imshow(edgeR)
%     figure
%     imshow(G)
%     figure
%     imshow(edgeG)
%     figure
%     imshow(edgeB)
%     thresh = sum(sum(G.*edgeG))/sum(sum(edgeG))/255;
%     [IDX,CENT] = kmeans(G(:),2);
%     [maxi, highval] = max(CENT);
%     if maxi == 1
%         BW = reshape(IDX==1,2160,2160);
%     else
%         BW = reshape(IDX==2,2160,2160);
%     end
%     BW = im2bw(G./255,0.43);
%     AF = sum(sum(BW))/numel(BW);
%     disp(AF)
%     disp(i)
%     disp(thresh)
%     disp('__________')
%     figure
%     imshow(BW)
