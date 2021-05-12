%% EMG THRESHOLDING 0305
% Most updated version
% Written by Karina Keus

function [thresholdEMG,threshold_outputEMG] = EMG_thresholding0305_git(EMGave);
%%
% This funciton takes a vector as an input (EMGave), which contains the
% average power value for EMG frequencies between 30 and 125 Hz. This
% function uses the bimodal curve for EMG power values and creates an EMG
% threshold, below which epochs are classified as sleep and above as wake.
% This acts as a secondary back up method to gamma thresholding that
% reclassifies stages of wake as stages of wake that were erroneously
% assigned sleep by gamma thresholding. The clustering method (fitgmdist
% behaves the same as it does in gamma thresholding).


figure; histogram(EMGave, 'BinWidth',0.01);

% The EMG histogram is clustered using fitgmdist. Unclear if we will use
% sgolayfilt on EMG as well

ansEMG = EMGave;
%ansEMG = sgolayfilt(ansEMG,3,21);  do we include this? will test on more
% samples
cut = prctile(ansEMG,99);
ansEMG(ansEMG > cut) = [];
EMGfit = fitgmdist(ansEMG,2,'Replicates',10);

% The following plots two normal curves over each cluster.
% find average and standard deviation of each cluster, set x axes, use
% normpdf, and plot:

mu1 = EMGfit.mu(1,1);
mu2 = EMGfit.mu(2,1);
s1 = EMGfit.Sigma(1,1,1);
s2 = EMGfit.Sigma(1,1,2);
xgm = (0:0.01:10);
x2 = (0:0.01:10);
ygm = normpdf(xgm,mu1,sqrt(s1));
y2 = normpdf(0:.01:10,mu2,sqrt(s2));
figure; plot(xgm,ygm);
hold
plot(0:.01:10, y2);

% use function InterX in order to find the intersection of these curves

Curve1 = [xgm; ygm];
Curve2 = [x2; y2];
intersection_curves = InterX(Curve1,Curve2);

% find threshold at the intersection of these curves. InterX is a weird
% function (would like to ultimately replace) and sometimes gives multiple
% intersection points. The following attempts to pull the correct
% intersection for the threshold.

thresholdEMG = intersection_curves(1,:);
if length(thresholdEMG) > 1
    thresholdEMG = thresholdEMG(1,2);
else
    thresholdEMG = thresholdEMG;
end

% plot original EMGave histogram with the threshold in red:

figure; histogram(EMGave, 500);
h = histogram(EMGave,500);
line([thresholdEMG thresholdEMG],get(gca,'Ylim'),'Color','red');

% the following assigns each epoch to a state of wake (0) or sleep (1)
% based on its EMG power value (either above or below threshold). This
% outputs to a column vector.

threshold_outputEMG = zeros(size(EMGave,1),1);
for i = 1:size(EMGave,1)
    if EMGave(i,1) < thresholdEMG
        threshold_outputEMG(i,1) = 1;
    else
        threshold_outputEMG (i,1) = 0;
    end
end
%%
