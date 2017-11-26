clear; clc;

% �D��
S = [1+1i, 1-1i, -1+1i, -1-1i];
rng('default');                 % ��l���H���ؤl
index = floor(rand(1,32)*4)+1;	% ����32��1~4���H�����
Y = zeros(1, length(index));	% �ŧi Y
for i = 1:length(index)
    Y(i) = S(index(i));         % �qS���H���D�ﲣ��Y0~Y31
end

x = ifft(Y);            % �NY�z�Lifft�ରx0~x31
x = [x zeros(1,32)];    % x31�����0

s1 = stage(16);
s2 = stage(8);
s3 = stage(4);
s4 = stage(2);
s5 = stage(1);

X = zeros(1,32);

for time = 0:62
    s1.low_in = x(time+1);
    s1.comb_update;
    
    s2.low_in = s1.mul_out;
    s2.comb_update;
    
    s3.low_in = s2.mul_out;
    s3.comb_update;
    
    s4.low_in = s3.mul_out;
    s4.comb_update;
    
    s5.low_in = s4.mul_out;
    s5.comb_update;
    
    if time >= 31
        X(time - 30) = (s5.mul_out);
    end
    
    s1.seq_update;
    s2.seq_update;
    s3.seq_update;
    s4.seq_update;
    s5.seq_update;
end

X = bitrevorder(X);
MAE = log2(mean(abs(X-Y)));