clc;
input = fix(rand(2,12)' * 256);
for i = 1:12
    input(i,2) = i-1;
end
disp('input = '); disp(input);

layer_1 = zeros(6,2);
layer_2 = zeros(3,2);
layer_3 = zeros(2,2);

layer_1(1,:) = Comparator_B( input(1,:),input(2,:) );
layer_1(2,:) = Comparator_B( input(3,:),input(4,:) );
layer_1(3,:) = Comparator_B( input(5,:),input(6,:) );
layer_1(4,:) = Comparator_B( input(7,:),input(8,:) );
layer_1(5,:) = Comparator_B( input(9,:),input(10,:) );
layer_1(6,:) = Comparator_B( input(11,:),input(12,:) );
disp('layer_1 = '); disp(layer_1);

layer_2(1,:) = Comparator_B( layer_1(1,:),layer_1(2,:) );
layer_2(2,:) = Comparator_B( layer_1(3,:),layer_1(4,:) );
layer_2(3,:) = Comparator_B( layer_1(5,:),layer_1(6,:) );
disp('layer_2 = '); disp(layer_2);

layer_3(1,:) = Comparator_B( layer_2(1,:),layer_2(2,:) );
layer_3(2,:) = layer_2(3,:);
disp('layer_3 = '); disp(layer_3);

out = Comparator_B( layer_3(1,:),layer_3(2,:) );
disp('out = '); disp(out);