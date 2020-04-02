%% State Verification

% This script checks the ratio of when manual scoring and threshold scoring
% agree on wake/sleep state. 


function [verification_ratioTD, KTD] = TD_state_verification(index9,manual_output_TD,threshold_outputTD);

% This function checks the output of the theta-delta thresholding method
% with manual scoring.

% The following removes indices from thet TD output vector that were
% classified as 9s:
threshold_outputTD = threshold_outputTD;
threshold_outputTD(index9) = [];

% Determines the total number of epochs
total_epochs = size(manual_output_TD,1);

% The following creates a ratio for how often the two methods agree on each
% epoch state.
verification = zeros(size(threshold_outputTD,1),1);
for i = 1:total_epochs
    if threshold_outputTD(i,1) == manual_output_TD(i,1)
        verification(i,1) = 1;
    else
        verification(i,1) = 0;
    end
end

verification_sum = sum(verification);
verification_ratioTD = verification_sum/total_epochs;

% for the Cohen's K value, verification_ratio = P0

%% Cohen's K Value

% Cohen's K is used to evaluate overlap between scoring methods. The
% formula is:

% K = (P0 - Pe)/(1- Pe), where:

% P0 = probability both say sleep + probability both say wake
% Pe = (p threshold says sleep) x (p manual says sleep) + (p threshold says
% wake) x (p manual says wake)

% Calculating the probability each method says sleep or wake for Pe:
TO_NREM = sum(threshold_outputTD(:) == 1);
TO_REM = sum(threshold_outputTD(:) == 2);
TO_probNREM = TO_NREM/total_epochs;
TO_probREM = TO_REM/total_epochs;

OM_NREM = sum(manual_output_TD(:) == 1);
OM_REM = sum(manual_output_TD(:) == 2);
OM_probNREM = OM_NREM/total_epochs;
OM_probREM = OM_REM/total_epochs;

% Calculation of K:
P0 = verification_ratioTD;
Pe = (TO_probNREM * OM_probNREM) + (TO_probREM * OM_probREM);
KTD = (P0-Pe)/(1-Pe);
%% Variables
% Mstates: raw output vector of the states classified by traditional manual sleep scoring, which include stages other than wake and sleep. 
% manual_output_theta: output vector of states classified by manual scoring, but
% converted into 1 for sleep and 0 for wake
% total_epochs: the total number of 10 second epochs of time in the
% recording
% verification: a vector containing ones and zeroes for if the manual ouput
% and the threshold output agree on whether an epoch is scored as sleep or
% wake (1 = agree, 0 = not agree)
% verification_ratio = ratio/percent of times they agree, a measure of
% accuracy
% TO_probsleep/TO_probwake = probability the threshold output produced
% either sleep or wake, respectively
% OM_probsleep/OM_probwake = probability the manual output produced sleep
% or wake, respectively
% K: Cohen's K value

% K between 0.61 and 0.8 is substantial, above 0.8 is almost perfect