function [ X, Y ] = butterfly( x, y, mode )
	if mode == 1
		X = csub(x, y);
		Y = cadd(x, y);
	else
		X = y;
		Y = x;
	end
end