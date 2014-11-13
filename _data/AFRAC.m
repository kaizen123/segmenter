function out = AFRAC(bwim)
%% Area Fraction of black and white image

[m,n] = size(bwim);
out = sum(sum(bwim))/(m*n);

end