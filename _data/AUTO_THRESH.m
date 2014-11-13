function out = AUTO_THRESH(impath)
%% Auto-thresholding for fiber segmentation
% The ideal threshold value for creating segmented AFM images of P3HT
% nanofibers has been observed to be just before the point where the entire
% image forms a "percolating network" ... What this means is that the
% number of unique, fully connected objects in the image drops
% precipitously. We are looking specifically for the threshold that
% produces the maximum number of connected objects.

IMG = imread(impath);
grayim = rgb2gray(IMG);

% figure
% imshow(IMG)
% figure
% imshow(grayim)

points = 100;
THRESH = linspace(0,1,points);
BWIM = struct();
Objects = zeros(1,points);

for i = 1:points
    BWIM(i).image = im2bw(grayim,THRESH(i));
    CCi = bwconncomp(BWIM(i).image);
    Objects(i) = CCi.NumObjects;
end

best_thresh = find_plateau(Objects);
% disp('Best threshold was:')
% disp(best_thresh)
out = im2bw(grayim,best_thresh);
% figure
% imshow(out);

af = sum(sum(out))/numel(out);
disp(af)

% out=Objects;
% 
% figure
% plot(THRESH,Objects,'-b')
% title('Number of unique objects vs. Threshold value')

end

function out = find_plateau(Obj)

n = length(Obj);
i = ceil(0.1*n);
while i<0.9*n
    back5 = (Obj(i)-Obj(ceil(i-0.05*n)))/0.05;
    back1 = (Obj(i)-Obj(i-1))/(1/n);
    for1 = (Obj(i+1)-Obj(i))/(1/n);
    for5 = (Obj(floor(i+0.05*n))-Obj(i))/0.05;
    if back5>0 && back1>0 && for1<0 && for5<0.5*back1
        out = i/n;
        return
    end
    i = i+1;
end
out = i/n;
end