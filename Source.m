classdef Source
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        signal = 0;
        fs = 0;
        AoA = 0;
    end
    
    methods
        function obj = Source(signal, fs, AoA)
            %UNTITLED3 Construct an instance of this class
            %   Detailed explanation goes here
            
            if nargin == 0
                return;
            end
            
            obj.signal = signal;
            obj.fs = fs;
            obj.AoA = AoA;
        end
    end
end

