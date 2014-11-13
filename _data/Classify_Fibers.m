function out = Classify_Fibers(clean)

[m,n]=size(clean);
out = zeros(m,n)-1;
%disp(out)
fiber = 1;
for i = 1:m
    for j = 1:n
        if out(i,j) == -1
            if clean(i,j) == 0
                out(i,j) = 0;
            else
                out = Sweeper(out,clean,i,j,fiber);
                fiber = fiber+1;
            end
        end
    end
end

end

function out = Sweeper(current,clean,i,j,fiber)
%% Sweeper
% Operates like minesweeper
% Takes the current classified domain matrix, the clean image, and the
% current indices, returns the classified domain matrix with the current
% point in it, and calls Sweeper for all of the neighboring points that are
% also crystalline

current(i,j) = fiber;
out = current;
[m,n] = size(clean);
% disp([i j])

%% Fuck this section
% Seriously fuck it

if i>1 && i<m && j>1 && j<n
    if clean(i+1,j) == 1 && out(i+1,j) == -1
        out = Sweeper(out,clean,i+1,j,fiber);
    end
    if clean(i+1,j+1) == 1 && out(i+1,j+1) == -1
        out = Sweeper(out,clean,i+1,j+1,fiber);
    end
    if clean(i,j+1) == 1 && out(i,j+1) == -1
        out = Sweeper(out,clean,i,j+1,fiber);
    end
    if clean(i-1,j+1)==1 && out(i-1,j+1) == -1
        out = Sweeper(out,clean,i-1,j+1,fiber);
    end
    if clean(i-1,j)==1 && out(i-1,j) == -1
        out = Sweeper(out,clean,i-1,j,fiber);
    end
    if clean(i-1,j-1) == 1 && out(i-1,j-1) == -1
        out = Sweeper(out,clean,i-1,j-1,fiber);
    end
    if clean(i,j-1) == 1 && out(i,j-1) == -1
        out = Sweeper(out,clean,i,j-1,fiber);
    end
    if clean(i+1,j-1) == 1 && out(i+1,j-1) == -1
        out = Sweeper(out,clean,i+1,j-1,fiber);
    end
else
    if i<m && clean(i+1,j) == 1 && out(i+1,j) == -1
        out = Sweeper(out,clean,i+1,j,fiber);
    end
    if i<m && j<n && clean(i+1,j+1) == 1 && out(i+1,j+1) == -1
        out = Sweeper(out,clean,i+1,j+1,fiber);
    end
    if j<n && clean(i,j+1) == 1 && out(i,j+1) == -1
        out = Sweeper(out,clean,i,j+1,fiber);
    end
    if i>1 && j<n && clean(i-1,j+1)==1 && out(i-1,j+1) == -1
        out = Sweeper(out,clean,i-1,j+1,fiber);
    end
    if i>1 && clean(i-1,j)==1 && out(i-1,j) == -1
        out = Sweeper(out,clean,i-1,j,fiber);
    end
    if i>1 && j>1 && clean(i-1,j-1) == 1 && out(i-1,j-1) == -1
        out = Sweeper(out,clean,i-1,j-1,fiber);
    end
    if j>1 && clean(i,j-1) == 1 && out(i,j-1) == -1
        out = Sweeper(out,clean,i,j-1,fiber);
    end
    if i<m && j>1 && clean(i+1,j-1) == 1 && out(i+1,j-1) == -1
        out = Sweeper(out,clean,i+1,j-1,fiber);
    end
end

end