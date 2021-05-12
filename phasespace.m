figure; scatter_git(Mgamma_average,TD_ratio)

phasestates = Mstates;
phasestates(phasestates == 1) = 1;
phasestates(phasestates == 2) = 2;
phasestates(phasestates == 3) = 3;
phasestates(phasestates == 4) = 1;
phasestates(phasestates == 5) = 1;
phasestates(phasestates == 6) = 2;
phasestates(phasestates == 7) = 7;

figure; gscatter(Mgamma_average,TD_ratio,phasestates)
set(gca,'Color','k')

% figure; gscatter(EMGave,Mgamma_average,manual_output)
