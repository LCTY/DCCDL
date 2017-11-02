clear;
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

% After truncation
x_t = 12;
h_t = 12;
m_t = 13;
a_t = 13;
x(1,:) = floor(x(1,:)*(2^x_t))/(2^x_t);
h(1,:) = floor(h(1,:)*(2^h_t))/(2^h_t);

count = 1;
mul_a = zeros(1, 96);
mul_b = zeros(1, 3072);
add_a = zeros(1, 3072);
for i = 1:96
    y(i) = floor( x(i) * h(1) *(2^m_t) ) / (2^m_t);
    
    mul_a(i) = y(i);
    for j = 2:33
        mul = floor( z(j-1) * h(j) * (2^m_t) ) / (2^m_t);
        tmp = y(i) + mul;
        y(i) = floor( tmp * (2^a_t) ) / (2^a_t);
        
        mul_b(count) = mul;
        add_a(count) = y(i);
        count = count + 1;
    end

    % update flip-flop
    z_ = z;
    for m = 2:32
        z(m) = z_(m-1);
    end
    z(1) = x(i);
end
mul_b = [mul_a mul_b];
fprintf('mul max = %f\nmul min = %f\nadd max = %f\nadd min = %f\n', ...
max(mul_b), min(mul_b), max(add_a), min(add_a));

% y to dec
disp((y*2^a_t).');