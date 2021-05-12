function [idealthreshEMG,idealKEMG] = EMG_comparing_thresholds_git(thresholdEMG,threshold_outputEMG,EMGave,manual_output)

decreased = thresholdEMG-.001;
threshold_trialsTD = thresholdEMG-decreased;
bottom = threshold_trialsTD;
idealthreshEMG = [];
idealKEMG = [];
for q = 0.001:0.001:(decreased*2)
    threshold_trialsTD = bottom+q;
threshold_output_trials = zeros(size(threshold_outputEMG,1),1);
for z = 1:size(EMGave,1)
    if EMGave(z,1) < threshold_trialsTD
        threshold_output_trials(z,1) = 1;
    else
        threshold_output_trials(z,1) = 0;
    end
end
[verification_ratioTD, KTD] = state_verification(manual_output,threshold_output_trials);
idealthreshEMG = [idealthreshEMG;verification_ratioTD];
idealKEMG = [idealKEMG;KTD];
end

figure; plot([bottom+0.001:0.001:bottom+(decreased*2)],idealthreshEMG);
line([thresholdEMG thresholdEMG],get(gca,'Ylim'),'Color','red');
title('EMG agreement over varied threshold values');
figure; plot([bottom+0.001:0.001:bottom+(decreased*2)],idealKEMG);
line([thresholdEMG thresholdEMG],get(gca,'Ylim'),'Color','red');
title('EMG Cohens K over varied threshold values');
