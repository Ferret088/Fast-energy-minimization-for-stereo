function [ ret ] = D( row1, row2, l, dis)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    n = max(size(row1));
    rl = floor(l + dis);
    rr = ceil(l + dis);
    
    if rr > n
        ret = 20;
    else
        ret = abs(row1(l) - my_interp(row2(rl), row2(rr), dis - floor(dis)));
        if ret > 20 
            ret = 20;
        end
    end
    

end

function ret = my_interp(a, b, x)
    ret = a + ((b-a) * x);
end
