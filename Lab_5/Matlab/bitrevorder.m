function y = bitrevorder( x )
    len = length(x);
    bit = round(log2(len));
    idx = 0:len-1;
    a = flip(dec2twos(idx),2);
    a = a(:,1:bit);
    index = zeros(1,len);
    
    for i = 1:len
        tmp = str2double(a(i,bit));
        for j = (bit-1):-1:1
            tmp = tmp + str2double(a(i,j)) * 2^(bit-j);
        end
        index(i) = tmp;
    end
    y = zeros(1,len);
    for i = 1:len
        y(i) = x(round(index(i)+1));
    end
%     fprintf('%d\n',flip(index));
end

