function y = Mux4( x, sel)
    if sel == 0
        y(1) = x(1,1);
        y(2) = x(1,2);
    elseif sel == 1
        y(1) = x(2,1);
        y(2) = x(2,2);
    elseif sel == 2
        y(1) = x(3,1);
        y(2) = x(3,2);
    else
        y(1) = x(4,1);
        y(2) = x(4,2);
    end
end

