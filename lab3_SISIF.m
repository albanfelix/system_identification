% Alban-Félix Barreteau, M1 CORO SIP
% Mail : alban-felix.barreteau@eleves.ec-nantes.fr
% Matlab R2020b Update 5 (9.9.0.1538559), Student license
% Signal Filtering and System Identification (SISIF)
% Labwork 3 : Identification of a mechanical system (session 2)

% Professor : said.moussaoui@ec-nantes.fr

%----------------------------------------------------------------%

clear all
close all
clc

% Definition of the screen :
hpixels=1440;
vpixels=900;


%% Parameters 

fs=1000; %Sampling frequency in Hz
ts=1/fs; %Sampling period
P=2.91; %Gain of the proportionnal controller



%% Identification of the processus : Z as output

load tergane20.mat 
data=iddata(z,yc,ts);

nb=3;
nf=3;
nk=delayest(data);

mod_oe=oe(data, [nb nf nk]);
present(mod_oe); %Displays model properties
figure(70); resid(data,mod_oe); %Compute and test the residuals associated with identified models
set(figure(70),'name','Residuals associated with identified models','position',[hpixels/2 vpixels/2 hpixels/2 vpixels/2])
[y,rt2val] = compare(mod_oe, data); %Compare system response with the measured data
fpeval = fpe(mod_oe) ; %Extracts the Final Prediction Error from the model
aicval = aic(mod_oe); %Computes Akaike's Information Criterion for identified models
disp(['RT2 : ',num2str(rt2val),' | AIC : ',num2str(aicval),' | FPE : ',num2str(fpeval)]);


CT_mod_oe=d2c(mod_oe);
present(CT_mod_oe);


%% Transfer function identified

b1=10930;
b0=0;
a3=1;
a2=459.4;
a1=28930;
a0=2102000;



%% Physical parameters of the model

P=2.91
KZ=b1/(P*a1)
KY=a0/a1
T2=(a2+(a2^2-4*a1)^0.5)/(2*a1)
T1=1/(a1*T2)



