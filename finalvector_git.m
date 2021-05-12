% This tiny script is used to combine the NREM/REM, EMG, and gamma findings
% into a vector.

TOfinal = threshold_output3; % assign to output of sleep-wake
indexS = find(TOfinal == 1); % find indices of sleep 
TOfinal(indexS) = threshold_outputTD; % replace with NREM/REM findings
