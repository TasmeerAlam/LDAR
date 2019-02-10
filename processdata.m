% Farzad Moazzami
% Last modified 3/5/14
% LDAR Project
% This code process the data files from Monte Carlo simulations of LDAR
% over a test flight path. Different modulaions schemes are:
% 1) BPSK  2) QPSK  3) 16-QAM 4) 256-QAM
% As of today available coding rates  are 1) No coding 2) rate 1/2 coding
% Note rate 3/4 coding results will be added as soon as they are ready.
clear all
close all
clc
%% Controls
SER_Threshold = 1e-4;

%% load and process the data file with 4 modulation schemes and no coding:
load 24-Feb-2014LDAR-OFDM-Entire_flight--rate-1Coding-all-QAM-sizes-10.mat

% Create figure with all of the SER values superimposed for all QAM sizes.
axes1 = axes('Parent',figure,'YScale','log','YMinorTick','on');
box(axes1,'on');
hold(axes1,'all');
% Create multiple lines using matrix input to semilogy
semilogy1 = semilogy(Mirrored_SER,'Parent',axes1);
set(semilogy1(1),'DisplayName','BPSK');
set(semilogy1(2),'Color',[1 0 0],'DisplayName','QPSK');
set(semilogy1(3),'Color',[0 1 0],'DisplayName','16-QAM');
set(semilogy1(4),'DisplayName','256-QAM','Color',[1 0.7 0.5]);

title('SER values for differenty QAM sizes for the flight path - No coding');
xlabel('Time, t (sec)');
ylabel('SER');
%set(legend1,'Position',[0.4 0.18 0.2 0.19]);

% Decide on Modulation scheme based on the SER_Threshold
bps=[1 2 4 8];
Best_bps=ones(length(Mirrored_SER));
Total_bits_rate1(1)= 0;
for t = 2:length(Mirrored_SER)
    Best_temp = max(find( Mirrored_SER(t,:)<SER_Threshold));
    if ~isempty(Best_temp)
        Best_mod(t) = Best_temp;
        Best_SER(t) = Mirrored_SER(t,Best_temp);
        Best_bps(t)=bps(Best_temp);
    end
    Total_bits_rate1(t) = Total_bits_rate1(t-1)+Best_bps(t);
end
hold on;semilogy(Best_SER,'DisplayName','Selected','Color',[0 0 0])
legend1 = legend(axes1,'show','Location','Best');
% Draw Threshold line
hold on;semilogy(1:t,SER_Threshold,'DisplayName','Threshold','Color',[0 0 0])


%% load and process the data file with 4 modulation schemes and rate 1/2 coding:
load 04-Mar-2014LDAR-OFDM-Entire_flight--rate-50Coding-all-QAM-sizes-10.mat

% Create figure with all of the SER values superimposed for all QAM sizes.
axes1 = axes('Parent',figure,'YScale','log','YMinorTick','on');
box(axes1,'on');
hold(axes1,'all');
% Create multiple lines using matrix input to semilogy
semilogy1 = semilogy(Mirrored_SER,'Parent',axes1);
set(semilogy1(1),'DisplayName','BPSK');
set(semilogy1(2),'Color',[1 0 0],'DisplayName','QPSK');
set(semilogy1(3),'Color',[0 1 0],'DisplayName','16-QAM');
set(semilogy1(4),'DisplayName','256-QAM','Color',[1 0.7 0.5]);

title('SER values for differenty QAM sizes for the flight path - Rate 1/2 coding');
xlabel('Time, t (sec)');
ylabel('SER');
%set(legend1,'Position',[0.4 0.18 0.2 0.19]);

% Decide on Modulation scheme based on the SER_Threshold
bps=[1 2 4 8];
Best_bps=ones(length(Mirrored_SER));
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
hold on;semilogy(Best_SER,'DisplayName','Selected','Color',[0 0 0])
legend1 = legend(axes1,'show','Location','Best');
% Draw Threshold line
hold on;semilogy(1:t,SER_Threshold,'DisplayName','Threshold','Color',[0 0 0])



%% load and process the data file with 4 modulation schemes and rate 3/4 coding:
load 05-Mar-2014LDAR-OFDM-Entire_flight--rate-75Coding-all-QAM-sizes-10.mat

% Create figure with all of the SER values superimposed for all QAM sizes.
axes1 = axes('Parent',figure,'YScale','log','YMinorTick','on');
box(axes1,'on');
hold(axes1,'all');
% Create multiple lines using matrix input to semilogy
semilogy1 = semilogy(Mirrored_SER,'Parent',axes1);
set(semilogy1(1),'DisplayName','BPSK');
set(semilogy1(2),'Color',[1 0 0],'DisplayName','QPSK');
set(semilogy1(3),'Color',[0 1 0],'DisplayName','16-QAM');
set(semilogy1(4),'DisplayName','256-QAM','Color',[1 0.7 0.5]);

title('SER values for differenty QAM sizes for the flight path - Rate 3/4 coding');
xlabel('Time, t (sec)');
ylabel('SER');
%set(legend1,'Position',[0.4 0.18 0.2 0.19]);

% Decide on Modulation scheme based on the SER_Threshold
bps=[1 2 4 8];
Best_bps=ones(length(Mirrored_SER));
Total_bits_rate3q(1)= 0;
for t = 2:length(Mirrored_SER)
    Best_temp = max(find( Mirrored_SER(t,:)<SER_Threshold));
    if ~isempty(Best_temp)
        Best_mod(t) = Best_temp;
        Best_SER(t) = Mirrored_SER(t,Best_temp);
        Best_bps(t)=bps(Best_temp);
    end
    Total_bits_rate3q(t) = Total_bits_rate3q(t-1)+Best_bps(t);
end
hold on;semilogy(Best_SER,'DisplayName','Selected','Color',[0 0 0])
legend1 = legend(axes1,'show','Location','Best');
% Draw Threshold line
hold on;semilogy(1:t,SER_Threshold,'DisplayName','Threshold','Color',[0 0 0])


%% figure(3) to show the overall bits transmitted
load baseline.mat
figure(4);

hold on;plot(Shannon,'DisplayName','Shannon','Color',[0 0 0])
hold on; plot(Total_bits_rate3q,'DisplayName','Rate 3/4 Coding','Color',[0.6 0.2 0.7],'linestyle','--')
hold on; plot(Total_bits_ratehalf,'DisplayName','Rate 1/2 Coding','Color',[0 0 1])
hold on; plot(Total_bits_rate1,'DisplayName','No Coding','Color',[0 1 0])

hold on;plot(Rate,'DisplayName','iNET Baseline','Color',[1 0 0])
title('Total Bits transmitted ')
legend1 = legend('show','Location','Best')
box on;


