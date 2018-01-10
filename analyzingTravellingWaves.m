function analyzingTravellingWaves(avec)

%avec comes from echoPred
if length(size(avec))==3
    randTrial=ceil(size(avec,2)*rand(1));
    avec=squeeze(avec(:,randTrial,:));
end

%few parameters to set
timeWindow=200;
bins=10;

x=1:timeWindow:(timeWindow*bins)+1;
a=1; %width pixel to compute the frequency

arrangedAvec=avec';
avecFFT=abs(fftshift(fft2(arrangedAvec)));

[m,n]=size(arrangedAvec); %numberPixel x and y

fx=(1/a)*((1:n)-mean(1:n));
fy=(1/a)*((1:m)-mean(1:m));

[thX1,thX2]=findingXboundaries(avecFFT,fx);

figure
subplot(2,1,1)
surf(arrangedAvec)
shading interp; view(0,90); axis tight; colorbar;
subplot(2,2,3)
surf(fx,fy,avecFFT)
shading interp; view(0,90); axis tight; colorbar;
set(gca,'xlim',[thX1 thX2],'clim',[min(min(avecFFT)) max(max(avecFFT))],'yscale','lin');
subplot(2,2,4)
avecFFT(avecFFT==0)=NaN;
upperPart=avecFFT(fy>0,(fx>0 & fx<thX2));
lowerPart=avecFFT(fy<0,(fx>0 & fx<thX2));
bar([1 2],[mean(upperPart(:)) mean(lowerPart(:))])


m=8;
n=timeWindow;
a=1;
fx=(1/a)*((1:n)-mean(1:n));
fy=(1/a)*((1:m)-mean(1:m));
yy=0.001;

figure
for ii=1:length(x)-1
    
    tempAvec=arrangedAvec(:,x(ii):x(ii+1)-1);
    tempAvecFFT=abs(fftshift(fft2(tempAvec)));
    [thX1temp,thX2temp]=findingXboundaries(tempAvecFFT,fx);
    
    subplot(3,length(x),ii)
    surf(x(ii):x(ii+1)-1,1:8,tempAvec)
    shading interp; view(0,90); axis tight; 
    set(gca,'clim',[min(min(tempAvecFFT)) max(max(tempAvec))],'yscale','lin');
    
    subplot(3,length(x),ii+length(x))
    surf(fx,fy,tempAvecFFT)
    shading interp; view(0,90); axis tight;
    set(gca,'xlim',[thX1temp thX2temp],'clim',[min(min(tempAvecFFT)) max(max(tempAvecFFT))],'yscale','lin');
    
    subplot(3,length(x),ii+length(x)*2)
    tempAvecFFT(tempAvecFFT==0)=NaN;
    upperPart=tempAvecFFT(fy>0,(fx>0 & fx<thX2temp));
    lowerPart=tempAvecFFT(fy<0,(fx>0 & fx<thX2temp));
    bar([1 2],[mean(upperPart(:)) mean(lowerPart(:))])
%     set(gca,'ylim',[-0.05 0.05],'yscale','lin');
end

end


function [thX1,thX2]=findingXboundaries(avecFFT,fx)

    %this is just a makiavelic way to find the boundaries of the interesting frequencies (i.e. thX1,thX2) ##to improve
    sumFFT=sum(avecFFT);
    threshold=0.05*max(sumFFT);
    [aa,var]=sort(abs(sumFFT-threshold));
    var=var(1:40); %40 big enough not to cut. ##to improve
    thX1=fx(min(var));
    thX2=fx(max(var));

end
