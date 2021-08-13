classdef ArraySpectrumSegment < ArraySpectrum
    
    properties(Dependent)
        windowLength
    end
    
    methods
        function obj = ArraySpectrumSegment(data)
            obj = obj@ArraySpectrum(data);
        end
        
        function val = get.windowLength(obj)
            val = obj.numTimeBins;
        end
    end
end