classdef ArraySTFT
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        win_length = 512
        hop = 120
        nfft = 512
    end
    
    properties(Dependent)
        win
        overlap
    end
    
    methods
        function arraySpectrumObject = stft_(obj, signals, fs)
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            [s, f, t] = stft(signals, fs, 'Window', obj.win, 'OverlapLength', obj.overlap, 'FFTLength', obj.nfft, 'FrequencyRange', 'onesided');
            arraySpectrumObject = ArraySpectrum(s, f, t);
        end
        
        function [signals, tvec] = istft_(obj, spectrums, fs)
            [signals, tvec] = istft(spectrums, fs, 'Window', obj.win, 'OverlapLength', obj.overlap, 'FFTLength', obj.nfft, 'FrequencyRange', 'onesided');
        end
        
        function win = get.win(obj)
            win = hamming(obj.win_length);
        end
        
        function overlap = get.overlap(obj)
            overlap = obj.win_length - obj.hop;
        end
        
    end
end

