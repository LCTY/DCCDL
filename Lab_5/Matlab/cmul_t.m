function [ z ] = cmul_t( x, y )
    a = real(x);
    b = imag(x);
    c = real(y);
    d = imag(y);
    
    re = trun(a*c,11) - trun(b*d,11);
    im = trun(b*c,11) + trun(a*d,11);
    
    z = trun( re + im*1i, 11 );
end

