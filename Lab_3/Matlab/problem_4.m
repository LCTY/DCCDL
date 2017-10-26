clc;

% h[n]
T = 1;
Ts = 1/8;
beta = 0.3;
n = -16:16;
t = n*Ts;
h = 1./T.*sinc(t./T).*cos(pi.*beta.*t)./(1.-(2.*beta.*t./T).^2);

n = 0:63;
t = n*Ts;
x = sin(2.*pi.*t./32) + cos(2.*pi.*t./4);
y_ = conv(h,x);


x = [x zeros(1,32)];
y = zeros(1,96);
z = zeros(1,32);


% % Transposed form
% for i = 1:96
%     y(i) = x(i) * h(1) + z(32);
%     
%     % update flip-flop
%     z_ = z;
%     for m = 2:32
%         z(m) = z_(m-1) + x(i) * h(34-m);
%     end
%     z(1) = x(i) * h(33);
% end


% % X truncation
% RMSE = zeros(1,20);
% for trn = 20:-1:1
%     x(1,:) = floor(x(1,:)*(2^trn))/(2^trn);
%     for i = 1:96
%         y(i) = x(i) * h(1) + z(32);
% 
%         % update flip-flop
%         z_ = z;
%         for m = 2:32
%             z(m) = z_(m-1) + x(i) * h(34-m);
%         end
%         z(1) = x(i) * h(33);
%     end
%     RMSE(trn) = log2(sqrt(mean((y_ - y).^2)));
% end
% plot(RMSE);
% ylim([-20 0]);
% yticks(-20:2:0);


% % H truncation
% RMSE = zeros(1,20);
% x_t = 13;
% x(1,:) = floor(x(1,:)*(2^x_t))/(2^x_t);
% for trn = 20:-1:1
%     h(1,:) = floor(h(1,:)*(2^trn))/(2^trn);
%     for i = 1:96
%         y(i) = x(i) * h(1) + z(32);
% 
%         % update flip-flop
%         z_ = z;
%         for m = 2:32
%             z(m) = z_(m-1) + x(i) * h(34-m);
%         end
%         z(1) = x(i) * h(33);
%     end
%     RMSE(trn) = log2(sqrt(mean((y_ - y).^2)));
% end
% plot(RMSE);
% ylim([-12 0]);
% yticks(-12:2:0);


% % Multiplication truncation
% RMSE = zeros(1,20);
% x_t = 13;
% h_t = 14;
% x(1,:) = floor(x(1,:)*(2^x_t))/(2^x_t);
% h(1,:) = floor(h(1,:)*(2^h_t))/(2^h_t);
% for trn = 20:-1:1
%     for i = 1:96
%         y(i) = floor( x(i) * h(1) * (2^trn) ) / (2^trn) + z(32);
% 
%         % update flip-flop
%         z_ = z;
%         for m = 2:32
%             z(m) = z_(m-1) + floor( x(i) * h(34-m) * (2^trn) ) / (2^trn);
%         end
%         z(1) = floor( x(i) * h(33) * (2^trn) )/ (2^trn);
%     end
%     RMSE(trn) = log2(sqrt(mean((y_ - y).^2)));
% end
% plot(RMSE);
% ylim([-11 0]);
% yticks(-11:1:0);


% % Addition truncation
% RMSE = zeros(1,20);
% x_t = 13;
% h_t = 14;
% m_t = 14;
% x(1,:) = floor(x(1,:)*(2^x_t))/(2^x_t);
% h(1,:) = floor(h(1,:)*(2^h_t))/(2^h_t);
% for trn = 20:-1:1
%     for i = 1:96
%         tmp = floor( x(i) * h(1) * (2^m_t) ) / (2^m_t) + z(32);
%         y(i) = floor( tmp * (2^trn) ) / (2^trn);
% 
%         % update flip-flop
%         z_ = z;
%         for m = 2:32
%             tmp = z_(m-1) + floor( x(i) * h(34-m) * (2^m_t) ) / (2^m_t);
%             z(m) = floor( tmp * (2^trn) ) / (2^trn);
%         end
%         z(1) = floor( x(i) * h(33) * (2^m_t) )/ (2^m_t);
%     end
%     RMSE(trn) = log2(sqrt(mean((y_ - y).^2)));
% end
% plot(RMSE);
% ylim([-10 0]);
% yticks(-10:1:0);


% % After truncation
% x_t = 13;
% h_t = 14;
% m_t = 14;
% a_t = 14;
% x(1,:) = floor(x(1,:)*(2^x_t))/(2^x_t);
% h(1,:) = floor(h(1,:)*(2^h_t))/(2^h_t);
% for i = 1:96
%     tmp = floor( x(i) * h(1) * (2^m_t) ) / (2^m_t) + z(32);
%     y(i) = floor( tmp * (2^a_t) ) / (2^a_t);
% 
%     % update flip-flop
%     z_ = z;
%     for m = 2:32
%         tmp = z_(m-1) + floor( x(i) * h(34-m) * (2^m_t) ) / (2^m_t);
%         z(m) = floor( tmp * (2^a_t) ) / (2^a_t);
%     end
%     z(1) = floor( x(i) * h(33) * (2^m_t) )/ (2^m_t);
% end
% RMSE = log2(sqrt(mean((y_ - y).^2)));
% disp(RMSE);