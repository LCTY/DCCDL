clear;
clc;

n = 0:9;
beta = mod(2,5);
alpha = (5*n+beta+1)/25*pi;

N = 11;
bit_xy = 13;
bit_t = 14;
X = zeros(1,N);
Y = zeros(1,N);
theta_N = zeros(1,10);
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
    abs([X(1) Y(1)]) * 2^13;
    
    element_angle = zeros(1,N);
    for j = 1:N
        if Y(j) >= 0
            u = -1;
        else
            u = 1;
        end
        X_s = trun( Y(j) / (2^(j-1)), bit_xy);
        Y_s = trun( X(j) / (2^(j-1)), bit_xy);
        X(j+1) = X(j) - u*X_s;
        Y(j+1) = u*Y_s + Y(j);

        X(j+1) = trun( X(j+1), bit_xy);
        Y(j+1) = trun( Y(j+1), bit_xy);

        element_angle(j) = trun( atan(2^(-(j-1))), bit_t);
        theta(j+1) = theta(j) - u*element_angle(j);
        theta(j+1) = trun( theta(j+1), bit_t);
    end
    
    if q == 1
        theta_N(i) = theta(N+1);
    elseif q == 2
        theta_N(i) = trun(pi, bit_t) - theta(N+1);
    elseif q == 3
        theta_N(i) = theta(N+1) - trun(pi, bit_t);
    else
        theta_N(i) = -theta(N+1);
    end
end
data = [0:9; theta_N * 2^bit_t];
fprintf('Index\tTheta\n');
fprintf('%d\t\t%d\n', data);