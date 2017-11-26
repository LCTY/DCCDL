function [ z ] = cadd( x, y )
    a = real(x);
    b = imag(x);
    c = real(y);
    d = imag(y);
    
    re = a + c;
    im = b + d;
    
    z = re + im*1i;

end

