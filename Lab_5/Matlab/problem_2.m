clear; clc;

% �D��
S = [1+1i, 1-1i, -1+1i, -1-1i];
rng('default');                 % ��l���H���ؤl
index = floor(rand(1,8)*4)+1;	% ����8��1~4���H�����
Y = zeros(1, length(index));	% �ŧi Y
for i = 1:length(index)
    Y(i) = S(index(i));         % �qS���H���D�ﲣ��Y0~Y7
end

x = ifft(Y);            % �NY�z�Lifft�ରx0~x7
x = [x zeros(1,8)];    % x7�����0


s3 = stage(4);
s2 = stage(2);
s1 = stage(1);

y = zeros(1,8);

for time = 0:14
    s3.low_in = x(time+1);
    s3.comb_update;
    
    s2.low_in = s3.mul_out;
    s2.comb_update;
    
    s1.low_in = s2.mul_out;
    s1.comb_update;
    
    if time >= 7
        y(time - 6) = (s1.mul_out);
    end
    
    s3.seq_update;
    s2.seq_update;
    s1.seq_update;
end

y = bitrevorder(y);
MAE = log2(mean(abs(y-Y)));