clear;
clc;


X = [1.64604949951172,1.64536094665527,1.64525222778320,1.64703178405762,1.64675712585449,1.64813804626465,1.64757919311523,1.64675712585449,1.64724540710449,1.64560127258301];
% X = [1.64497375488281,1.64129257202148,1.64223670959473,1.64278984069824,1.64555549621582,1.64706230163574,1.64347648620605,1.64381980895996,1.64308738708496,1.64442253112793];

%% calculate Scaling factor
N = 11;
SN = 1/sqrt( 1 + 2.^((-2).*0) );
for i = 1:N-1
    si = 1/sqrt( 1 + 2.^((-2).*(i)) );
    SN = SN * si;
end

%% Calculate required truncation bit
% 這個階段尚未知道需要幾個bit，因此使用sequential方式實現乘法，
% 等決定了確切的fraction length後，再改用combinational實現。
%{
A (Product)
B (Multiplicand)
Q (Multiplier)
%}
answer = zeros(1,10);
product = zeros(1,10);
MAE = zeros(1,20);
for trn = 1:20
    for n = 1:10 % 10 inputs
        % truncation
        B = trun(X(n), trn);
        Q = trun(SN, trn);

        % bin -> dec and initialization
        B = B * 2^trn;
        Q = flip( dec2twos( Q*2^trn ) );
        A = 0;
        
        % calculation
        for i = 1:length(Q)
            if Q(i) == '1'
                A = A + B;
            end
            B = B * 2;  % Shift B left
        end
        A = A / 2^(trn*2);

        % save data
        answer(n) = SN * X(n);
        product(n) = A;
    end
    MAE(trn) = log2(mean(abs(1 - product)));
end
plot(MAE);
xlabel('Fraction length', 'fontSize', 14);
ylabel('Log2(MAE)', 'fontSize', 14);

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
    product(n) = A;
end

int_word_len = [max(product) min(product)];
fprintf('\nInteger word-length analysis\n');
fprintf('\t\tmax\t\tmin\nProduct\t%.4f\t%.4f\n', int_word_len);