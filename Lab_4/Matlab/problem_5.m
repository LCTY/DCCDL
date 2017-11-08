clear;
clc;

X = [1.64604949951172,1.64536094665527,1.64525222778320,1.64703178405762,1.64675712585449,1.64813804626465,1.64757919311523,1.64675712585449,1.64724540710449,1.64560127258301];

N = 11;
SN = 1/sqrt( 1 + 2.^((-2).*0) );
for i = 1:N-1
    si = 1/sqrt( 1 + 2.^((-2).*(i)) );
    SN = SN * si;
end
pow_of_2 = log2(SN);

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
        B = trun(SN, trn);
        Q = trun(X(n), trn);

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
    MAE(trn) = log2(mean(abs(answer - product)));
end
plot(MAE);
xlabel('Fraction length', 'fontSize', 14);
ylabel('Log2(MAE)', 'fontSize', 14);

trn = 11;
for n = 1:10 % 10 inputs
    % truncation
    B = trun(SN, trn);
    Q = trun(X(n), trn);

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

    product(n) = A;
end
int_word_len = [max(product) min(product)];
fprintf('\nInteger word-length analysis\n');
fprintf('\t\tmax\t\tmin\nProduct\t%.4f\t%.4f\n', int_word_len);