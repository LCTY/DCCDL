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

% % ��Xx[n]�Ϥ�
% plot(n, x);
% len = (length(n)-1)/2;
% xlim([-len len])
% xticks(-len:32:len)
% hold on;
% % ��Xy[n]�Ϥ�
% len = len + 16;
% plot(-len:len,y,'-.');
% xlim([-len len])
% lgd = legend('x[n]','y[n]');
% lgd.FontSize = 18;
% % ylim([-10 10]);
% % xticks(-len:32:len);


% ��0�ϱoDFT�ͪ��DTFT
N = 1024;
X = fft(x, N);
H = fft(h, N);
Y = fft(y, N);
% ��X�����W�v��y�b�ƭ�
w = 2*pi * (0:(N-1)) / N;
% �N0 ~ 2pi����-pi ~ pi
w = fftshift(w);
% �ץ�y�b���������s��
w = unwrap(w - 2*pi);
% ��y�b�Hpi�����
w = w/pi;
% ��XX�W�v�T���Ϥ�
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

% % ��XH�W�v�T���Ϥ�
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
% % ��XY�W�v�T���Ϥ�
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