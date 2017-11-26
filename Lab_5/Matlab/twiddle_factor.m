function y = twiddle_factor( N )
    y = zeros(1, N/2);
    for idx = 1:N/2
        y(idx) = exp(-1i*2*pi*(idx-1)/N);
    end
end

