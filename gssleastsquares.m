classdef gssleastsquares
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Dependent)
        numSources
        numSensors
        numFreqBins
        W0
    end
    
    properties(Access = private)
        Rxx
        D
        
        alpha
        W
        
        invCondD
        sourceEye
        
        delta
        iLoop
    end
    
    properties
        deltaThreshold = 0.01;
        stepSize = 0.1;
    end
       
    methods
        function obj = gssleastsquares(Rxx, D)
            %UNTITLED8 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Rxx = Rxx;
            obj.D = D;
            
            obj = obj.setalpha(obj);
            obj = obj.initW(obj);
            obj = obj.seteye(obj);
        end
        
        function obj = setalpha(obj)
            obj.alpha = fAlpha2(obj.Rxx);
        end
        
        function obj = initW(obj)
            obj.W = obj.W0;
        end
        
        function obj = seteye(obj)
            obj.sourceEye = permute(repmat(eye(obj.numSources), [1,1,F]), [3 1 2]);
        end
        
        function val = get.W0(obj)
            val = permute(conj(obj.D.steeringMatrix), [1 3 2]);
        end
        
        function sV = stepVector(obj)
            Ryy = fRyy(obj.W, obj.Rxx);
            C2 = fC2_2(obj.W, obj.D.steeringMatrix, obj.sourceEye);
            delJ = fdelJ2(obj.W, obj.Rxx, obj.alpha);
            delJC2;
            
        end
        
        function dJ = delJ(obj)
            Ryy = fRyy(obj.W, obj.Rxx)
            
        
        function step(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            obj.W = obj.W - obj.stepSize * (delJ + delJC2);
        end
    end
end

