clc;
s = [1 0 1 0 1];
s_old = zeros(1, length(s));
coef = [1 0 1 0 0 1];
N = 2^length(s) - 1;
auto = zeros(1,N);
auto_k = zeros(1,N+4);

% % 1.(a)
% for i = 1:(N+1)
%     if i < (N+1)
%         auto(i) = s(1);
%     end
%     
%     for k = 1:length(s)
%         s_old(k) = s(k);
%     end
%     disp(s);
%     
%     for j = 1:length(s)-1
%         if coef(j+1) == 1
%             s(j) = xor(s_old(j+1), s_old(1));
%         else
%             s(j) = s_old(j+1);
%         end
%     end
%     s(length(s)) = s_old(1);
% end


% 1.(b)
for i = 1:(N+1)
    if i < (N+1)
        auto(i) = s(length(s));
    end
    disp(s);
    
    temp = s(length(s));
    for j = length(s):-1:2
        if coef(j) == 1
            temp = xor(temp, s(j-1));
        end
    end
    
    for j = length(s):-1:2
        s(j) = s(j-1);
    end
    s(1) = temp;
end


% % Autocorrelation
% disp(auto);
% k_array = zeros(1,N+3);
% count = 1;
% for k = -4:N+3
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
% title('autocorrelation of M-sequence');
% xlabel('shift k');
% ylabel('periodic autocorrelation');