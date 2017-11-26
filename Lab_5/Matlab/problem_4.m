clear; clc;

%% 初始化
% 題目
S = [1+1i, 1-1i, -1+1i, -1-1i];
rng('default');					% 初始化隨機種子
index = floor(rand(1,32)*4)+1;	% 產生32個1~4的隨機整數
Y = zeros(1, length(index));	% 宣告 Y
for i = 1:length(index)
	Y(i) = S(index(i));			% 從S中隨機挑選產生Y0~Y31
end

x = ifft(Y);			% 將Y透過ifft轉為x0~x31
x = [x zeros(1,40)];	% x31之後補0

% Stage 1~5
s1 = stage(16,5);
s2 = stage(8,5);
s3 = stage(4,5);
s4 = stage(2,5);
s5 = stage(1,5);

% ROM
rom32 = twiddle_factor(32);
rom16 = twiddle_factor(16);
rom8 = twiddle_factor(8);
rom4 = twiddle_factor(4);

% Bit-reverse reordering buffer
buffer1 = dff(32);
buffer2 = dff(32);

% Buffer control
count = 30;
select = 0;

%% 開始執行
for time = 0:70 % time 0~62
	%% Combinational stage
	s1.low_in = x(time+1);
	s1.rom = rom32(s1.idx);
	s1.comb_update;
	
	s2.low_in = s1.dff_out;
	s2.rom = rom16(s2.idx);
	s2.comb_update;
	
	s3.low_in = s2.dff_out;
	s3.rom = rom8(s3.idx);
	s3.comb_update;
	
	s4.low_in = s3.dff_out;
	s4.rom = rom4(s4.idx);
	s4.comb_update;
	
	s5.low_in = s4.dff_out;
	s5.rom = 1;
	s5.comb_update;
	
	% Buffer control
	if select == 0
		buffer1.update(s5.mul_out);
	else
		buffer2.update(s5.mul_out);
	end
	
	%% Sequential stage
	count = count + 1;
	if count > 32
		count = 1;
		select = abs(select-1);
	end
	
	s1.seq_update;
	s2.seq_update;
	s3.seq_update;
	s4.seq_update;
	s5.seq_update;
end

X = bitrevorder(flip(buffer1.value));
MAE = log2(mean(abs(X-Y)));