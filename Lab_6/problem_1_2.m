clear;
clc;

rng('default');
N  = 5;
A = floor( rand(N, N) * 10 ) + 1;
Q = zeros(N,N);
R = zeros(N,N);
for i = 1:N
	u = A(:,i);
	for j = 1:i-1
		R(j,i)=Q(:,j).' * A(:,i);
		u = u - R(j,i) * Q(:,j);
	end
	R(i,i) = norm(u);
	Q(:,i) = u / R(i,i);
end
[a, b] = qr(A);

disp('Q')
disp(real(Q))
disp('Q (Matlab qr())')
disp(real(a))
disp('R')
disp(real(R))
disp('R (Matlab qr())')
disp(real(b))

disp('A')
disp(A)
disp('Q*R')
disp(Q*R)