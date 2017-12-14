function [OutX, OutY, OutRotArray, qo]=GivensRotation(InX, InY, InRotArray, Mode, qi)
	N = 30;
	X = zeros(1,N+1);
	Y = zeros(1,N+1);
	OutRotArray = zeros(1,N);
	SN = 1/sqrt( 1 + 2.^((-2).*0) );
	for i = 1:N-1
		si = 1/sqrt( 1 + 2.^((-2).*(i)) );
		SN = SN * si;
	end
	
	if Mode == 0
		
		X(1) = InX;
		Y(1) = InY;
		
		if X(1) >=0 && Y(1) >=0
			qo = 1;
		elseif X(1) <0 && Y(1) >=0
			qo = 2;
		elseif X(1) <0 && Y(1) <0
			qo = 3;
		else
			qo = 4;
		end
		
		X(1) = abs(X(1));
		Y(1) = abs(Y(1));
		
		for i = 1:N
			if Y(i) >= 0
				u = -1;
			else
				u = 1;
			end
			OutRotArray(i) = u;
			X_s = Y(i) / (2^(i-1));
			Y_s = X(i) / (2^(i-1));
			X(i+1) = X(i) - u*X_s;
			Y(i+1) = u*Y_s + Y(i);
		end
		
		OutX = X(i+1) * SN;
		OutY = Y(i+1);
		
	else
		
		X(1) = InX;
		Y(1) = InY;
		
		if qi == 1
			xs = 1; ys = 1; us = 1;
		elseif qi == 2
			xs = -1; ys = -1; us = -1;
		elseif qi == 3
			xs = -1; ys = -1; us = 1;
		else
			xs = 1; ys = 1; us = -1;
		end
		
		for i = 1:N
			u = InRotArray(i) * us;
			
			OutRotArray(i) = u;
			X_s = Y(i) / (2^(i-1));
			Y_s = X(i) / (2^(i-1));
			X(i+1) = X(i) - u*X_s;
			Y(i+1) = u*Y_s + Y(i);
		end	
		
		OutX = xs * X(i+1) * SN;
		OutY = ys * Y(i+1) * SN;
		
	end
	
end

