classdef ArraySpectrum
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess = public, SetAccess = private)
        spectrum = 0;
        fvec = 0;
        tvec = 0;
    end
    
    properties(Dependent)
        numSensors
        numFreqBins
        numTimeBins
        maxFreq
        maxTime
    end
    
    methods
        function obj = ArraySpectrum(spectrum, fvec, tvec)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            if nargin == 0
                return
            end
            
            obj.spectrum = spectrum;
            obj.fvec = fvec;
            obj.tvec = tvec;
        end
        
        function segmentArray = segment(obj, windowLength)
           numSegments = floor(obj.numTimeBins/windowLength);
           cutoff = mod(obj.numTimeBins, windowLength);
           segmentDimensions = [obj.numFreqBins obj.numTimeBins windowLength numSegments];
           
           spectrumSegments = reshape(obj.spectrum(:, :, 1:end-cutoff), segmentDimensions);
           tvecSegments = reshape(obj.tvec(:, :, 1:end-cutoff), segmentDimensions);
           
           segmentArray(numSegments) = ArraySpectrumSegment();
           for i = 1:numSegments
               segmentArray(i) = ArraySpectrumSegment(spectrumSegments(:, :, :, i), obj.fvec, tvecSegments(:, :, :, i));
           end
               
        end
        
        function Rxx = rxx(obj)
        
        function val = get.numSensors(obj)
            val = size(obj.spectrum, 3);
        end
        
        function val = get.numFreqBins(obj)
            val = length(obj.fvec);
        end
        
        function val = get.numTimeBins(obj)
            val = length(obj.tvec);
        end
        
        function val = get.maxFreq(obj)
            val = max(obj.fvec);
        end
        
        function val = get.maxTime(obj)
            val = max(obj.tvec);
        end
    end
end

