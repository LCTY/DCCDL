function z = update( z, x )
%UPDATE Summary of this function goes here
%   Detailed explanation goes here
    len = length(z);
    if len > 1
        for i = len:-1:2
            z(i) = z(i-1);
        end
        z(1) = x;
    else
        z = x;
    end
end

