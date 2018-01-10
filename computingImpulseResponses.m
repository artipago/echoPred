function [avec,avecR]=computingImpulseResponses(prediction,eeg,residual,param,stims)


%% compute finalVector avec (and avecR)
supportdim = 2*param.refreshrate; %number of datapoints in filter

for ii=1:size(prediction,3)
    resid(:,:,ii)=residual(:,1:end-1,ii);
end
for ii=1:size(eeg,3)
    eegSmaller(:,:,ii)=eeg(:,1:end-1,ii);
end

normstims = zscore(stims,[],1);
for ii=1:size(eegSmaller,3)
    normEEG(:,:,ii) = zscore(eegSmaller(:,:,ii),[],1);
    normResid(:,:,ii) = zscore(resid(:,:,ii),[],1);
    avec(:,:,ii)=zeros(supportdim*2+1,1);
    avecR(:,:,ii) = zeros(supportdim*2+1,1);
end

counter = 0;
for trial = 1:size(normstims,2)
    counter = counter + 1;
    
    for ii=1:size(avec,3)
        avec(:,:,ii)= avec(:,:,ii)+xcorr(normstims(:,trial),eeg(:,trial,ii),supportdim,'coeff');
        avecR(:,:,ii)= avecR(:,:,ii)+xcorr(normstims(:,trial),normResid(:,trial,ii),supportdim,'coeff');
    end
end;

for ii=1:size(avec,3)
    avec(:,:,ii)= avec(:,:,ii)/counter;
    avecR(:,:,ii)= avecR(:,:,ii)/counter;
end
for ii=1:size(avec,3)
    avec2(:,ii)= squeeze(avec(supportdim:-1:1,ii)/counter);
    avecR2(:,ii)= squeeze(avecR(supportdim:-1:1,ii)/counter);
end
avec=avec2;
avecR=avecR2;



end