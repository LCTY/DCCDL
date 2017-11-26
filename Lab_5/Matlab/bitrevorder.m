function y = bitrevorder( x )
    % 參數
    len = length(x);        % 矩陣長度
    bit = round(log2(len)); % index_r所需位元數
    
    % 建立正常順序的index
    index = 0:len-1;
    
    % index轉為二進制後做bit-reverse
    a = flip(dec2twos(index),2);
    
    % 去除signed bit
    a = a(:,1:bit);
    
    % 將二進制index轉為十進制並存入index_r
    index_r = zeros(1,len);
    for i = 1:len
        tmp = str2double(a(i,bit));						% 每個位元: string -> double
        for j = (bit-1):-1:1
            tmp = tmp + str2double(a(i,j)) * 2^(bit-j);	% 計算十進制值
        end
        index_r(i) = tmp;								% 存入index_r
    end
	
	% 依照index_r重新排序輸入矩陣x
    y = zeros(1,len);
    for i = 1:len
        y(i) = x(round(index_r(i)+1));
    end
%     fprintf('%d\n',flip(index_r));
end

