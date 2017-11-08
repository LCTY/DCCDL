clear;
clc;

N = 100;
SN = 1/sqrt( 1 + 2.^((-2).*0) );
for i = 1:N-1
    si = 1/sqrt( 1 + 2.^((-2).*(i)) );
    SN = SN * si;
end
fprintf('Scaling factor: %.8f\n', SN);
