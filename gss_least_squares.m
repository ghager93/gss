classdef gss_least_squares
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    % Public, tunable properties
    properties
        n_sources;
        n_sensors;
        n_freq_bins;
        steering_matrix;
        
        cost_delta_threshold = 0.01;
        step_size = 0.1;
        max_loops = 1000;
    end
    
    properties(Access = private)
        eye_f;
        steering_matrix_inverse_condition_number_array;
        normalising_array;
        observed_csd;
        weight_matrix;
    end
    
    methods
        function obj = gss_least_squares(steering_matrix)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            
            [obj.n_freq_bins, obj.n_sensors, obj.n_sources] = size(steering_matrix);
            obj.steering_matrix = steering_matrix;
            obj.eye_f = permute(repmat(eye(obj.n_sources), [1,1,obj.n_freq_bins]), [3 1 2]);
            obj.steering_matrix_inverse_condition_number_array = f_steering_matrix_inverse_condition_number_array(obj);
            
        end
        
        function condD_inv = f_steering_matrix_inverse_condition_number_array(obj)
            condD = zeros(size(obj.steering_matrix));
            for f = 1:obs.n_freq_bins
                condD(f) = cond(squeeze(obj.steering_matrix(f,:,:)));
            end
            condD_inv = 1./condD;
        end
        
        function alpha = f_normalising_array(obj)
            % J(W) normaliser
            [F, N_frame, ~, ~] = size(obj.observed_csd);
            alpha = zeros(F,1);

            for f = 1:F
                for t = 1:N_frame
                    alpha(f) = alpha(f) + norm(squeeze(obj.observed_csd(f,t,:,:)),'fro');
                end
            end
            alpha = 1./alpha.^2;
        end
        
        function weights = init_weight_matrix(obj)
            weights = 
        
        function weights = run(obj, observed_csd)
            obj.observed_csd = observed_csd;
            obj.normalising_array = obj.f_normalising_array(obj);
        end
    end
end

