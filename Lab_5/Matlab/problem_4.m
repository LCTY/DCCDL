clear; clc;

% 題目
S = [1+1i, 1-1i, -1+1i, -1-1i];
rng('default');                 % 初始化隨機種子
index = floor(rand(1,32)*4)+1;	% 產生32個1~4的隨機整數
Y = zeros(1, length(index));	% 宣告 Y
for i = 1:length(index)
    Y(i) = S(index(i));         % 從S中隨機挑選產生Y0~Y31
end

x = ifft(Y);            % 將Y透過ifft轉為x0~x31
x = [x zeros(1,32)];    % x31之後補0

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