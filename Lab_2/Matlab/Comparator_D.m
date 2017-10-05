% Select maximun
function y = Comparator_D( A, B )
    if A(1) >= B(1)
        y = A;
    else
        y = B;
    end
end
