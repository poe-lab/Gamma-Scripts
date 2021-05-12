
%% Master File - Automatic Sleep Scorer

[Epochs, Mgamma,Mstates,Mgamma_average,manual_output] = matrixconfig('PSD_1694_baseline1_whole.csv');
[MGfit,threshold,threshold_output] = gamma_thresholding0302(Mgamma_average);
[verification_ratio, K] = state_verification(manual_output,threshold_output);
[idealthresh,idealK] = comparing_thresholds(threshold,threshold_output,Mgamma_average,manual_output);
[TD_ratio,Mstates_TD,Mtheta,Mdelta] = TD_matrixconfig('PSD_1694_baseline1_whole_TD.csv');
RemoveWake
[threshold_outputTD,thresholdTD] = TD_thresholding0228(TD_ratiocopy);
[verification_ratioTD, KTD] = TD_state_verification(index9,manual_output_TD,threshold_outputTD);
[idealthreshTD,idealKTD] = TD_comparing_thresholds(index9,thresholdTD,threshold_outputTD,TD_ratiocopy,manual_output_TD);
TR_generator

%% Instructions
% In order to use this program, create PSD files using instructions, turn
% them into .csv files, and type their names into the purple text above.
% The first file is the file for the gamma range (includes 50 - 70 Hz). The
% second file is for the theta-delta range (includes 1 - 10 Hz).

% If you'd like to run without verification against a manually scored file,
% comment out both "state_verification" functions as well as both
% "comparing_thresholds" functions for gamma and TD (lines 6, 7, 11, and 12).

% Make sure to run the program with the folder open with your sample. For
% example, if you'd like to run analysis on animal 1694 post SEFL, go to
% this folder. The TR excel file (to be inputted into sleep scorer) will
% appear automatically in this folder. Be sure to rename the TR file.
