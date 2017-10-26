clc;

% h[n]
T = 1;
Ts = 1/8;
beta = 0.3;
n = -16:16;
t = n*Ts;
h = 1./T.*sinc(t./T).*cos(pi.*beta.*t)./(1.-(2.*beta.*t./T).^2);
stem(n, h);
xlim([-16 16]);
xticks(-16:2:16);

% 補0使得DFT趨近於DTFT
N = 1024;
H = fft(h, N);

% 算出對應頻率的y軸數值
w = 2*pi * (0:(N-1)) / N;

% 將0 ~ 2pi移至-pi ~ pi
w = fftshift(w);

% 修正y軸中間的不連續
w = unwrap(w - 2*pi);

% 讓y軸以pi為單位
w = w/pi;

% 輸出圖片
subplot(2,1,1);
H_mag_dB = mag2db(abs(fftshift(H)));
plot(w, H_mag_dB);
ylim([-50 20]);
ylabel('|H| (dB)', 'FontSize', 18);

subplot(2,1,2);
H_phase = angle(fftshift(H)) / pi;
plot(w, H_phase);
xlabel('radians / \pi', 'FontSize', 18);
ylabel('Phase / \pi', 'FontSize', 18);