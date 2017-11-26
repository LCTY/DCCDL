classdef stage < handle
    
    properties
        z
		dff_out
        up_in
        low_in
        up_out
        low_out
        mul_out
		idx
		rom
        mode
		multiplier
    end
    
    methods
		%% �غc�l
        function obj = stage( N, Total_stage )
			% �غc�ΰѼ�
			delay = -log2(N) + (Total_stage-1);
			
			% �}�l�غc
            obj.z			= zeros(1,N);
			obj.dff_out		= 0;
            obj.up_in		= 0;
            obj.low_in		= 0;
            obj.up_out		= 0;
            obj.low_out		= 0;
            obj.mul_out		= 0;
			if (mod(delay, N) ~= 0)	% �NROM index�ھڨC�Ū�����۰ʩ��^����
				obj.idx		= N+1-mod(delay, N);
			else
				obj.idx		= 1;
			end
			obj.rom			= 1;
			if (mod(delay, N*2) > 0) && (mod(delay, N*2) <= N)	% �Nbutterfly mode�ھڨC�Ū�����۰ʭp���l��
				obj.mode	= 1;
			else
				obj.mode	= 0;
			end
			obj.multiplier	= 1;
        end
		%% Combinational update
		function comb_update( obj )
			% �Ѽ�
			len = length(obj.z);
			
			% butterfly��J��
			obj.up_in = obj.z(len);
			
			% butterfly��X��
			[obj.up_out, obj.low_out] = butterfly(obj.up_in, obj. low_in, obj.mode);
			
			% �ھڼҦ���ܭ���
			if obj.mode == 0
				obj.multiplier = obj.rom;
			else
				obj.multiplier = 1;
			end
			
			% ���k����X
			obj.mul_out = cmul(obj.low_out, obj.multiplier);
		end
		%% Sequential update
		function seq_update( obj )
			% �Ѽ�
			len = length(obj.z);
			
			% D Flip-flop
            if len > 1
                for i = len:-1:2
                    obj.z(i) = obj.z(i-1);
                end
                obj.z(1) = obj.up_out;
            else
                obj.z = obj.up_out;
            end
			
			% ROM index�Mbuttfly mode
			obj.idx = obj.idx + 1;
			if obj.idx > len
				obj.idx = 1;
				obj.mode = abs(obj.mode - 1);
			end
			
			% ���k����X���WD Flip-flop
			obj.dff_out = obj.mul_out;
		end
    end
    
end