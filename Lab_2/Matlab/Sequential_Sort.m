clc;
N = 12;
input = fix(rand(2,N)' * 256);
for i = 1:N
    input(i,2) = i-1;
end
disp('input = '); disp(input);

dff = [255 0];
for i = 1:N
    [dff(1), dff(2)] = Mux( ...
        input(i,:), ...
        dff, ...
        Comparator( input(i,1), dff(1) ) ...
    );
end
disp('dff = '); disp(dff);

stem(input(:,1));
hold on;
stem(dff(1));
axis([0, 13, 0, 255]);