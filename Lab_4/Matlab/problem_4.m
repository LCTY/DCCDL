clear;
clc;
N=15;
error = zeros(1,N);
for i=1:N
    error(i) = 1 - ( 1 / sqrt( 1 + 2^(-2*(i-1)) ) );
end
plot(error*100);
xlabel('N', 'fontSize', 14);
ylabel('Error(%)', 'fontSize', 14);
