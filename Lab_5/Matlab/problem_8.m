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
x = trun(x, 11);        % x -> S0.11
x = [x zeros(1,40)];    % x31之後補0

s1 = stage_t(16);
s2 = stage_t(8);
s3 = stage_t(4);
s4 = stage_t(2);
s5 = stage_t(1);

rom32 = trun( twiddle_factor(32), 11 );
rom16 = trun( twiddle_factor(16), 11 );
rom8 = trun( twiddle_factor(8), 11 );
rom4 = trun( twiddle_factor(4), 11 );

buffer1 = dff(32);
buffer2 = dff(32);

count = 30;
select = 0;

for time = 0:70 % time 0~62
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

	%{
    fprintf( '%d\t%d\n', s1.mode, s1.dff_mode );
    fprintf( '%d\t%d\t%d\n', s1.mode, real(s1.low_in)*2^11, imag(s1.low_in)*2^11 );
    fprintf( '%d\t%d\n', real(s1.low_out)*2^11, imag(s1.low_out)*2^11 );
    fprintf( '%d\t%d\t%d\t%d\t%d\t%d\n', s1.idx, s1.mode, real(s1.low_in)*2^11, imag(s1.low_in)*2^11, real(s1.dff_out)*2^11, imag(s1.dff_out)*2^11 );
    fprintf( '%d\t%d\t%d\t%d\t%d\t%d\n', s2.idx, s2.mode, real(s2.low_in)*2^11, imag(s2.low_in)*2^11, real(s2.dff_out)*2^11, imag(s2.dff_out)*2^11 );
    fprintf( '%d\t%d\t%d\t%d\t%d\t%d\n', s3.idx, s3.mode, real(s3.low_in)*2^11, imag(s3.low_in)*2^11, real(s3.dff_out)*2^11, imag(s3.dff_out)*2^11 );
    fprintf( '%d\t%d\t%d\t%d\t%d\t%d\n', s4.idx, s4.mode, real(s4.low_in)*2^11, imag(s4.low_in)*2^11, real(s4.dff_out)*2^11, imag(s4.dff_out)*2^11 );
    fprintf( '%d\t%d\t%d\t%d\t%d\t%d\n', 1, s5.mode, real(s5.low_in)*2^11, imag(s5.low_in)*2^11, real(s5.dff_out)*2^11, imag(s5.dff_out)*2^11 );
    fprintf( '%d\t%d\t%d\t%d\t%d\n', time, count, select, real(s5.mul_out)*2^11, imag(s5.mul_out)*2^11 );
    fprintf( '%d\t%d\n', real(s5.mul_out)*2^11, imag(s5.mul_out)*2^11 );
	%}
    
    if select == 0
        buffer1.update(s5.mul_out);
    else
        buffer2.update(s5.mul_out);
    end
    
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

%{
% fprintf('Input x in decimal format\nIndex\tRe\tIm\n');
% fprintf('%d\t%d\t%d\n',[0:63; real(x)*2^11; imag(x)*2^11]);

% fprintf('Output X in decimal format\nIndex\tRe\tIm\n');
% fprintf('%d\t%d\t%d\n',[0:31; real(X)*2^11; imag(X)*2^11]);

% fprintf('ROM32 in decimal format\nIndex\tRe\tIm\n');
% fprintf('%d\t%d\t%d\n',[0:15; real(s1.rom)*2^11; imag(s1.rom)*2^11]);
% fprintf('ROM16 in decimal format\nIndex\tRe\tIm\n');
% fprintf('%d\t%d\t%d\n',[0:7; real(s2.rom)*2^11; imag(s2.rom)*2^11]);
% fprintf('ROM8 in decimal format\nIndex\tRe\tIm\n');
% fprintf('%d\t%d\t%d\n',[0:3; real(s3.rom)*2^11; imag(s3.rom)*2^11]);
% fprintf('ROM4 in decimal format\nIndex\tRe\tIm\n');
% fprintf('%d\t%d\t%d\n',[0:1; real(s4.rom)*2^11; imag(s4.rom)*2^11]);
% fprintf('ROM2 in decimal format\nIndex\tRe\tIm\n');
% fprintf('%d\t%d\t%d\n',[0; real(s5.rom)*2^11; imag(s5.rom)*2^11]);
%}