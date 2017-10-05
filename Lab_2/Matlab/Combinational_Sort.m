clc;
input = fix(rand(2,8)' * 256);
for i = 1:8
    input(i,2) = i-1;
end
disp(input);

Out = Comparator_B( ...
        Comparator_B( Comparator_B(input(1,:),input(2,:)), Comparator_B(input(3,:),input(4,:)) ), ...
        Comparator_B( Comparator_B(input(5,:),input(6,:)), Comparator_B(input(7,:),input(8,:)) ) ...
    );

disp(Out);