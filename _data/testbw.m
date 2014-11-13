function out = testbw(im,DEV,thresh,area)

RGB = imread(DEV(im).File);
G = rgb2gray(RGB);
out = im2bw(G,thresh);
imtool(out)
out = bwareaopen(out,area);
imtool(out)

end