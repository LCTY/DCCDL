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
x_t = 13;
h_t = 14;
m_t = 14;
a_t = 14;
x(1,:) = floor(x(1,:)*(2^x_t))/(2^x_t);
h(1,:) = floor(h(1,:)*(2^h_t))/(2^h_t);

count = 1;
mul_a = zeros(1, 96);
mul_b = zeros(1, 3072);
mul_c = zeros(1, 96);
add_a = zeros(1, 96);
add_b = zeros(1, 3072);
for i = 1:96
    mul = floor( x(i) * h(1) * (2^m_t) ) / (2^m_t);
    tmp = mul + z(32);
    y(i) = floor( tmp * (2^a_t) ) / (2^a_t);
    
    mul_a(i) = mul;
    add_a(i) = y(i);
    
    % update flip-flop
    z_ = z;
    for m = 2:32
        mul = floor( x(i) * h(34-m) * (2^m_t) ) / (2^m_t);
        tmp = z_(m-1) + mul;
        z(m) = floor( tmp * (2^a_t) ) / (2^a_t);
        
        mul_b(count) = mul;
        add_b(count) = z(m);
        count = count + 1;
    end
    z(1) = floor( x(i) * h(33) * (2^m_t) )/ (2^m_t);
    
    mul_c(i) =  z(1);
end
mul_c = [mul_a mul_b mul_c];
add_b = [add_a add_b];
fprintf('mul max = %f\nmul min = %f\nadd max = %f\nadd min = %f\n', ...
max(mul_c), min(mul_c), max(add_b), min(add_b));

% y to dec
disp((y*2^a_t).');