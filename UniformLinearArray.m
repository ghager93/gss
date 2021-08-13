classdef UniformLinearArray
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant)
        SPEED_OF_SOUND = 343
    end
    
    properties(GetAccess = public, SetAccess = private)
        numSensors
        sensorSpacing
    end
    
    properties
        buffer = 1000
    end
    
    methods
        function obj = UniformLinearArray(numSensors, sensorSpacing)
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here
            obj.numSensors = numSensors;
            obj.sensorSpacing = sensorSpacing;
        end
        
        function [output_signal, fs] = observe(obj, sources, observe_length)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            fs = min([sources.fs]);

            output_signal = zeros(obj.numSensors, observe_length);
            delay = obj.sensorSpacing/obj.SPEED_OF_SOUND * sin([sources.AoA]);
            
            for i = 1:obj.numSensors
                idelay = floor(i * delay .* [sources.fs]);
                for j = 1:length(sources)
                    output_signal(i,:) = output_signal(i,:) + sources(j).signal(obj.buffer-idelay(j):obj.buffer-idelay(j)+observe_length-1);
                end
            end
        end
        
        function out = steeringmatrix(obj, aoas, freqs)
            out = ULASteeringMatrix(aoas, freqs, obj.numSensors, obj.sensorSpacing);
        end
    end
end

