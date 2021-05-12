%% EMG MATRIX CONFIG
% Written by Karina Keus

function [MEMG,EMGave] = EMG_matrix_config_git(Excel_EMG);

% This function takes a .csv file of EMG power values and outputs multiple
% matrices and vectors that are necessary for other scripts to run.

Temp = []; % creates empty matrix
Temp = csvread(Excel_EMG); % reads csv file into the Temp matrix in the same manner as matrix_config

MEMG = Temp;

MEMG(:,1:3) = []; % removes the first three columns, which contain irrelevant information

% The following removes power values for frequencies around 60 Hz, which
% contain noise signals from the equipment.
[~,col] = size(MEMG);
r = [];
for ii = 1:col
    if MEMG(1,ii) > 59.85 && MEMG(1,ii) < 60.15
        r = [r,ii];
    end
end

MEMG(:,r) = [];

% The following removes frequencies below 30 Hz
[~,col2] = size(MEMG);
r2 = [];
for i = 1:col2
    if MEMG(1,i) < 30 
        r2 = [r2,i];
    end
end

MEMG(:,r2) = [];

% The following removes the first row, which contains frequencies rather
% than power values, and then takes the average EMG power value per epoch
% in a column vector
EMGave = MEMG;
EMGave(1,:) = [];
EMGave = mean(EMGave,2);

%% Variables
% Temp: temporary matrix
% MEMG: matrix of EMG values
% EMGave: vector of average EMG values per 10 s time epoch
