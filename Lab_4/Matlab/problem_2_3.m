clear;
clc;

n = 0:9;
beta = mod(2,5);
alpha = (5*n+beta+1)/25*pi;

X_0 = zeros(1,10);
Y_0 = zeros(1,10);
theta_N = zeros(1,10);

%% 作圖N - MAE
MAE = zeros(1,20);
for N = 1:20
    X = zeros(1,N);
    Y = zeros(1,N);
    for i = 1:10
        % Initial Stage
        X(1) = floor( cos(alpha(i)) * 2^10 ) / 2^10;
        Y(1) = floor( sin(alpha(i)) * 2^10 ) / 2^10;
        theta = zeros(1,N);
        if X(1) >=0 && Y(1) >=0
            q = 1;
        elseif X(1) <0 && Y(1) >=0
            q = 2;
        elseif X(1) <0 && Y(1) <0
            q = 3;
        else
            q = 4;
        end
        X_0(i) = X(1);
        Y_0(i) = Y(1);
        X(1) = abs(X(1));
        Y(1) = abs(Y(1));
		
        % Stage 0 to N-1
		element_angle = zeros(1,N);
        for j = 1:N
            if Y(j) >= 0
                u = -1;
            else
                u = 1;
            end
            X(j+1) = X(j) - u/2^(j-1)* Y(j);
            Y(j+1) = u/2^(j-1)*X(j) + Y(j);
			
			element_angle(j) = atan(2^(-(j-1)));
            theta(j+1) = theta(j) - u*element_angle(j);
        end

        if q == 1
            theta_N(i) = theta(N+1);
        elseif q == 2
            theta_N(i) = pi - theta(N+1);
        elseif q == 3
            theta_N(i) = theta(N+1) - pi;
        else
            theta_N(i) = -theta(N+1);
        end
    end
    MAE(N) = log2(mean(abs(cart2pol(X_0,Y_0) - theta_N)));
end
plot(MAE);
xlabel('N', 'fontSize', 14);
ylabel('Log2(MAE)', 'fontSize', 14);

%% MAE of floating-point
% 令N=11滿足2^-10要求
N = 11;
for i = 1:10
    X(1) = floor( cos(alpha(i)) * 2^10 ) / 2^10;
    Y(1) = floor( sin(alpha(i)) * 2^10 ) / 2^10;
    theta = zeros(1,N);
    if X(1) >=0 && Y(1) >=0
        q = 1;
    elseif X(1) <0 && Y(1) >=0
        q = 2;
    elseif X(1) <0 && Y(1) <0
        q = 3;
    else
        q = 4;
    end
    X_0(i) = X(1);
    Y_0(i) = Y(1);
    X(1) = abs(X(1));
    Y(1) = abs(Y(1));
    
	element_angle = zeros(1,N);
    for j = 1:N
        if Y(j) >= 0
            u = -1;
        else
            u = 1;
        end
        X(j+1) = X(j) - u/2^(j-1)* Y(j);
        Y(j+1) = u/2^(j-1)*X(j) + Y(j);
		
		element_angle(j) = atan(2^(-(j-1)));
        theta(j+1) = theta(j) - u*element_angle(j);
    end
    
    if q == 1
        theta_N(i) = theta(N+1);
    elseif q == 2
        theta_N(i) = pi - theta(N+1);
    elseif q == 3
        theta_N(i) = theta(N+1) - pi;
    else
        theta_N(i) = -theta(N+1);
    end
end
fprintf('MAE of floating-point:\t%10.8f\n', log2(mean(abs(cart2pol(X_0,Y_0) - theta_N))));

