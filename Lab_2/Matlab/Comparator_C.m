function [ Max, Min ] = Comparator_C( x1, x2 )
    if x1(1) < x2(1)
        Min(1) = x1(1);
        Min(2) = x1(2);
        Max(1) = x2(1);
        Max(2) = x2(2);
    else
        Min(1) = x2(1);
        Min(2) = x2(2);
        Max(1) = x1(1);
        Max(2) = x1(2);
    end
end

