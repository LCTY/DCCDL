clear;
clc;

rng('default');
N  = 5;
A = floor( rand(N, N) * 10 ) + 1

[a1, a2] = cart2pol(A(1,1), A(2,1))
for i = 2:N
	[b1, b2] = cart2pol(A(1,i), A(2,i));
	b1 = b1 - a1;
	[x, y] = pol2cart(b1, b2);
	fprintf('%.4f\t%.4f\n', x, y);
end