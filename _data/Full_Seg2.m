function [SEGfile,ORIENT,MAXCONF] = Full_Seg2(filepath)

%% Full Seg

% Full segmentation takes a grayscale image IM, and eccentricity and area
% cutoffs ecc and area as inputs
% 
% It returns SEG, a segmented image with each pixel assigned an orientation
% and a degree of crystallinity.

IMG2 = imread(filepath);
IM = rgb2gray(IMG2);

[m,n] = size(IM);

BW = im2bw(IM,0);
level = 0;

RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity');

Conf = zeros(m,n,100);
Orient = zeros(m,n,100);
Label = zeros(m,n);

%% Fiber Confidence parameters

minarea = 250;
maxarea = 20000;


%% 

parfor ii = 40:60
%     disp(ii)
    level = ii/100;

    BW = im2bw(IM,level);
    RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity');
    Label = bwlabel(BW,8);
    NumComps = length(RP);
    
    Comps = (1:NumComps)';
    Areas = [RP(:).Area]';
    Angles = [RP(:).Orientation]';
    Eccens = [RP(:).Eccentricity]';
    FiberConfs = zeros(NumComps,1);
    for nn = 1:NumComps
        if Areas(nn)>minarea && Areas(nn)<maxarea
            FiberConfs(nn) = Eccens(nn);
        end
    end
    
    Confii = zeros(m,n);
    Orientii = zeros(m,n);
    for jj = 1:m
        for kk = 1:n
            if Label(jj,kk)~=0
                Confii(jj,kk) = FiberConfs(Label(jj,kk));
                Orientii(jj,kk) = Angles(Label(jj,kk));
            end
        end
    end
    
    Conf(:,:,ii) = Confii;
    Orient(:,:,ii) = Orientii;
    
%     for jj = 1:NumComps
%         %tic
%         [Confidence,Orientation] = fiber_conf(jj,RP);
%         %toc
%         if Confidence > 0
%             Orient(:,:,ii) = Orient(:,:,ii) + (Label==jj) .* Orientation;
%             Conf(:,:,ii) = Conf(:,:,ii) + (Label==jj) .* Confidence;
% %         else
% %             Orient(:,:,ii) = Orient(:,:,ii) + (Label==jj) .* Orientation;
%         end
%         %length(find(Orient(:,:,ii)))
%         
%     end
    
%     filename = ['thresh' num2str(ii) '_2'];
%     save(filename,'Orient')
    
end

[MAXCONF, MaxThresh] = max(Conf,[],3);

ORIENT = zeros(m,n);

for nn = 1:m
    for j = 1:n
        ORIENT(nn,j) = Orient(nn,j,MaxThresh(nn,j));
    end
end

SEGfile = ['Dalsu data/', filepath(1:end-4), '_Seg'];

save(SEGfile,'-v7.3')

figure
imshow(IM)

orientplot(ORIENT,MAXCONF);

end
    