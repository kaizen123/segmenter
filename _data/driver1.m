% Download and Image from the web and fit the phases



IMG = imread('15%_2min.tif');

IMGR = rgb2gray(IMG);

figure
imshow(IMGR);

[COUNTS,X] = imhist(IMGR,255);

whos

figure
[FitResults,LowestError,BestStart,xi,yi,BootResults] = peakfit([X,COUNTS],0,0,2);

figure
plot(xi,yi,'-b')


% out = segmentprob(IMGR,...
%                     50,...
%                     3);
% 
% out = segmentprob( mean(double( imread('15%_2min_2.tif') ), 3), ... A 2-D (could be 3-D) image, average the RGB channels
%     51, ... Number of bins in the histogram
%     3 ...  Number of peaks of phases to find
%     );

%[url=https://flic.kr/p/oX46Cu][img]https://farm6.staticflickr.com/5572/15062860448_0ff498a9bb_s.jpg[/img][/url][url=https://flic.kr/p/oX46Cu]15%_2min_2[/url] by [url=https://www.flickr.com/people/127699624@N02/]nepersson[/url], on Flickr

