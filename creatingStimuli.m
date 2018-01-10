function stims=creatingStimuli(param,selectedInput,figureFlag)

% param: 
% defined in definingParameters

% selectedInput:
% 0: no input
% 1: random sequence (white noise)
% 2: sinusoid
% 3: short staircase [zeros ones zeros]
% 4: impulse [zeors 1 zeros]

% figureFlag: 
% 0: nothing is plotted
% 1: the stimulus is plotted (one random trial)
% 2: all the possible stimuli are plotted (one random trial)

%inside this function there are predetermined parameters (e.g. the time of the impulse for input 4)

framenumber = round(param.stimduration * param.refreshrate);

%% generate stimuli

stims0=zeros(framenumber,param.trialnumber);

scounter = 1;
while scounter <= param.trialnumber
    %generate a random luminance trial
    stimulus1 = rand(1,framenumber);
    stimfft = fft(stimulus1);
    stimfft= stimfft ./ abs(stimfft);  
    stimulus1 = ifft(stimfft);
    stimulus1 = (stimulus1-mean(stimulus1))/std(stimulus1); 
    stimulus1 = round((param.maxInputValue/2)+(param.maxInputValue/2)*stimulus1/1.7); 
    stimulus1(stimulus1<0)=0; stimulus1(stimulus1>param.maxInputValue)=param.maxInputValue;  
    stims1(:,scounter) = stimulus1;

    stimulus2=sin(2*pi*param.freqInput*(1:framenumber)./param.refreshrate);
    stimulus2 = (stimulus2-mean(stimulus2))/std(stimulus2);  
    stimulus2 = round((param.maxInputValue/2)+(param.maxInputValue/2)*stimulus2/1.7);  
    stimulus2(stimulus2<0)=0; stimulus2(stimulus2>param.maxInputValue)=param.maxInputValue;  
    stims2(:,scounter) = stimulus2;

    stims3(:,scounter) = [zeros(1,round(param.refreshrate)) param.maxInputValue*ones(1,round(param.refreshrate)) zeros(1,framenumber-2*param.refreshrate)];

    stimulus4=zeros(1,framenumber);
    stimulus4(param.timeImpulse)=param.maxInputValue;
    stims4(:,scounter) = stimulus4;
    scounter = scounter+1;
end
    
    
if selectedInput==0
    stims=stims0;
elseif selectedInput==1
    stims=stims1;
elseif selectedInput==2 
    stims=stims2;
elseif selectedInput==3 
    stims=stims3;
elseif selectedInput==4 
    stims=stims4;
end


if figureFlag==1
    randomTrial=ceil(param.trialnumber*rand(1));
    figure 
    plot(stims(:,randomTrial))
elseif figureFlag==2
    randomTrial=ceil(param.trialnumber*rand(1));
    figure
    subplot(2,2,1)
    plot(stims1(:,randomTrial))
    axis([-10 framenumber+10 -10 param.maxInputValue+10])
    subplot(2,2,2)
    plot(stims2(:,randomTrial))
    axis([-10 framenumber+10 -10 param.maxInputValue+10])
    subplot(2,2,3)
    plot(stims3(:,randomTrial))
    axis([-10 framenumber+10 -10 param.maxInputValue+10])
    subplot(2,2,4)
    plot(stims4(:,randomTrial))
    axis([-10 framenumber+10 -10 param.maxInputValue+10])
end









