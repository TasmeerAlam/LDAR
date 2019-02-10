%LDAR DEMO
%This code creates a psuedo test flightand creates parameter for our ch sim'l
% A Psuedo flight consists of a taxi, takeoff, a level flight pattern
% In this case the patter is an out-and-back pattern
% The flight is symmetric with 6 phases reflecting the taxi, takeoff, and
% level phases and the same pattern in reverse
% The log distance model and two ray model is used to compute path loss
%Plot the cumulative data rate for iNET (1 bit per symbol) vs Shannon rate
clear all
close all
clc
%Parameters
Phases=6 ; %number phases
Duration=[3 5 5 5 5 3] ; %duraition of phase in min
Path_Loss=[4 2.5 2. 2. 2.5 4]; %patl loss exponent
Speed=[60 200 300 -300 -200 -60]; %speed mph relative to the ground station
Speed=Speed* 1600/3600 ;%Speed in meters per second
Angle=[0 45 0 0 45 0]; %Climb angle
Angle=Angle*2*pi/360;
Boltz=1.38*10^(-23);
Bw=15*10^6;
To=290;
F=10;
Noise= F*Boltz*Bw*To;
Power=5;
Freq=1.5*10^9;
Lambda=3*10^8/Freq;
D=0.0;
t=0.0;
Pow=5;
Gt=1;
Gr=100;
At=Gt*(Lambda^2)/(4*pi);
Ar=Gr*(Lambda^2)/(4*pi);
H=10.0 ; %height in meters above ground
Index=1;
Alpha=0 ; %smooth the data
S=0.0;
C=0;
R=0;
Hr = 10; %height or receive antenna
%Generate the sequence of events in 1 sec intervals.
for i=1:Phases
for j=1:60*Duration(i) %calc parameters for each second in the test
D=D+cos(Angle(i))*Speed(i); % Distance from the GS as function of climb angle
H = H + sin(Angle(i))*Speed(i) ; %compute height
Ht(Index) = H;
Do=10*H; %ref distance is a function of height
Dt=sqrt(D^2 + H^2) ; %vector sum of distance
N = 4-7*(H/D); % generating dynamics path loss exponent
if N <=2
N = 2;
end
NN(Index) = N;
% Signal=Pow*At*Ar*(1/((Lambda^2)*Do^2))*(Do/Dt)^Path_Loss(i); %Received power
Signal=Pow*At*Ar*(1/((Lambda^2)*Do^2))*(Do/Dt)^N;
S=Alpha*S+(1-Alpha)*Signal; %Smooth power
SNR10(Index)= 10*log10(S/Noise);
SNR(Index)=(S/Noise);
Distance(Index)=Dt;
Height(Index)=H;
R=R + 1; % Add 1 bit per sample for QPSK, R=1/2
Rate(Index)=R + 1; % Add 1 bit per sample for QPSK, R=1/2
C=C + log2(SNR(Index)); % Shannon Rate
Shannon(Index)=C ; %Max Data rate
%% Difference in Path Calculation
D2=sqrt((H+Hr)^2 + D^2) ;%Reflection dist
D1=sqrt((H-Hr)^2 +D^2) ; %Direct distance
Dist2(Index) = D2;
Dist1(Index) = D1;
delta1=D2-D1 ; %this is the difference in path lenth
De(Index) = delta1;
FreQ = (De/Lambda)*(2*pi); % Phase Shift
Td = De/(3*10^8); %timedelay
Index=Index+1;
end
end
y = [FreQ; Td];
figure (1);
hold on
plot(FreQ)
title('Differential Phase shfit per second');
xlabel('Time(sec)');
ylabel('phase shift');
hold off

figure (2);
hold on
plot(Td)
title('Time delay from one tap to another per second');
xlabel('Time(sec)');
ylabel('time delay');
hold off

save FreQ.mat