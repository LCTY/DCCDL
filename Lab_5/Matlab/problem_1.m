clear; clc;

% �D��
S = [1+1i, 1-1i, -1+1i, -1-1i];

rng('default');					% ��l���H���ؤl
index = floor(rand(1,8)*4)+1;	% ����8��1~4���H�����

Y = zeros(1, length(index));	% �ŧi Y
for i = 1:length(index)
	Y(i) = S(index(i));			% �qS���H���D�ﲣ��Y0~Y7
end

% �NY�z�Lifft�ରx0~x7
x = ifft(Y);

% stem(0:7, real(Y));
% xlabel('n');
% title('Y real-part');

% stem(0:7, imag(Y));
% xlabel('n');
% title('Y imaginary-part');

% stem(0:7, real(x));
% xlabel('n');
% ylim([-1 1]);
% title('x real-part');

% stem(0:7, imag(x));
% xlabel('n');
% ylim([-1 1]);
% title('x imaginary-part');