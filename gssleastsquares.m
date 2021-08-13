classdef gssleastsquares
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Dependent)
        numSources
        numSensors
        numFreqBins
        W0
        
        stepVector
        
        Ryy
        C2
        J
        JC2
        delJ
        delJC2
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
        
        function obj = step(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            obj.W = obj.W - obj.stepSize * obj.stepVector;
        end
        
        function val = get.W0(obj)
            val = permute(conj(obj.D.steeringMatrix), [1 3 2]);
        end
        
        function sV = get.stepVector(obj)
            sV = obj.delJ + obj.delJC2;
        end
        
        function val = get.Ryy(obj)
            val = fRyy3(obj.W, obj.Rxx);
        end
        
        function val = get.C2(obj)
            val = fC2_2(obj.W, obj.D.steeringMatrix, obj.sourceEye);
        end
        
        function val = get.J(obj)
            val = fJ2(obj.Ryy, obj.alpha);
        end
        
        function val = get.JC2(obj)
            val = fJC2(obj.C2);
        end
        
        function val = get.delJ(obj)
            val = fdelJ2(obj.W, obj.Rxx, obj.alpha);
        end
        
        function val = get.delJC2(obj)
            val = fdelJC2_2(obj.D, obj.C2);
        end
end

