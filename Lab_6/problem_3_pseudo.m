clear;
clc;

rng('default');
N  = 5;
A = floor( rand(N, N) * 10 ) + 1;

R = A
for i = 1:N
	for j = i+1:N
		alpha = norm([R(i,i) R(j,i)]);
		c = R(i,i) / alpha
		s = R(j,i) / alpha
		r1 = c*R(i,i:N) + s*R(j,i:N);
		r2 = -s*R(i,i:N) + c*R(j,i:N);
		R(i,i:N) = r1;
		R(j,i:N) = r2
	end
end
[a,b] = givensqr(A);