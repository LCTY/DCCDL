clc;
s = [1 0 1 0 1];
s_origin = s;
s_old = zeros(1, length(s));
coef = [1 1 1 0 1 1];

auto = zeros(1,N);
auto_k = zeros(1,N+1);
d_in = [1 1 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 1 1];
d_1_out = zeros(1,N);
d_2_out = zeros(1,N);
N = length(d_in);

% % Scrambler
% for i = 1:N
%     temp = s(length(s));
%     for j = length(s):-1:2
%         if coef(j) == 1
%             temp = xor(temp, s(j-1));
%         end
%     end
%     
%     for j = length(s):-1:2
%         s(j) = s(j-1);
%     end
%     s(1) = xor(temp,d_in(i));
%     d_1_out(i) = s(1);
%     disp([d_in(i) temp d_1_out(i)]);
% end
% disp(d_1_out);
% stem(d_1_out);


% % Descrambler
% s = s_origin;
% for i = 1:N
%     if i < (N+1)
%         auto(i) = s(length(s));
%     end
%     
%     temp = s(length(s));
%     for j = length(s):-1:2
%         if coef(j) == 1
%             temp = xor(temp, s(j-1));
%         end
%     end
%     
%     for j = length(s):-1:2
%         s(j) = s(j-1);
%     end
%     s(1) = d_1_out(i);
%     d_2_out(i) = xor(temp,d_1_out(i));
% end
% disp(d_2_out);
% stem(d_2_out);


% % Error
% error = d_2_out - d_in;
% stem(error);


% % Autocorrelation
% auto = d_1_out;
% k_array = zeros(1,N+1);
% count = 1;
% for k = -N/2:N/2
%     k_array(count) = k;
%     sum = 0;
%     for i = 1:N
%         ik = mod(i+k,N);
%         if ik == 0
%             ik = N;
%         elseif ik < 0
%             ik = ik + N;
%         end
%         
%         sum = sum + (-1)^(auto(i)) * (-1)^(auto(ik));
%         auto_k(count) = sum / (N+1);
%     end
%     count = count + 1;
% end
% 
% plot(k_array, auto_k);
% title(['autocorrelation of M-sequence when N = ', num2str(N)]);
% xlabel('shift k');
% ylabel('periodic autocorrelation');