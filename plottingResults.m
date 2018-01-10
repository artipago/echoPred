function plottingResults(prediction,residual,eeg,stims,avec,avecR,param,videoFlag)

% videoFlag: if 1 it shows the video.
% all other inputs come from echoPred as results of the simulation; except for param and stims defined before echoPred. 


supportdim = 2*param.refreshrate; %number of datapoints in filter

randTrial=ceil(param.trialnumber*rand(1));

times = [1:supportdim]*1000/param.refreshrate; %in ms
eegRandomTrial=squeeze(eeg(:,randTrial,:));

for ii=1:size(eegRandomTrial,2)
    eegRandomTrialnew(:,ii)=zscore(eegRandomTrial(:,ii));
end


if videoFlag==1
    figure
        
    for ii=1:10:size(eeg,1)

        subplot(2,2,1)
        cla
        hold on
        plot(eegRandomTrial)
        myLim=get(gca,'ylim');
        plot([ii ii],myLim)
        set(gca,'ylim',myLim)
        title('not zscored')
        legend({'L1','L2','L3','L4','L5'})

        subplot(2,2,2)
        cla
        hold on
        plot(eegRandomTrialnew(:,1))
        myLim2=get(gca,'ylim');
        plot([ii ii],myLim2)
        set(gca,'ylim',myLim2)
        title('zscored')

        subplot(2,2,3)
        imagesc(eegRandomTrialnew(ii,:))
        set(gca,'clim',myLim2)
        colorbar

        subplot(2,2,4)
        plot(eegRandomTrialnew(ii,:))
        set(gca,'ylim',myLim2)
        pause(.00001)
    end
end





%% additional figures

figure
subplot(2,1,1)
cla
hold on
plot(eegRandomTrial)
myLim=get(gca,'ylim');
plot([ii ii],myLim)
set(gca,'ylim',myLim)
title('eegAv')
for ii=1:size(avec,2)
    legendStr{ii}=['L' int2str(ii)];
end

subplot(2,2,3)
hold on
plot(times,avec); title('IRF EEG')
for ii=1:size(avec,2)
    legendStr{ii}=['L' int2str(ii)];
end
legend(legendStr)

subplot(2,2,4)
hold on
plot(times,avecR); title('IRF residual ')
legend(legendStr)




figure
for ii=1:size(avec,2)
    subplot(2,ceil(size(avec,2)/2),ii)
    hold on
    plot(times,avec(:,ii));
    title(['IRF - L' int2str(ii)])
end

figure
for ii=1:size(prediction,3)
    subplot(2,ceil(size(prediction,3)/2),ii)
    hold on
    plot((prediction(:,randTrial,ii)),'r');
    plot((residual(:,randTrial,ii)),'b');
    if ii==1
        plot((stims(:,randTrial)),'--k')
    else
        plot((prediction(:,randTrial,ii-1)),'k');
    end
    title(['L' int2str(ii)])
    legend('pred','residual','input')
    xlim([3900 4300 ])
    
end



end















