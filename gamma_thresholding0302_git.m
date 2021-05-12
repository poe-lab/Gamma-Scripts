%% GAMMA THRESHOLDING 0302

% Most updated version
% Written by Kevin Wright and Karina Keus

function [MGfit,threshold,threshold_output] = gamma_thresholding0302(Mgamma_average);
%%
% This function takes a vector as an input, which contains the average
% power between 50 and 70 Hz for each 10s time epoch in a vertical column.
% The function returns the threshold_output, or a column vector containing the
% state identification based on the calculated threshold, where 1 == sleep
% and 0 == wake, and the variable threshold.

figure; histogram(Mgamma_average, 'BinWidth',0.01);

% The distribution undergoes a transformation using the function
% sgolayfilt. It then clusters the data using fitgmdist instead of kmeans:

ansMG = Mgamma_average; % makes a copy of Mgamma_average
ansMG = sgolayfilt(ansMG,3,21); % applies sgolayfilt, parameters are random currently (looking for a better way to set these values)
cut = prctile(ansMG,99);
ansMG(ansMG > cut) = []; % percentile cut off to remove outliers
MGfit = fitgmdist(ansMG,2,'Replicates',10); % clusters using fitgmdist into two clusters, replicating 10 times


% The following plots two normal curves over each cluster.
% find average and standard deviation of each cluster, set x axes, use
% normpdf, and plot:

mu1 = MGfit.mu(1,1);
mu2 = MGfit.mu(2,1);
s1 = MGfit.Sigma(1,1,1);
s2 = MGfit.Sigma(1,1,2);
x1 = (0:0.01:10);
x2 = (0:0.01:10);
y1 = normpdf(x1,mu1,sqrt(s1));
y2 = normpdf(0:.01:10,mu2,sqrt(s2));
figure; plot(x1,y1);
hold
plot(x2, y2);

% use function InterX in order to find the intersection of these curves
Curve1 = [x1; y1];
Curve2 = [x2; y2];
intersection_curves = InterX(Curve1,Curve2);

% find threshold at the intersection of these curves. InterX is a weird
% function (would like to ultimately replace) and sometimes gives multiple
% intersection points. The following attempts to pull the correct
% intersection for the threshold.
threshold = intersection_curves(1,:);
if length(threshold) > 1
    threshold = threshold(1,2);
else
    threshold = threshold;
end

% plot original Mgamma_average histogram with the threshold in red
figure; histogram(Mgamma_average, 'BinWidth',0.1);
h = histogram(Mgamma_average,'BinWidth',0.1);
line([threshold threshold],get(gca,'Ylim'),'Color','red');

% the following assigns each epoch to a state of wake (0) or sleep (1)
% based on its gamma power value (either above or below threshold). This
% outputs to a column vector.
threshold_output = zeros(size(Mgamma_average,1),1);
for i = 1:size(Mgamma_average,1)
    if Mgamma_average(i,1) < threshold
        threshold_output(i,1) = 1;
    else
        threshold_output (i,1) = 0;
    end
end
%% Variables
% ansMG: a temporary vector copy of Mgamma_average that undergoes a
%   percentile cut off and then clustering
% MGfit: output of fitgmdist clustering
% mu1 and mu2: means derived from each cluster
% s1 and s2: "sigma" derived from each cluster, actually variance and not
%   standard deviation. Therefore, sqrt must be taken 
% x1 and x2: x values for each plot
% y1 and y2: y values for each curve, derived from normpdf
% Curve1 and Curve 2: curve information for InterX function
% intersection_curves: intersection of both normpdf curves, which serves as
%   the threhsold
% threshold: threshold value that determines sleep-wake fate of each epoch
% threshold_output: a vector containing 1s (sleep epochs) and 0s (wake
%   epochs) 
