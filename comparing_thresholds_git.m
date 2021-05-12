%% COMPARING THRESHOLDS
% written by Kevin Wright

function [idealthresh,idealK] = comparing_thresholds(threshold,threshold_output,Mgamma_average,manual_output)

% This function tests a range of theoretical thresholds to find the ones
% with the highest possible agreement ratio and Cohen's K value. The plot output has threshold values as the x axis and either K or agreement on the y axis. The real
% threshold is then overlayed as a red line for comparison.

decreased = threshold-.001;
threshold_trials = threshold-decreased;
bottom = threshold_trials;
idealthresh = [];
idealK = [];
for q = 0.001:0.001:(decreased*8)
    threshold_trials = bottom+q;
threshold_output_trials = zeros(size(threshold_output,1),1);
for z = 1:size(Mgamma_average,1)
    if Mgamma_average(z,1) < threshold_trials
        threshold_output_trials(z,1) = 1;
    else
        threshold_output_trials(z,1) = 0;
    end
end
[verification_ratio, K] = state_verification(manual_output,threshold_output_trials);
idealthresh = [idealthresh;verification_ratio];
idealK = [idealK;K];
end

figure; plot([bottom+0.001:0.001:bottom+(decreased*8)],idealthresh);
line([threshold threshold],get(gca,'Ylim'),'Color','red');
title('agreement over varied threshold values');
figure; plot([bottom+0.001:0.001:bottom+(decreased*8)],idealK);
line([threshold threshold],get(gca,'Ylim'),'Color','red');
title('Cohens K over varied threshold values');
