
[Epochs, Mgamma,Mstates,Mgamma_average,manual_output] = matrixconfig('PSD_1694_baseline1_whole.csv');
[MGfit,threshold,threshold_output] = gamma_thresholding0302(Mgamma_average);
[verification_ratio, K] = state_verification(manual_output,threshold_output);
[idealthresh,idealK] = comparing_thresholds(threshold,threshold_output,Mgamma_average,manual_output);
[MEMG,EMGave] = EMG_matrix_config('PSD_1694_baseline1_whole_EMG.csv');
[thresholdEMG,threshold_outputEMG] = EMG_thresholding0305(EMGave);
[verification_ratioEMG, KEMG] = state_verification(manual_output,threshold_outputEMG);
EMGcheck
[verification_ratio3, K3] = state_verification(manual_output,threshold_output3);
[TD_ratio,Mstates_TD,Mtheta,Mdelta] = TD_matrixconfig('PSD_1694_baseline1_whole_TD.csv');
RemoveWake
[threshold_outputTD,thresholdTD] = TD_thresholding0228(TD_ratiocopy);
[verification_ratioTD, KTD] = TD_state_verification(index9,manual_output_TD,threshold_outputTD);
[idealthreshTD,idealKTD] = TD_comparing_thresholds(index9,thresholdTD,threshold_outputTD,TD_ratiocopy,manual_output_TD);
finalvector
TR_generator
