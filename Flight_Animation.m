% Farzad Moazami
%LDAR Flight Simulation Demo
% 3/10/2014
clc
clear all
close all
%% Controls
Simulation_Speed = 4;
SER_Threshold = 1e-3;
Duration = 60*[3 5 5 5 5 3];
Speed = [60 200 300 300 200 60]./3600;
Mods = ['BPSK   '; 'QPSK   ';'16-QAM '; '256-QAM'];
%% load and process the data file with 4 modulation schemes and rate 1/2 coding:
load 04-Mar-2014LDAR-OFDM-Entire_flight--rate-50Coding-all-QAM-sizes-10.mat
% Decide on Modulation scheme based on the SER_Threshold
bps=[1 2 4 8];
Best_bps=ones(length(Mirrored_SER));
Best_mod=ones(length(Mirrored_SER));
Total_bits_ratehalf(1)= 0;
for t = 2:length(Mirrored_SER)
    Best_temp = max(find( Mirrored_SER(t,:)<SER_Threshold));
    if ~isempty(Best_temp)
        Best_mod(t) = Best_temp;
        Best_SER(t) = Mirrored_SER(t,Best_temp);
        Best_bps(t)=bps(Best_temp);
    end
    Total_bits_ratehalf(t) = Total_bits_ratehalf(t-1)+Best_bps(t);
end
load baseline.mat
subplot(2,2,2);
xlabel('Time (sec)')
hold on;plot(Shannon,'DisplayName','Shannon','Color',[0 0 0])
hold on;plot(Rate,'DisplayName','iNET Baseline','Color',[1 0 0])
title('Total Bits transmitted ')
legend1 = legend('show','Location','Best');
box on;

D1 = linspace(0,3,180);
D2 = linspace(3,15,300);
D3 = linspace(15,40,300);
D = [D1 D2 D3];
x=[zeros(1,length(D1)) D2-3  12*ones(1,length(D3))];
%% Set Figure;
figure(1);subplot(2,2,1);
axis ([0 40 -10000 5280*15])
hold on
xlabel('Distance (Miles)')
ylabel('Elevation (ft)')
title('Flight Path')
box on;
%% Create  "textboxes"
mTextBox = uicontrol('style','text');
set(mTextBox,'String','','fontsize',18,'Position',[180 170 200 40])
mTextBox2 = uicontrol('style','text');
set(mTextBox2,'String','','fontsize',18,'Position',[180 120 200 40])
mTextBox3 = uicontrol('style','text');
set(mTextBox3,'String','','fontsize',18,'Position',[180 70 200 40])
mTextBox4 = uicontrol('style','text');
set(mTextBox4,'String','','fontsize',18,'Position',[180 20 200 40])
%% Outbound Flight Path
Count = 1;
for i = 1:Simulation_Speed:length(x);
    subplot(2,2,1); hold on;plot(D(i),5280* x(i),'*b','markersize',4)
    subplot(2,2,2);hold on; plot(i,Total_bits_ratehalf(i),'.b','DisplayName','Rate 1/2 Coding','Color',[0 0 1])
    
    drawnow;
    
    Minutes = floor(Count/60);
    Seconds = Count - (Minutes*60);
    t_string = ['Time ',num2str(Minutes),':',num2str(Seconds)];
    SER_string = ['SER: ',num2str(Best_SER(i))];
    Tbits_string = ['Tx Bits: ',num2str(Total_bits_ratehalf(i))];
    
    set(mTextBox,'String',t_string )
    set(mTextBox2,'String',num2str(Mods(Best_mod(i),:)))
    set(mTextBox3,'String',SER_string)
    set(mTextBox4,'String',Tbits_string)
    Count = Count+Simulation_Speed;
end
%% inbound Flight Path
for i = length(x):-Simulation_Speed:1;
    Count = Count+Simulation_Speed;
    subplot(2,2,1);hold on;plot(D(i),5280* x(i)-1000,'*r','markersize',4)
    subplot(2,2,2);hold on; plot(Count,Total_bits_ratehalf(Count-1),'.b','DisplayName','Rate 1/2 Coding')
    
    drawnow;
    Minutes = floor(Count/60);
    Seconds = Count-(Minutes*60) ;
    t_string = ['Time ',num2str(Minutes),':',num2str(Seconds)];
    SER_string = ['SER: ',num2str(Best_SER(Count-1))];
    Tbits_string = ['Tx Bits: ',num2str(Total_bits_ratehalf(Count-1))];
    set(mTextBox,'String',t_string )
    set(mTextBox2,'String',num2str(Mods(Best_mod(Count),:)))
    
    set(mTextBox3,'String',SER_string)
    set(mTextBox4,'String',Tbits_string)
end
t_string = ['Time ',num2str(26),':',num2str(0)];
set(mTextBox,'String',t_string )





