function out = showseg(im,DEV)

I = load(DEV(im).Seg);
I = I.Segmented;
imtool(I)

out = 0;

end