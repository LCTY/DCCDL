clear; clc;

% �D��
S = [1+1i, 1-1i, -1+1i, -1-1i];

rng('default');                 % ��l���H���ؤl
index = floor(rand(1,8)*4)+1;	% ����8��1~4���H�����

Y = zeros(1, length(index));	% �ŧi Y
for i = 1:length(index)
    Y(i) = S(index(i));         % �qS���H���D�ﲣ��Y0~Y7
end

% �NY�z�Lifft�ରx0~x7
x = ifft(Y);

% scatter(real(x), imag(x));
% set(gca,'XAxisLocation','origin');
% set(gca,'YAxisLocation','origin');
% scatter(real(Y), imag(Y));
% set(gca,'XAxisLocation','origin');
% set(gca,'YAxisLocation','origin');