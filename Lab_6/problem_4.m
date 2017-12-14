clear;
clc;

rng('default');
N  = 3;
A = floor( rand(N, N) * 10 ) + 1;
B = (floor( rand(N, N) * 10 ) + 1) * 1i;

A = A + B;
R = A;
Q = eye(N);
for i = 1:N
	for j = i+1:N
		[tmp_x, tmp_y, OutRotArray_y, qo_y] = GivensRotation(real(R(j,i)), imag(R(j,i)), [], 0, 0);
		R(j,i) = tmp_x + tmp_y * 1i;
		[tmp_x, tmp_y, OutRotArray_x, qo_x] = GivensRotation(real(R(i,i)), imag(R(i,i)), [], 0, 0);
		R(i,i) = tmp_x + tmp_y * 1i;
		[R(i,i), R(j,i), OutRotArray, qo] = GivensRotation(R(i,i), R(j,i), [], 0, 0);
		for m = 1:N
			[tmp_x, tmp_y] = GivensRotation(real(Q(m,j)), imag(Q(m,j)), OutRotArray_y, 1, qo_y);
			Q(m,j) = tmp_x + tmp_y * 1i;
			[tmp_x, tmp_y] = GivensRotation(real(Q(m,i)), imag(Q(m,i)), OutRotArray_x, 1, qo_x);
			Q(m,i) = tmp_x + tmp_y * 1i;
			[real_x, real_y] = GivensRotation(real(Q(m,i)), real(Q(m,j)), OutRotArray, 1, qo);
			[imag_x, imag_y] = GivensRotation(imag(Q(m,i)), imag(Q(m,j)), OutRotArray, 1, qo);
			Q(m,i) = real_x + imag_x * 1i;
			Q(m,j) = real_y + imag_y * 1i;
		end
		for k = i+1:N
			[tmp_x, tmp_y] = GivensRotation(real(R(j,k)), imag(R(j,k)), OutRotArray_y, 1, qo_y);
			R(j,k) = tmp_x + tmp_y * 1i;
			[tmp_x, tmp_y] = GivensRotation(real(R(i,k)), imag(R(i,k)), OutRotArray_x, 1, qo_x);
			R(i,k) = tmp_x + tmp_y * 1i;
			[real_x, real_y] = GivensRotation(real(R(i,k)), real(R(j,k)), OutRotArray, 1, qo);
			[imag_x, imag_y] = GivensRotation(imag(R(i,k)), imag(R(j,k)), OutRotArray, 1, qo);
			R(i,k) = real_x + imag_x * 1i;
			R(j,k) = real_y + imag_y * 1i;
		end
	end
end
i = N; j = N;
[tmp_x, tmp_y, OutRotArray_x, qo_y] = GivensRotation(real(R(j,i)), imag(R(j,i)), [], 0, 0);
R(j,i) = tmp_x + tmp_y * 1i;
for m = 1:N
	[tmp_x, tmp_y] = GivensRotation(real(Q(m,j)), imag(Q(m,j)), OutRotArray_x, 1, qo_y);
	Q(m,j) = tmp_x + tmp_y * 1i;
end
Q(:) = real(Q(:)) - imag(Q(:)) * 1i;

[a,b] = qr(A);

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