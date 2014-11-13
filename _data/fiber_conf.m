function [C,O] = fiber_conf(x,RP)

maxarea = 20000;
minarea = 250;
area = RP(x).Area;

if x~=0
    if area > maxarea
        C = 0; O = -180;
    elseif area < minarea
        C = 0; O = -180;
    else
        C = RP(x).Eccentricity;
        O = RP(x).Orientation;
    end
else
    C=0;O=-180;
end

end