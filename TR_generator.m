% TR_file = zeros(length(Indices),3);
% for i = length(Indices)
%     TR_file(i,1) = Indices;
%     TR_file(i,2) = 1:length(Indices);
%     TR_file(i,3) = threshold_output;
% end

TR_threshold_output = threshold_output3;
indexs = find(TR_threshold_output == 1);
TR_threshold_outputTD = threshold_outputTD;
TR_threshold_output(indexs) = TR_threshold_outputTD;

TR_threshold_output(TR_threshold_output == 2) = 3;
TR_threshold_output(TR_threshold_output == 1) = 2;
TR_threshold_output(TR_threshold_output == 0) = 1;

TR_file = cell(length(Epochs) + 1,3);
TR_file{1,1} = 'Index';
TR_file{1,2} = 'Timestamps';
TR_file{1,3} = 'States';
TR_file(2:end,3) = num2cell(TR_threshold_output(:,1));

% TR_file(TR_file == 2) = 3;
% TR_file(TR_file == 1) = 2;
% TR_file(TR_file == 0) = 1;


EpochIndices = (1:length(Epochs))';
TR_file(2:end,1) = num2cell(EpochIndices(:,1));
TR_file(2:end,2) = num2cell(Epochs(:,1));

TR_file = cell2table(TR_file);
writetable(TR_file,'TR_file.xls','FileType','spreadsheet','WriteVariableNames',0);
