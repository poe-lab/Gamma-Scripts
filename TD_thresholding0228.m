%% GAMMA THRESHOLDING

function [threshold_outputTD,thresholdTD] = TD_thresholding0228(TD_ratiocopy);

% This function takes a vector as an input, which contains the average
% power between 50 and 70 Hz for each 10s time epoch in a vertical column.
% The function returns the threshold_output, or a column vector containing the
% state identification based on the calculated threshold, where 1 == sleep
% and 0 == wake, and the variable threshold.

figure; histogram(TD_ratiocopy, 300); % represents raw gamma power data (hopefully a somewhat bimodal distribution).
y = sgolayfilt(TD_ratiocopy,3,21);
figure; histogram(y,'BinWidth',0.01)
% The following uses kmeans clustering to separate the bimodal data into
% two clusters:

orderedTD = sort(y);
cutoff = prctile(y,99);
orderedTD(orderedTD > cutoff) = [];

[clus,centroid] = kmeans(orderedTD,2,'Replicates',50);
index1 = find(clus == 1);
index2 = find(clus == 2);
if centroid(2) > centroid(1)
    cluster1 = orderedTD(index1);
    cluster2 = orderedTD(index2);
else
    cluster2 = orderedTD(index1);
    cluster1 = orderedTD(index2);
end

%removal of outliers
outlier1 = prctile(cluster1,90); %need to make sure cluster1 is first peak
outlier2 = prctile(cluster2,95);
cluster1(cluster1 > outlier1) = [];
cluster2(cluster2 > outlier2) = [];
    
maxim = max([cluster1;cluster2]);

figure; histogram(cluster2, 200);
%set(gca,'Xscale','log');
figure; histogram(cluster1, 200);
%set(gca,'Xscale','log');

% The following creates gaussian curves over each cluster and overlays them
% so that an intersection/threshold may be found.

pdeq1 = fitdist(cluster1, 'normal');
probd1 = pdf(pdeq1, 0:0.01:maxim);
%figure, plot(probd1);
pdeq2 = fitdist(cluster2, 'normal');
probd2 = pdf(pdeq2, (.2*centroid(1)):0.01:maxim);
%hold
%plot(probd2);

% The following finds the intersection between the two curves, which is
% also known as the threshold value (below which values are characterized
% as sleep, and above which as wake).
x_cluster1 = (0:0.01:maxim);
y_cluster1 = probd1;
x_cluster2 = ((.2*centroid(1)):0.01:maxim);
y_cluster2 = probd2;

figure; plot(x_cluster1,y_cluster1)
hold on
plot(x_cluster2,y_cluster2)



Curve1 = [x_cluster1; y_cluster1];
Curve2 = [x_cluster2; y_cluster2];
intersection_curves = InterX(Curve1,Curve2);
thresholdTD = intersection_curves(1,:);
line([thresholdTD thresholdTD],get(gca,'Ylim'),'Color','red');
%xline(threshold);


% The following applies the threshold to the original raw data histogram.
figure; histogram(y, 500);
h = histogram(y,500);
line([thresholdTD thresholdTD],get(gca,'Ylim'),'Color','red');
figure; histogram(TD_ratiocopy,'BinWidth',0.01);
line([thresholdTD thresholdTD],get(gca,'Ylim'),'Color','red');
%xline(threshold);

% The following assigns the raw gamma power data per epoch a
% characterization as either sleep (1) or wake (0) and outputs this to a
% vector named 'threshold_output'.
threshold_outputTD = zeros(size(TD_ratiocopy,1),1);
for i = 1:size(TD_ratiocopy,1)
    if TD_ratiocopy(i,1) < thresholdTD
        threshold_outputTD(i,1) = 1;
    else
        threshold_outputTD (i,1) = 2;
    end
end

%% Variables
% threshold: the value of the threshold (a measure of gamma power, above
%   which is classified as wake and below which is classified as sleep)
% threshold_output: a vector of ones and zeroes where 1 is sleep and 0 is wake, as determined by the threshold, each cell corresponds to a
%   10 s epoch and can be compared to the vector derived from the manual
%   scoring output (accomplished with function state_verification) 