clear;
clc;

n = 0:9;
beta = mod(2,5);
alpha = (5*n+beta+1)/25*pi;

%% MAE of floating-point
% ¥ON=11º¡¨¬2^-10­n¨D
N = 15;
X = zeros(1,N);
Y = zeros(1,N);
X_0 = zeros(1,10);
Y_0 = zeros(1,10);
theta_N = zeros(1,10);
for i = 1:10
    X(1) = cos(alpha(i));
    Y(1) = sin(alpha(i));
    
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
        X_s = Y(j) / (2^(j-1));
        Y_s = X(j) / (2^(j-1));
        X(j+1) = X(j) - u*X_s;
        Y(j+1) = u*Y_s + Y(j);

        X(j+1) = X(j+1);
        Y(j+1) = Y(j+1);

        element_angle(j) = atan(2^(-(j-1)));
        theta(j+1) = theta(j) - u*element_angle(j);
        theta(j+1) = theta(j+1);
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

[OutX, OutY, OutRotArray, qo]=GivensRotation(-2.8422, -8.3149, [], 0, 0)
xx = OutRotArray;
[OutX, OutY, OutRotArray]=GivensRotation(0.4436, -4.9158, xx, 1, qo)
% [OutX, OutY, OutRotArray]=GivensRotation(-9, -1, xx, 1, qo)
% [OutX, OutY, OutRotArray]=GivensRotation(-9, -6, xx, 1, qo)
% [OutX, OutY, OutRotArray]=GivensRotation(-4, -10, xx, 1, qo)