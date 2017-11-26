classdef dff < handle
    properties
        value
        Q
    end
    
    methods
        function obj = dff( x )
            obj.value = zeros(1,x);
            obj.Q = 0;
        end
        
        function update( obj, x )
            len = length(obj.value);
            if len > 1
                for i = len:-1:2
                    obj.value(i) = obj.value(i-1);
                end
                obj.value(1) = x;
            else
                obj.value = x;
            end
            obj.Q = obj.value(len);
        end
    end
end

