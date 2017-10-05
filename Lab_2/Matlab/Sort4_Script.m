clc;
N = 12;
input = fix(rand(2,N)' * 256);
for i = 1:N
    input(i,2) = i-1;
end
disp(input);

Sort4(input);