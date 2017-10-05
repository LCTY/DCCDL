clc;
input = fix(rand(2,8)' * 256);
for i = 1:8
    input(i,2) = i-1;
end
disp(input);

dff = [255 0];
for i = 1:8
    [dff(1), dff(2)] = Mux( ...
        input(i,:), ...
        dff, ...
        Comparator( input(i,1), dff(1) ) ...
    );
end

disp(dff);
