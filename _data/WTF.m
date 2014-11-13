biguns = find([S(:).Area]>5000);
weirduns = biguns(find([S(biguns).Eccentricity]<0.97));
actualweird = weirduns(find([S(weirduns).Extent]<0.5));


filtered = zeros(2160);

for i = actualweird
    filtered = filtered+double(labeled==i);
end

imtool(filtered)