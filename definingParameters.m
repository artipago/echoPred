function param=definingParameters()


%% stimulus and experimental parameters
param.update_cycletime = 1; %in refresh frames, this is Delta_t, the time step of the predictive coding

param.stimduration = 6.25; %in second;

param.trialnumber = 100;
param.refreshrate = 1000;

param.maxInputValue=255; %refers to all inputs 
param.timeImpulse=4000; %refers to input 4
param.freqInput=2; %refers to input 2

%% important biological parameters : 


param.lambda = 1; %parameter controlling the amount of feedback: strict feedforward when lambda = 0, full predictive coding when lambda = 1
% param.lambda = .9; %parameter controlling the amount of feedback: strict feedforward when lambda = 0, full predictive coding when lambda = 1
param.decay = 1;
param.Tau2 = 200; %50; %decay time constant (separate from integration)
param.t_stim_LGN = 0;

numberLayer=8;

param.t_LGN_V1=12*ones(1,numberLayer);
param.t_V1_LGN=12*ones(1,numberLayer);
param.Tau=17*ones(1,numberLayer);



% the noise is a percentage of the prediction

% no noise
param.epsilon=zeros(1,numberLayer); 

% constant noise
% param.epsilon=0.05*ones(1,numberLayer);

% rank up noise
% e1=0;
% e2=0.20;
% param.epsilon=e1:((e2-e1)/(numberLayer-1)):e2;
% param.epsilon=e2:-((e2-e1)/(numberLayer-1)):e1;

% param.epsilon=[0 0 0 0.1 0.3 0.4 0.4 0.5];




% setting the weights w:

% constant weights I
param.w=[ones(numberLayer,1) ones(numberLayer,1)];

% constant weights II
% param.w=[.6*ones(numberLayer,1) 0.8*ones(numberLayer,1)];

% rank up weights
% w1=0.4;
% w2=1;
% scaleW=w1:((w2-w1)/(numberLayer-1)):w2;
% scaleWrev=w2:-((w2-w1)/(numberLayer-1)):w1;
% param.w=[scaleW' scaleW'];
% param.w=[scaleWrev' scaleWrev'];
% param.w=[scaleW' scaleWrev'];
% param.w=[scaleWrev' scaleW'];





