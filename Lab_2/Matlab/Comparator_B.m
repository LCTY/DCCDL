function y = Comparator_B( A, B )
    [y(1), y(2)] = Mux( A, B, Comparator( A, B ) );
end
