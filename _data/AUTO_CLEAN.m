function out = AUTO_CLEAN(bwim)

points=50;
values = round(linspace(0,500,points));
AF = zeros(1,points);

for ii = 1:points
    cleanim = bwareaopen(bwim,values(ii));
    AF(ii) = AFRAC(cleanim);
    if mod(ii,10) == 0
        figure
        imshow(cleanim)
    end
%     figure
%     imshow(bwim)
end

figure
plot(values,AF,'ob')

end