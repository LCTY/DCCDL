clear;
clc;

X = [1.64611816406250,1.64587402343750,1.64550781250000,1.64697265625000,1.64672851562500,1.64831542968750,1.64819335937500,1.64697265625000,1.64770507812500,1.64562988281250];

%% Simulate the actual system(combinational)
trn = 11;
product = zeros(1,10);
for n = 1:10
    % truncation and initialization
    B = trun(X(n), trn);
    B = B * 2^trn;
    
    % combinational logic, S(11) = 010011011011
    A = B*2^0 + B*2^1 + B*2^3 + B*2^4 + B*2^6 + B*2^7 + B*2^10;
    
    % dec to fixed-point
    A = A / 2^(trn*2);
    
    % save data
    product(n) = trun( A, trn );
end

data = [0:9; product * 2^trn];
fprintf('Index\tMag\n');
fprintf('%d\t\t%d\n', data);