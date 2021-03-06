clear; clc;

%% 初始化
% 題目
S = [1+1i, 1-1i, -1+1i, -1-1i];
rng('default');					% 初始化隨機種子
index = floor(rand(1,8)*4)+1;	% 產生8個1~4的隨機整數
Y = zeros(1, length(index));	% 宣告 Y
for i = 1:length(index)
	Y(i) = S(index(i));			% 從S中隨機挑選產生Y0~Y7
end

x = ifft(Y);			% 將Y透過ifft轉為x0~x7
x = [x zeros(1,16)];	% x7之後補0

% Stage 1~5
s1 = stage(4,3);
s2 = stage(2,3);
s3 = stage(1,3);

% ROM
rom8 = twiddle_factor(8);
rom4 = twiddle_factor(4);

% Bit-reverse reordering buffer
buffer1 = dff(8);
buffer2 = dff(8);

% Buffer control
count = 8;
select = 0;

%% 開始執行
% fprintf( 'time\tcount\tselect\tX_re\tX_im\t\n' );
for time = 0:20
	%% Combinational stage
	s1.low_in = x(time+1);
	s1.rom = rom8(s1.idx);
	s1.comb_update;
	
	s2.low_in = s1.dff_out;
	s2.rom = rom4(s2.idx);
	s2.comb_update;
	
	s3.low_in = s2.dff_out;
	s3.rom = 1;
	s3.comb_update;
	
% 	fprintf( '%d\t%d\t%d\t%f\t%f\n', time, count, select, real(s3.mul_out), imag(s3.mul_out));
	
	% Buffer control
	if select == 0
		buffer1.update(s3.mul_out);
	else
		buffer2.update(s3.mul_out);
	end
	
	%% Sequential stage
	count = count + 1;
	if count > 8
		count = 1;
		select = abs(select-1);
	end
	
	s1.seq_update;
	s2.seq_update;
	s3.seq_update;
end

%% Problem 2
% fprintf('%.4f\t%.4f\n', [real(buffer1.value); imag(buffer1.value)]);

%% Problem 3
X = bitrevorder(flip(buffer1.value));
fprintf('%.4f\t%.4f\n', [real(X); imag(X)]);

% stem(0:7, real(X));
% xlabel('n');
% ylim([-1 1]);
% title('X real-part');

% stem(0:7, imag(X));
% xlabel('n');
% ylim([-1 1]);
% title('X imaginary-part');

% stem(0:7, real(X)-real(Y));
% xlabel('n');
% title('Real-part: Difference between X and Y (diff = X-Y)');

% stem(0:7, imag(X)-imag(Y));
% xlabel('n');
% title('Imaginary-part: Difference between X and Y (diff = X-Y)');