%% N = 11，對X(i), Y(i)的add/sub和角度的add/sub做量化分析
N = 11;
X = zeros(1,N);
Y = zeros(1,N);
MAE = zeros(3,100);
count = 1;
for bit_xy = 10:19
    for bit_t = 10:19
        for i = 1:10
            X(1) = trun( cos(alpha(i)), 10);
            Y(1) = trun( sin(alpha(i)), 10);
            theta = zeros(1,N);

            if X(1) >=0 && Y(1) >=0
                q = 1;
            elseif X(1) <0 && Y(1) >=0
                q = 2;
            elseif X(1) <0 && Y(1) <0
                q = 3;
            else
                q = 4;
            end
            X_0(i) = X(1);
            Y_0(i) = Y(1);
            X(1) = abs(X(1));
            Y(1) = abs(Y(1));

			element_angle = zeros(1,N);
            for j = 1:N
                if Y(j) >= 0
                    u = -1;
                else
                    u = 1;
                end
                X(j+1) = X(j) - u/2^(j-1)*Y(j);
                Y(j+1) = u/2^(j-1)*X(j) + Y(j);

                X(j+1) = trun( X(j+1), bit_xy);
                Y(j+1) = trun( Y(j+1), bit_xy);

                element_angle(j) = atan(2^(-(j-1)));
                theta(j+1) = theta(j) - u*element_angle(j);
                theta(j+1) = trun( theta(j+1), bit_t);
            end

            if q == 1
                theta_N(i) = theta(N+1);
            elseif q == 2
                theta_N(i) = pi - theta(N+1);
            elseif q == 3
                theta_N(i) = theta(N+1) - pi;
            else
                theta_N(i) = -theta(N+1);
            end
        end
        
        MAE(1,count) = log2(mean(abs(cart2pol(X_0,Y_0) - theta_N)));
        MAE(2,count) = bit_xy;
        MAE(3,count) = bit_t;
        count = count + 1;
    end
end
% 分析結束，選擇 bit_xy=13, bit_t=14
fprintf('MAE of fixed-point:\t\t%10.8f\n', MAE(1,35));

%% Integer word-length analysis
N = 11;
bit_xy = 13;
bit_t = 14;
X = zeros(1,N);
Y = zeros(1,N);
X_output = zeros(1,10);
Y_output = zeros(1,10);
int_word_len = zeros(3,2);
for i = 1:10
    X(1) = trun( cos(alpha(i)), 10);
    Y(1) = trun( sin(alpha(i)), 10);
    theta = zeros(1,N);
    
    if X(1) >=0 && Y(1) >=0
        q = 1;
    elseif X(1) <0 && Y(1) >=0
        q = 2;
    elseif X(1) <0 && Y(1) <0
        q = 3;
    else
        q = 4;
    end
    
    X(1) = abs(X(1));
    Y(1) = abs(Y(1));
    
    element_angle = zeros(1,N);
    for j = 1:N
        if Y(j) >= 0
            u = -1;
        else
            u = 1;
        end
        X(j+1) = X(j) - u/2^(j-1)*Y(j);
        Y(j+1) = u/2^(j-1)*X(j) + Y(j);

        X(j+1) = trun( X(j+1), bit_xy);
        Y(j+1) = trun( Y(j+1), bit_xy);

        element_angle(j) = atan(2^(-(j-1)));
        theta(j+1) = theta(j) - u*element_angle(j);
        theta(j+1) = trun( theta(j+1), bit_t);
    end
    
    if q == 1
        theta_N(i) = theta(N+1);
    elseif q == 2
        theta_N(i) = pi - theta(N+1);
    elseif q == 3
        theta_N(i) = theta(N+1) - pi;
    else
        theta_N(i) = -theta(N+1);
    end
    
    int_word_len = [...
        max(int_word_len(1,1),max(X)) ...
        min(int_word_len(1,2),min(X)); ...
        max(int_word_len(2,1),max(Y)) ...
        min(int_word_len(2,2),min(Y)); ...
        max(int_word_len(3,1),max(theta(i))) ...
        min(int_word_len(3,2),min(theta(i)))];
    X_output(i) = X(N+1);
    Y_output(i) = Y(N+1);
end
fprintf('\nInteger word-length analysis\n');
fprintf('\t\tmax\t\tmin\nX(i)\t%.4f\t%.4f\n', int_word_len(1,:));
fprintf('Y(i)\t%.4f\t%.4f\n', int_word_len(2,:));
fprintf('rad(i)\t%.4f\t%.4f\n', int_word_len(3,:));

%% 輸出 elementary angles
N = 11;
bit_t = 14;
element_angle = zeros(1,N);
element_angle_trun = zeros(1,N);
for i = 1:N
    element_angle(i) = atan(2^(-(i-1)));
    element_angle_trun(i) = trun( element_angle(i), bit_t);
end
text = [element_angle; element_angle_trun];
fprintf('\nElementary angles\nfloating-point\t\tfixed-point\n');
% fprintf('%.14f\t\t%.14f\n', text);