%% State Verification

% This script checks the ratio and Cohen's Kappa of when manual scoring and threshold scoring
% agree on each wake/sleep state. 

function [verification_ratio, K] = state_verification(manual_output,threshold_output)

% Determines the total number of epochs
total_epochs = size(manual_output,1);

% The following creates a ratio for how often the two methods agree on each
% epoch state.
verification = zeros(size(threshold_output,1),1);
for i = 1:total_epochs
    if threshold_output(i) == manual_output(i)
        verification(i) = 1;
    else
        verification(i) = 0;
    end
end

verification_sum = sum(verification);
verification_ratio = verification_sum/total_epochs;

% for the Cohen's K value, verification_ratio = P0

%% Cohen's K Value

% Cohen's K is used to evaluate overlap between scoring methods. The
% formula is:

% K = (P0 - Pe)/(1- Pe), where:

% P0 = probability both say sleep + probability both say wake
% Pe = (p threshold says sleep) x (p manual says sleep) + (p threshold says
% wake) x (p manual says wake)

% Calculating the probability each method says sleep or wake for Pe:
TO_sleep = sum(threshold_output(:) == 1);
TO_wake = sum(threshold_output(:) == 0);
TO_probsleep = TO_sleep/total_epochs;
TO_probwake = TO_wake/total_epochs;

OM_sleep = sum(manual_output(:) == 1);
OM_wake = sum(manual_output(:) == 0);
OM_probsleep = OM_sleep/total_epochs;
OM_probwake = OM_wake/total_epochs;

% Calculation of K:
P0 = verification_ratio;
Pe = (TO_probsleep * OM_probsleep) + (TO_probwake * OM_probwake);
K = (P0-Pe)/(1-Pe);
%% Variables
% Mstates: raw output vector of the states classified by traditional manual sleep scoring, which include stages other than wake and sleep. 
% output_manual: output vector of states classified by manual scoring, but
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
%%
% K between 0.61 and 0.8 is substantial, above 0.8 is almost perfect
