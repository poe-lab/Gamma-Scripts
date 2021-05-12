function [idealthreshTD,idealKTD] = TD_comparing_thresholds_git(index9,thresholdTD,threshold_outputTD,TD_ratiocopy,manual_output_TD)

decreased = thresholdTD-.001;
threshold_trialsTD = thresholdTD-decreased;
bottom = threshold_trialsTD;
idealthreshTD = [];
idealKTD = [];
for q = 0.001:0.001:(decreased*2)
    threshold_trialsTD = bottom+q;
threshold_output_trials = zeros(size(threshold_outputTD,1),1);
for z = 1:size(TD_ratiocopy,1)
    if TD_ratiocopy(z,1) < threshold_trialsTD
        threshold_output_trials(z,1) = 1;
    else
        threshold_output_trials(z,1) = 2;
    end
end
[verification_ratioTD, KTD] = TD_state_verification(index9,manual_output_TD,threshold_output_trials);
idealthreshTD = [idealthreshTD;verification_ratioTD];
idealKTD = [idealKTD;KTD];
end

figure; plot([bottom+0.001:0.001:bottom+(decreased*2)],idealthreshTD);
line([thresholdTD thresholdTD],get(gca,'Ylim'),'Color','red');
title('TD agreement over varied threshold values');
figure; plot([bottom+0.001:0.001:bottom+(decreased*2)],idealKTD);
line([thresholdTD thresholdTD],get(gca,'Ylim'),'Color','red');
title('TD Cohens K over varied threshold values');
