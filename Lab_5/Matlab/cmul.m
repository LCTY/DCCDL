function [ z ] = cmul( x, y )
    a = real(x);
    b = imag(x);
    c = real(y);
    d = imag(y);
    
    re = a*c - b*d;
    im = b*c + a*d;
    
    z = re + im*1i;
end

