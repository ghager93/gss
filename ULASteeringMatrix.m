classdef ULASteeringMatrix < UniformLinearArray
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Dependent)
        numFreqBins
        numSources
        maxFreq
    end
    
    properties(GetAccess = public, SetAccess = private)
        aoas
        fvec
        steeringMatrix
        invCondMatrix
    end 
    
    methods
        function obj = ULASteeringMatrix(aoas, fvec, numSensors, sensorSpacing)
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            
            obj = obj@UniformLinearArray(numSensors, sensorSpacing);
            
            obj.aoas = aoas;
            obj.fvec = fvec;
            
            obj = obj.set_steeringMatrix();
            obj = obj.set_invCondMatrix();
        end
        
        function out = set_steeringMatrix(obj)
            out = exp(-2*pi*1i*obj.sensorSpacing*sin(permute(obj.aoas, [1, 3, 2]))/obj.SPEED_OF_SOUND.*freqs'.*(1:obj.numSensors));
        end
        
        function out = set_invCondMatrix(obj)  
            out = zeros(obj.numFreqBins, obj.numSensors, obj.numSources);
            for f = 1:obj.numFreqBins
                out(f) = cond(squeeze(obj.steeringMatrix(f,:,:)));
            end
            out = 1./out;
        end
        
        function val = get.numFreqBins(obj)
            val = length(obj.fvec);
        end
        
        function val = get.numSources(obj)
            val = length(obj.aoas);
        end
        
        function val = get.maxFreq(obj)
            val = max(obj.fvec);
        end
    end
            
end

