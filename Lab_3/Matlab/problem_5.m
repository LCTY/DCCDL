clear;
clc;

% h[n]
T = 1;
Ts = 1/8;
beta = 0.3;
n = -16:16;
t = n*Ts;
h = 1./T.*sinc(t./T).*cos(pi.*beta.*t)./(1.-(2.*beta.*t./T).^2);
h_ = h;
xlim([-16 16]);
xticks(-16:2:16);
n = 0:63;
t = n*Ts;
x = sin(2.*pi.*t./32) + cos(2.*pi.*t./4);
y_ = conv(h,x);
x = [x zeros(1,32)];
y = zeros(1,96);
z = zeros(1,32);

% Direct form after truncation
x_t = 12;
h_t = 12;
m_t = 13;
a_t = 13;
x(1,:) = floor(x(1,:)*(2^x_t))/(2^x_t);
h_(1,:) = floor(h_(1,:)*(2^h_t))/(2^h_t);
for i = 1:96
    y(i) = floor( x(i) * h_(1) *(2^m_t) ) / (2^m_t);
    for j = 2:33
        tmp = y(i) + floor( z(j-1) * h_(j) * (2^m_t) ) / (2^m_t);
        y(i) = floor( tmp * (2^a_t) ) / (2^a_t);
    end

    % update flip-flop
    z_ = z;
    for m = 2:32
        z(m) = z_(m-1);
    end
    z(1) = x(i);
end

% % Transposed form after truncation
% x_t = 13;
% h_t = 14;
% m_t = 14;
% a_t = 14;
% x(1,:) = floor(x(1,:)*(2^x_t))/(2^x_t);
% h_(1,:) = floor(h_(1,:)*(2^h_t))/(2^h_t);
% for i = 1:96
%     tmp = floor( x(i) * h_(1) * (2^m_t) ) / (2^m_t) + z(32);
%     y(i) = floor( tmp * (2^a_t) ) / (2^a_t);
% 
%     % update flip-flop
%     z_ = z;
%     for m = 2:32
%         tmp = z_(m-1) + floor( x(i) * h_(34-m) * (2^m_t) ) / (2^m_t);
%         z(m) = floor( tmp * (2^a_t) ) / (2^a_t);
%     end
%     z(1) = floor( x(i) * h_(33) * (2^m_t) )/ (2^m_t);
% end

% ��0�ϱoDFT�ͪ��DTFT
N = 1024;
H = fft(h, N);
H_ = fft(y, N) ./ fft(x, N);
% ��X�����W�v��y�b�ƭ�
w = 2*pi * (0:(N-1)) / N;
% �N0 ~ 2pi����-pi ~ pi
w = fftshift(w);
% �ץ�y�b���������s��
w = unwrap(w - 2*pi);
% ��y�b�Hpi�����
w = w/pi;

% ��X�Ϥ�
H_mag_dB = mag2db(abs(fftshift(H)));
H_hat_mag_dB = mag2db(abs(fftshift(H_)));
plot(w, H_mag_dB);
hold on;
plot(w, H_hat_mag_dB);
ylim([-50 20]);
xlabel('radians / \pi', 'FontSize', 18);
ylabel('|H| (dB)', 'FontSize', 18);

% H_phase = angle(fftshift(H)) / pi;
% H_hat_phase = angle(fftshift(H_)) / pi;
% plot(w, H_phase);
% hold on;
% plot(w, H_hat_phase);
% xlabel('radians / \pi', 'FontSize', 18);
% ylabel('Phase / \pi', 'FontSize', 18);
