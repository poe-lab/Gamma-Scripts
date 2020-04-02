function [TD_ratio,Mstates_TD,Mtheta,Mdelta] = TD_matrixconfig(Excel_Theta)

% Step 1. Separate Power Spectra file from other Excel files, save as a .csv to
% relevant folder and add to path.
% Step 2. Run function on a file that says "..._TD.csv" 
% Variable descriptions at bottom of script.

Temp = []; % creates empty matrix
Temp = csvread(Excel_Theta); % reads csv file into the Temp matrix

% The following filters the matrix to only show power values between 5 and
% 10 Hz (theta range):
Mtheta = [];
[row,col] = size(Temp);
for i = 1:col  
    if Temp(1,i) < 10 && Temp(1,i) > 5
        Mtheta = [Mtheta, Temp(:,i)];
    end
end

% Following takes the average theta power for all epochs and multiplies it by the standard deviation.
Mtheta_copy = Mtheta;
Mtheta_copy(1,:) = [];
%stdo = nanstd(Mtheta_copy,[],2);
Mtheta_copy = mean(Mtheta_copy,2);

Mtheta_average = Mtheta_copy;
%Mtheta_average = Mtheta_copy.*stdo;

% The following filters the matrix to only show power values between 2 and
% 5 Hz (delta range):
Mdelta = [];
[row,col] = size(Temp);
for i = 1:col  
    if Temp(1,i) < 5 && Temp(1,i) > 2
        Mdelta = [Mdelta, Temp(:,i)];
    end
end

% Takes average delta power for each epoch
Mdelta_copy = Mdelta;
Mdelta_copy(1,:) = [];
%std02 = nanstd(Mdelta_copy,[],2);
Mdelta_copy = mean(Mdelta_copy,2);
Mdelta_average = Mdelta_copy;
%Mdelta_average = Mdelta_copy.*std02;

% The following creates a column vector of the ratio between theta and
% delta (theta power/delta power)
rows = size(Mdelta_average,1);
TD_ratio = zeros(rows,1);
for ii = 1:rows
    TD_ratio(ii,1) = Mtheta_average(ii,1)/Mdelta_average(ii,1);
end

% The following creates a vector containing each manually scored state per
% epoch:
Mstates_TD = Temp((2:end),2);


%% Variables:
% .csv file contains all raw data, including time epochs, manually scored states, and power for each
% frequency
% Temp: temporary matrix into which to input raw data 
% TD_ratio: column vector of power values for the ratio between averaged theta and averaged delta
%   power
%
