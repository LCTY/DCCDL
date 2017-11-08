function [ y ] = trun( x, n )
    y = floor( x .* 2^n ) ./ 2^n;
end

