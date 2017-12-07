clear; clc;

% 題目
S = [1+1i, 1-1i, -1+1i, -1-1i];

rng('default');					% 初始化隨機種子
index = floor(rand(1,8)*4)+1;	% 產生8個1~4的隨機整數

Y = zeros(1, length(index));	% 宣告 Y
for i = 1:length(index)
	Y(i) = S(index(i));			% 從S中隨機挑選產生Y0~Y7
end

% 將Y透過ifft轉為x0~x7
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