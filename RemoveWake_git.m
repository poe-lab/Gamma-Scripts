%% Removing indices of wake

% The following script is used to perform theta-delta thresholding ONLY on
% indices that were determined to be sleep by both gamma thresholding and
% EMG thresholding. Any variable with a "copy" at the end has had these
% indices of wake removed.

index = find(threshold_output3 == 0); % finds indices of wake
threshold_outputcopy = threshold_output3;
threshold_outputcopy(index) = [];
% Mtheta(index,:) = [];
%  Mdelta(index,:) = [];
Mstatescopy = Mstates;
Mstatescopy(index) = [];
Mstates_TDcopy = Mstates_TD; % Mstates_TD should be the same values as Mstates if they come from the same PSD file
Mstates_TDcopy(index) = [];
TD_ratiocopy = TD_ratio;
TD_ratiocopy(index) = [];
manual_outputcopy = manual_output;
manual_outputcopy(index) = [];

manual_output_TD9 = Mstates_TDcopy;

% The following assigns 1, 2, or 9 to a vector containing the manual
% output. 9s are indices that were not classifed as wake or sleep by manual
% scoring.

manual_output_TD9(manual_output_TD9 == 1) = 9;
manual_output_TD9(manual_output_TD9 == 2) = 1;
manual_output_TD9(manual_output_TD9 == 3) = 2;
manual_output_TD9(manual_output_TD9 == 4) = 9;
manual_output_TD9(manual_output_TD9 == 5) = 9;
manual_output_TD9(manual_output_TD9 == 6) = 1;
manual_output_TD9(manual_output_TD9 == 7) = 9;
manual_output_TD9(manual_output_TD9 == 8) = 9;

% The following finds the indices that were classified as 9s and removes
% them so that manual and thresholding NREM/REM distinction can be
% appropriately compared

index9 = find(manual_output_TD9 == 9);
manual_output_TD = manual_output_TD9;
manual_output_TD(index9) = [];


%% Variables
% threhold_output: a vector of ones and zeroes where 1 is sleep and 0 is wake, as determined by the threshold, each cell corresponds to a
%   10 s epoch and can be compared to the vector derived from the manual
%   scoring output
% Mstates: a vector of manually scored states
% TD_ratio: a vector of averaged power values of the ratio between theta
%   and delta power per each 10 sec epoch, determined by PSD output
% manual_output: a vector of ones and zeros with 1 = sleep and 0 = wake as
%   determined by manual scoring
% manual_output_theta: epochs pulled from the indices of sleep (from gamma
%   thresholding) and characterized by manual scoring, then converted to 1
%   for NREM and 0 for REM, with 9 being any other (irrelevant) state 

