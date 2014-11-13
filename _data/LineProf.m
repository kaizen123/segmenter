function [DISThor, DISTvert, HorAv, VertAv] = LineProf(bwim,frame)
%% Line Profiler
% takes a black and white image as an input and the physical length of its
% frame edges and outputs a distribution of all the horizontal and vertical
% grain boundary sizes

[m,n] = size(bwim);
scale = frame/max(m,n)*1E9;

DIST = zeros(m,n); % this will store the length of each grain boundary in each row

for i=1:m
    in_grain = 0;
    grain = [0 0]; % grain vector expresses [grain # in that line, pixel where it started]
    
    if bwim(i,1) == 0 % for each row, if you start in a grain, record that
        in_grain = 1;
        grain = grain+[1 1];
    end
    
    for j=1:n-1
        if in_grain == 1 % if you are currently in a grain
            if bwim(i,j+1) == 1 % and if the next pixel is a fiber
                in_grain = 0; % you are no longer in a grain
                DIST(i,grain(1)) = j-grain(2); % add the length of the grain you just traversed to the distribution in the i'th row
            end
        else
            if bwim(i,j+1) == 0 % if you're in a fiber and the next pixel is a grain
                in_grain = 1; % you are now in a grain!
                grain(1) = grain(1) + 1; % it is the next grain in the line
                grain(2) = j+1; % and it starts at the next pixel
            end
        end
    end
    
    if in_grain == 1 % at the end of the line, if you are in a grain
        if bwim(i,n) == 0 % and the last pixel is still a grain
            DIST(i,grain(1)) = n-grain(2); % the grain you're in extends to the edge of the frame
        end
    end % and that's the only thing to do with the end pixel
end

DISThor = DIST; % store this DIST as horizontal
DISThor = DISThor.*scale;

%% Now we do it on the transpose

bwim = bwim';
[m,n] = size(bwim);
DIST = zeros(m,n);

for i=1:m
    in_grain = 0;
    grain = [0 0]; % grain vector expresses [grain # in that line, pixel where it started]
    
    if bwim(i,1) == 0 % for each row, if you start in a grain, record that
        in_grain = 1;
        grain = grain+[1 1];
    end
    
    for j=1:n-1
        if in_grain == 1 % if you are currently in a grain
            if bwim(i,j+1) == 1 % and if the next pixel is a fiber
                in_grain = 0; % you are no longer in a grain
                DIST(i,grain(1)) = j-grain(2); % add the length of the grain you just traversed to the distribution in the i'th row
            end
        else
            if bwim(i,j+1) == 0 % if you're in a fiber and the next pixel is a grain
                in_grain = 1; % you are now in a grain!
                grain(1) = grain(1) + 1; % it is the next grain in the line
                grain(2) = j+1; % and it starts at the next pixel
            end
        end
    end
    
    if in_grain == 1 % at the end of the line, if you are in a grain
        if bwim(i,n) == 0 % and the last pixel is still a grain
            DIST(i,grain(1)) = n-grain(2); % the grain you're in extends to the edge of the frame
        end
    end % and that's the only thing to do with the end pixel
end

DISTvert = DIST;
DISTvert = DISTvert.*scale;

%% Now we calculate some metrics

%% Average grain size
[HorGs,HorAv] = AVGGRAIN(DISThor);
[VertGs,VertAv] = AVGGRAIN(DISTvert);

hist([HorGs VertGs],50)

%% Average number of grains per line
GPLhor = GPL(DISThor);
GPLvert = GPL(DISTvert);
disp(GPLhor)
disp(GPLvert)
%% Average number of grains of length <x per line

end

        
function [GRAINS, Avg] = AVGGRAIN(DIST)
%% AVGGRAIN
% find the number average grain length from a distribution

[m,n] = size(DIST);
GRAINS = [];
for i = 1:m
    GRAINS = [GRAINS, DIST(i,find(DIST(i,:)))];
    % this will return a vector whose length is equal to the number of
    % horizontal grains and each component is the length of that grain
end

Avg = sum(GRAINS)/length(GRAINS);

end

function out = GPL(DIST)

[m,n] = size(DIST);
GRAINS = [];
for i = 1:m
    GRAINS = [GRAINS, length(DIST(i,find(DIST(i,:))))];
    % this will return a vector whose length is equal to the number of rows
    % in the image and whose components are the number of grains in that
    % row
end

out = sum(GRAINS)/length(GRAINS);

end