clc;
N = 24;
input = fix(rand(2,N)' * 256);
for i = 1:N
    input(i,2) = i-1;
end
disp('InputArray');
disp(input);

disp('SelectTop6');
count = zeros(1,6);
for i = 1:6
    out = Comparator_Tree( ...
        [Mux4( Sort4(input(1:4,:)), count(1) ) 1; ...
        Mux4( Sort4(input(5:8,:)), count(2) ) 2; ...
        Mux4( Sort4(input(9:12,:)), count(3) ) 3; ...
        Mux4( Sort4(input(13:16,:)), count(4) ) 4; ...
        Mux4( Sort4(input(17:20,:)), count(5) ) 5; ...
        Mux4( Sort4(input(21:24,:)), count(6) ) 6] ...
    );
    disp(out(1:2));
    
    count(out(3)) = count(out(3)) + 1;
end

disp('Answer');
answer = sort(input,'descend');
disp(answer(1:6,1));