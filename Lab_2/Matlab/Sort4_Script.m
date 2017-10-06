clc;
N = 4;
input = fix(rand(2,N)' * 256);
for i = 1:N
    input(i,2) = i-1;
end
disp('input = '); disp(input);

disp('output = '); disp(Sort4(input));