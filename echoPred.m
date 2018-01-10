function [prediction,residual,eeg,stims]=echoPred(stims,param)

% initiliazing parameters, predictions and residuals

framenumber = round(param.stimduration * param.refreshrate);

prediction(:,:,1) = zeros(framenumber,param.trialnumber+1);
residual(:,:,1) = zeros(framenumber,param.trialnumber+1);
eeg(:,:,1) = zeros(framenumber,param.trialnumber+1);

for ii=2:length(param.t_LGN_V1)
    prediction(:,:,ii) = zeros(framenumber,param.trialnumber+1);
    residual(:,:,ii) = zeros(framenumber,param.trialnumber+1);
    eeg(:,:,ii) = zeros(framenumber,param.trialnumber+1);
end

% actual model computing predictions and residuals
scounter = 1;
while scounter < param.trialnumber+1
    for time = 1:framenumber
        prediction(time,scounter,1) = param.epsilon(1)*param.maxInputValue*randn(1) +prediction(max(1,time-param.update_cycletime),scounter,1) + (param.w(1,1)* param.update_cycletime/param.Tau(1))*residual(max(1,time-param.update_cycletime-param.t_LGN_V1(1)),scounter,1) + param.decay*(param.update_cycletime/param.Tau2) * param.w(1,2)* ( prediction(max(1,time-param.update_cycletime),scounter,2) - prediction(max(1,time-param.update_cycletime),scounter,1))  ; %param.with optional decay term
        residual(time,scounter,1) =  stims(max(1,time-param.t_stim_LGN),scounter,1) -  param.lambda * prediction(max(1,time-param.t_V1_LGN(1)),scounter,1);
        eeg(time,scounter,1) = prediction(time,scounter,1);

        for ii=2:length(param.t_LGN_V1)-1
            prediction(time,scounter,ii) = param.epsilon(ii)*param.maxInputValue*randn(1) + prediction(max(1,time-param.update_cycletime),scounter,ii) + (param.w(ii,1)* param.update_cycletime/param.Tau(ii))*residual(max(1,time-param.update_cycletime-param.t_LGN_V1(ii)),scounter,ii) + param.decay*(param.update_cycletime/param.Tau2) * param.w(ii,2)* (prediction(max(1,time-param.update_cycletime),scounter,ii+1) - prediction(max(1,time-param.update_cycletime),scounter,ii))  ; %param.with optional decay term
            residual(time,scounter,ii) =  prediction(max(1,time),scounter,ii-1) - param.lambda * prediction(max(1,time-param.t_V1_LGN(ii)),scounter,ii); 
            eeg(time,scounter,ii) = prediction(time,scounter,ii);
        end
        ii=length(param.t_LGN_V1);
        
        prediction(time,scounter,ii) = param.epsilon(ii)*param.maxInputValue*randn(1) + prediction(max(1,time-param.update_cycletime),scounter,ii) + (param.w(ii,1) * param.update_cycletime/param.Tau(ii)) * residual(max(1,time-param.update_cycletime-param.t_LGN_V1(ii)),scounter,ii) - param.decay*(param.update_cycletime/param.Tau2) * param.w(ii,2) * prediction(max(1,time-param.update_cycletime),scounter,ii); 
        residual(time,scounter,ii) =  prediction(max(1,time),scounter,ii-1) -  param.lambda * prediction(max(1,time-param.t_V1_LGN(ii)),scounter,ii); 
        eeg(time,scounter,ii) = prediction(time,scounter,ii);
            
    end;
    scounter = scounter+1;
end



end

