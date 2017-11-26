function y = bitrevorder( x )
    % �Ѽ�
    len = length(x);        % �x�}����
    bit = round(log2(len)); % index_r�һݦ줸��
    
    % �إߥ��`���Ǫ�index
    index = 0:len-1;
    
    % index�ର�G�i��ᰵbit-reverse
    a = flip(dec2twos(index),2);
    
    % �h��signed bit
    a = a(:,1:bit);
    
    % �N�G�i��index�ର�Q�i��æs�Jindex_r
    index_r = zeros(1,len);
    for i = 1:len
        tmp = str2double(a(i,bit));						% �C�Ӧ줸: string -> double
        for j = (bit-1):-1:1
            tmp = tmp + str2double(a(i,j)) * 2^(bit-j);	% �p��Q�i���
        end
        index_r(i) = tmp;								% �s�Jindex_r
    end
	
	% �̷�index_r���s�Ƨǿ�J�x�}x
    y = zeros(1,len);
    for i = 1:len
        y(i) = x(round(index_r(i)+1));
    end
%     fprintf('%d\n',flip(index_r));
end

