function SEG = Full_Seg(IM,ecc,area)

%% Full Seg

% Full segmentation takes a grayscale image IM, and eccentricity and area
% cutoffs ecc and area as inputs
% 
% It returns SEG, a segmented image with each pixel assigned an orientation
% and a degree of crystallinity.

maxarea = 20000;

BW = im2bw(IM,0);
level = 0;
iter = 0;

RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity');
Larges = find([RP(:).Area]>area); % find regions greater than an area
Bad = find([RP(Larges).Eccentricity]<ecc); % among those, find the less-than-eccentric ones
Bad = [Bad, find([RP(:).Area]>maxarea)]; % add on to that anything greater than a certain area
% those are the bad regions

Locked = zeros(size(IM));
Orient = zeros(size(IM));
Labels = bwlabel(BW,8);
NewPix = zeros(size(IM));

while any(Bad)
    level = level+0.01;
    iter = iter+1;
    
    if level>=1
        break
    end

    BW = im2bw(IM,level);
    RP = regionprops(BW,'Area','Eccentricity','Orientation','Extent');
    
    Larges = find([RP(:).Area] > area); %greater than area    
    Bad = find([RP(Larges).Eccentricity]<ecc);
    Bad = [Bad, find([RP(:).Area]>20000)];
end

Labels = bwlabel(BW,8);
for ii = Larges
    Locked = Locked + ~Locked.*double(Labels==ii);
end

figure
imshow(BW)
figure
imshow(Locked)
SEG = 0;
return

while level >= 0
    
    

    
    %% Find fibers at this iteration
    Larges = find([RP(:).Area] > area); %greater than area
    Notsolarges = Larges(find([RP(Larges).Area] < maxarea)); %but less than maxarea
    Fibers = Notsolarges(find([RP(Notsolarges).Eccentricity]>ecc)); %and greater than ecc
    
    %% Add any new fibers to the locked matrix and their orientations to Orient
    for ii = Fibers
        NewFiber = ~Locked.*double(Labels==ii); % a matrix of ones where the new fiber is if it's new
        if any(any(NewFiber))
            Locked = Locked + NewFiber; % whatever is now a fiber but was not previously locked as one, make it so...
            Orient = Orient + NewFiber.*RP(ii).Orientation; %Add its orientation
        end
    end 
    
end

imtool(Locked)
figure
pcolor(Orient); hc=colorbar; shading flat; axis equal;


SEG = im2bw(level);
disp(level)
imtool(BW)

figure
plot([RP(:).Area],[RP(:).Eccentricity],'ob')

end