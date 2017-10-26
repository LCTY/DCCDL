clc;

% h[n]
T = 1;
Ts = 1/8;
beta = 0.3;
n = -16:16;
t = n*Ts;
h = 1./T.*sinc(t./T).*cos(pi.*beta.*t)./(1.-(2.*beta.*t./T).^2);

n = -512:512;
t = n*Ts;
x = sin(2.*pi.*t./32) + cos(2.*pi.*t./4);
y = conv(h,x);

% % 輸出x[n]圖片
% plot(n, x);
% len = (length(n)-1)/2;
% xlim([-len len])
% xticks(-len:32:len)
% hold on;
% % 輸出y[n]圖片
% len = len + 16;
% plot(-len:len,y,'-.');
% xlim([-len len])
% lgd = legend('x[n]','y[n]');
% lgd.FontSize = 18;
% % ylim([-10 10]);
% % xticks(-len:32:len);


% 補0使得DFT趨近於DTFT
N = 1024;
X = fft(x, N);
H = fft(h, N);
Y = fft(y, N);
% 算出對應頻率的y軸數值
w = 2*pi * (0:(N-1)) / N;
% 將0 ~ 2pi移至-pi ~ pi
w = fftshift(w);
% 修正y軸中間的不連續
w = unwrap(w - 2*pi);
% 讓y軸以pi為單位
w = w/pi;
% 輸出X頻率響應圖片
% subplot(2,1,1);
H_mag_dB = mag2db(abs(fftshift(X)));
plot(w, H_mag_dB);
% xlim([-1 1]);
% ylim([-50 80]);
% ylabel('|X| (dB)', 'FontSize', 18);
% subplot(2,1,2);
% H_phase = angle(fftshift(X))/pi;
% plot(w, H_phase);
% xlabel('radians / pi', 'FontSize', 18);
% ylabel('Phase / pi', 'FontSize', 18);

% % 輸出H頻率響應圖片
% subplot(2,1,1);
H_mag_dB = mag2db(abs(fftshift(H)));
plot(w, H_mag_dB);
% ylim([-50 20]);
% ylabel('|X| (dB)', 'FontSize', 18);
% subplot(2,1,2);
% H_phase = angle(fftshift(X))/pi;
% plot(w, H_phase);
% xlabel('radians / pi', 'FontSize', 18);
% ylabel('Phase / pi', 'FontSize', 18);
% 
% % 輸出Y頻率響應圖片
% subplot(2,1,1);
H_mag_dB = mag2db(abs(fftshift(Y)));
plot(w, H_mag_dB);
% ylim([-50 80]);
% ylabel('|Y| (dB)', 'FontSize', 18);
% subplot(2,1,2);
% H_phase = angle(fftshift(Y))/pi;
% plot(w, H_phase);
% xlabel('radians / pi', 'FontSize', 18);
% ylabel('Phase / pi', 'FontSize', 18);