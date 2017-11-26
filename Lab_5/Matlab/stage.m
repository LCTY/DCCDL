classdef stage < handle
    
    properties
        z
        up_in
        low_in
        up_out
        low_out
        mul_out
        mode
		rom
		idx
		multiplier
    end
    
    methods
        function obj = stage( N )
            obj.z			= zeros(1,N);
            obj.up_in		= 0;
            obj.low_in		= 0;
            obj.up_out		= 0;
            obj.low_out		= 0;
            obj.mul_out		= 0;
            obj.mode		= 0;
			obj.rom			= twiddle_factor(N*2);
			obj.idx			= 1;
			obj.multiplier	= obj.rom(1);
        end
		
		function comb_update( obj )
			len = length(obj.z);
			
			obj.up_in = obj.z(len);
			[obj.up_out, obj.low_out] = butterfly(obj.up_in, obj. low_in, obj.mode);
			
			
			if obj.mode == 0
				obj.multiplier = obj.rom(obj.idx);
			else
				obj.multiplier = 1;
			end
			obj.mul_out = cmul(obj.low_out, obj.multiplier);
		end
		
		function seq_update( obj )
			len = length(obj.z);
						
            if len > 1
                for i = len:-1:2
                    obj.z(i) = obj.z(i-1);
                end
                obj.z(1) = obj.up_out;
            else
                obj.z = obj.up_out;
            end
			
			obj.idx = obj.idx + 1;
			if obj.idx > len
				obj.idx = 1;
				obj.mode = abs(obj.mode - 1);
			end
			
		end
    end
    
end

