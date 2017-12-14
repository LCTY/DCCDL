clear;
clc;

rng('default');
N  = 5;
A = floor( rand(N, N) * 10 ) + 1;

R = A;
Q = eye(N);
for i = 1:4
	for j = i+1:N
		[R(i,i), R(j,i), OutRotArray, qo] = GivensRotation(R(i,i), R(j,i), [], 0, 0);
		for m = 1:N
			[Q(m,i), Q(m,j)] = GivensRotation(Q(m,i), Q(m,j), OutRotArray, 1, qo);
		end
		for k = i+1:N
			[R(i,k), R(j,k)] = GivensRotation(R(i,k), R(j,k), OutRotArray, 1, qo);
		end
	end
end
[a,b] = cordicqr(A);

disp('Q')
disp(real(Q))
disp('Q (Matlab cordicqr())')
disp(real(a))
disp('R')
disp(real(R))
disp('R (Matlab cordicqr())')
disp(real(b))

disp('A')
disp(A)
disp('Q*R')
disp(Q*R)