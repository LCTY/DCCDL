function [ value, index ] = Mux( x1, x2, sel )
    if sel == 0
        value = x1(1);
        index = x1(2);
    else
        value = x2(1);
        index = x2(2);
    end
end

