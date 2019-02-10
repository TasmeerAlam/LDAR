%LDAR DEMO
%This code creates a psuedo test flightand creates parameter for our ch sim'l
% A Psuedo flight consists of a taxi, takeoff, a level flight pattern
% In this case the patter is an out-and-back pattern
% The flight is symmetric with 6 phases reflecting the taxi, takeoff, and
% level phases and the same pattern in reverse
%Each phase is charactherized by a channel selection from the 8 telemetry
%channels where 1 is Taxi, 4 is takeoff and 2 is level (Mostafa's report)
% The flight develops a variable SNR based on the distance from the GS and
% the path loss coefficent which varies based on the test phase from 2 to 4
% The log distance model is used to compute path loss
%Plot the cumulative data rate for iNET (1 bit per symbol) vs Shannon rate
clear all
close all
%Parameters
Phases=6            %number phases
Duration=[3 5 5 5 5 3]  %duraition of phase in min
Channel=[1 2 7 7 2 1]      %select ch siml path model
Path_Loss=[4 2.5 2. 2.  2.5 4] %patl loss exponent
Speed=[60 200 300 -300 -200 -60] %speed mph relative to the ground station
Speed=Speed* 1600/3600  %Speed in meters per second
Angle=[0 45 0 0 45 0];  %Climb angle
Angle=Angle*2*pi/360;
Boltz=1.38*10^(-23)
Bw=15*10^6
To=290
F=10
Noise= F*Boltz*Bw*To
Power=5
Freq=1.5*10^9
Lambda=3*10^8/Freq
D=0.0
t=0.0
Pow=5
Gt=1
Gr=100
At=Gt*(Lambda^2)/(4*pi)
Ar=Gr*(Lambda^2)/(4*pi)
H=10.0      %height in meters above ground
Index=1
Alpha=.9  %smooth the data
S=0.0
C=0
R=0
%Generate the sequence of events in 1 sec intervals.
for i=1:Phases
    for j=1:60*Duration(i)  %calc parameters for each second in the test
        D=D+cos(Angle(i))*Speed(i); % Distance from the GS as function of climb angle
        H=H + sin(Angle(i))*Speed(i);  %compute height
        Do=10*H;                %ref distance is a function of height
        Dt=sqrt(D^2 + H^2);     %vector sum of distANCE
        Signal=Pow*At*Ar*(1/((Lambda^2)*Do^2))*(Do/Dt)^Path_Loss(i); %Received power
        S=Alpha*S+(1-Alpha)*Signal;     %Smooth power
        SNR10(Index)= 10*log10(S/Noise);
        SNR(Index)=(S/Noise);

        Distance(Index)=Dt;
        Height(Index)=H;
        R=R + 1;  % Add 1 bit per sample for QPSK, R=1/2
        Rate(Index)=R + 1;  % Add 1 bit per sample for QPSK, R=1/2
        C=C + log2(SNR(Index)); % Shannon Rate
        Shannon(Index)=C ; %Max Data rate
        Index=Index+1;
    end
end
% plot(SNR10)
% title('SNR in dB vs Time')
% figure
% plot(Height)
% title('Aircraft Height in meters vs Time')
% figure
% plot(Distance)
% title('Aircraft Distance in meters vs Time')
plot(Rate)
hold
plot(Shannon)
title('Bits transmitted - iNET and Shannon')
        