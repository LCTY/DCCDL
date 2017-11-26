function [ X, Y ] = butterfly_t( x, y, mode )
    if mode == 1
        X = trun( csub(x, y), 11 );
        Y = trun( cadd(x, y), 11 );
    else
        X = y;
        Y = x;
    end
end

