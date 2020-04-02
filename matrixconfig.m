function [Epochs, Mgamma,Mstates,Mgamma_average,manual_output] = matrixconfig(Excel_Gamma)

% Step 1. Separate Power Spectra file from other Excel files. Remove all lettered text (delete first row, replace other cells with zeroes). Save as a .csv to
% relevant folder and add to path. 
% Step 2. Run function 
% Variable descriptions at bottom of script.

Temp = []; % creates empty matrix
Temp = csvread(Excel_Gamma); % reads csv file into the Temp matrix

% The following pulls out 10 sec time epochs from the original recording to be 
% fitted into a matrix later to generate a TR file for the sleep scorer GUI 
Epochs = Temp(2:end,1);

% The following creates a vector containing each manually scored state per
% epoch:
Mstates = Temp((2:end),2);

% The following filters the power spectral matrix to only show power values between 50 and
% 70 Hz:
Mgamma = [];
[row,col] = size(Temp);
for i = 1:col  
    if Temp(1,i) < 70 && Temp(1,i) > 50
        Mgamma = [Mgamma, Temp(:,i)];
    end
end

% The following removes power values for frequencies around 60 Hz, which
% largely make up the noise signal from the equipment:
[r2,c2] = size(Mgamma);
r = [];
for ii = 1:c2
    if Mgamma(1,ii) > 59.85 && Mgamma(1,ii) < 60.15
        r = [r,ii];
    end
end

Mgamma(:,r) = [];


% The following averages the power per epoch in the gamma range:
% note to self: standard deviation idea does not work
Mgamma_copy = Mgamma;
Mgamma_copy(1,:) = []; % deletes the first row, which contains frequency range rather than power values
%stdo = nanstd(Mgamma_copy,[],2);
Mgamma_copy = mean(Mgamma_copy,2); % takes the average power value per epoch

%Mgamma_average = Mgamma_copy.*stdo;
Mgamma_average = Mgamma_copy;

% The following converts all manually scored states to wake or sleep (1 =
% sleep, 0 = wake). In the manual sleep scorer, states 1 and 4 = awake, so
% these states are converted to "0" for wake. States 2, 6, and 3 represent
% sleep, so they are converted to "1" for sleep. States 5,7,8 are
% irrelevant and have been marked 9. 

manual_output = zeros(size(Mstates,1),1);
for i = [1:size(Mstates,1)]
    if Mstates(i,1) == 2
        manual_output(i,1) = 1;
    elseif Mstates (i,1) == 6
        manual_output(i,1) = 1;
    elseif Mstates(i,1) == 4
        manual_output(i,1) = 0;
    elseif Mstates(i,1) == 1
        manual_output(i,1) = 0;
    elseif Mstates(i,1) == 3
        manual_output(i,1) = 1;
    elseif Mstates(i,1) == 5
        manual_output(i,:) = 9;
   elseif Mstates(i,1) == 7
       manual_output(i,:) = 9;
    elseif Mstates(i,1) == 8
        manual_output(i,:) = 9;
    end
end


%% Variables:
% .csv file contains all raw data, including time epochs, manually scored states, and power for each
% frequency, which needs to be filtered for gamma range (50 to 70 Hz).
% Temp: temporary matrix into which to input raw data 
% Mgamma: output of power values per epoch between 50 and 70 Hz
% Mgamma_copy: copy of Mgamma
% Mgamma_average: output of power values; takes the average of power values for each epoch between
% 50-70 Hz and averages them to give an average gamma power per epoch. 
% Mstates: a vector of manually scored states
% manual_output: a vector of ones and zeros with 1 = sleep and 0 = wake as
% determined by manual scoring
% Epochs: a vector of epoch time stamps from the original recording
