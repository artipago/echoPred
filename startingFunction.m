function startingFunction()

% starting point: it's the pipeline. 
% all the codes written by Andrea Alamia and Rufin VanRullen - Jan 2018
% @Cerco - Toulouse 

clear all; close all

selectedInput=1;
figureFlag=0;

param=definingParameters();
stims=creatingStimuli(param,selectedInput,figureFlag);

[prediction,residual,eeg,stims]=echoPred(stims,param);
[avec,avecR]=computingImpulseResponses(prediction,eeg,residual,param,stims);

videoFlag=0; %to show (=1) or not (=0) the video
plottingResults(prediction,residual,eeg,stims,avec,avecR,param,videoFlag)


analyzingTravellingWaves(avec)
analyzingTravellingWaves(prediction)




