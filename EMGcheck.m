%% EMG Check
% Written by Karina Keus

% This script pulls out the indices of sleep that were determined by gamma
% thresholding, then applies the EMG threshold to remove extra indices of
% wake

sleepindex = find(threshold_output == 1); % finds indices of sleep as determined by gamma
threshold_output2 = threshold_output(sleepindex); % creates a vector of just sleep indices

EMGave2 = EMGave;
EMGave2 = EMGave(sleepindex); % pulls out the indices of gamma-derived sleep from the EMG power vector

% The following assigns stages of wake:
lengthy = length(EMGave2);
TOcheck = zeros(lengthy,1);
for q = 1:lengthy
    if EMGave2(q,1) < thresholdEMG
    TOcheck(q,1) = 1;
    else
    TOcheck(q,1) = 0;
    end
end

% the following replaces the old sleep index with the new vector 
threshold_output3 = threshold_output;
threshold_output3(sleepindex) = TOcheck;
