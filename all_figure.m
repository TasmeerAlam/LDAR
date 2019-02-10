clear all
clc
%{
load 14-Mar-2018LDAR-OFDM-dynamic-channel-3-rate-1Coding-4QAM
s3= semilogy(Eb_N0_dB,SER,'b','LineWidth', 1.9);
set (s3, 'DisplayName', 'phase shift')
hold on
load 14-Mar-2018LDAR-OFDM-static-channel-3-rate-1Coding-4QAM
s4= semilogy(Eb_N0_dB,SER,'r','LineWidth', 1.9);
set (s4, 'DisplayName', 'no phase shift')

title('Error performance of 4 QAM - cruise channel')

xlabel('Eb/No (dB)');
ylabel('Error Ratio');
%axis([0 40 0 7*10^-6]);
hold off
%}

load 14-Mar-2018-SER-LDAR-OFDM-dynamic-channel-entire-flight--rate-100-Coding-4-QAM-10
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'b','LineWidth', 0.9);
xlim([1 2*t]);
hold on
set (s1, 'DisplayName', 'dynamic channel')
load 14-Mar-2018-SER-LDAR-OFDM-static-channel-entire-flight--rate-100-Coding-4-QAM-10
s2 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'r','LineWidth', 0.9);
xlim([1 2*t]);
set (s2, 'DisplayName', 'static channel')
title('SER performance of the enitre flight for 4 QAM - no coding');
xlabel('Time, t (sec)');
ylabel('SER');
%axis([0 1600 10^-8 10^0])
hold off
%{
load 06-Mar-2018-0-pi-equalizer-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'b','LineWidth', 3.9);
xlim([1 2*t]);
set (s1, 'DisplayName', 'no phase shift')
hold on; 

load 06-Mar-2018-1-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'y','LineWidth', 3.9);
xlim([1 2*t]);
set (s1, 'DisplayName', '0.1*pi phase shift')
hold on; 

load 06-Mar-2018-2-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)), 'm','LineWidth', 3.9);
xlim([1 2*t]);
set (s1, 'DisplayName', '0.2*pi phase shift')
hold on; 

load 06-Mar-2018-3-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'c','LineWidth', 3.9);
xlim([1 2*t]);
set (s1, 'DisplayName', '0.3*pi phase shift')
hold on; 

load 06-Mar-2018-4-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'g','LineWidth', 3.9);
xlim([1 2*t]);
set (s1, 'DisplayName', '0.4*pi phase shift')
hold on; 

load 06-Mar-2018-5-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'r','LineWidth', 3.9);
xlim([1 2*t]);
set (s1, 'DisplayName', '0.5*pi phase shift')
hold on; 

load 06-Mar-2018-6-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'r','LineWidth', 1.2);
xlim([1 2*t]);
set (s1, 'DisplayName', '0.6*pi phase shift')
hold on; 

load 06-Mar-2018-7-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'b','LineWidth', 1.2);
xlim([1 2*t]);
set (s1, 'DisplayName', '0.7*pi phase shift')
hold on; 

load 06-Mar-2018-8-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'k','LineWidth', 1.2);
xlim([1 2*t]);
set (s1, 'DisplayName', '0.8*pi phase shift')
hold on; 

load 06-Mar-2018-9-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)),'b','LineWidth', 1.2);
xlim([1 2*t]);
set (s1, 'DisplayName', '0.9*pi phase shift')
hold on; 

load 06-Mar-2018-10-pi-equalier-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)), 'r','LineWidth', 1.2 );
xlim([1 2*t]);
set (s1, 'DisplayName', 'pi phase shift')
hold on; 

title('SER performance of cruise phase for 4 QAM(no coding) with different phase shift');
xlabel('Time, t (sec)');
ylabel('Symbol Error Rate (SER)');
axis([0 600 10^-4 10^0])
hold off;
%}

%%color
%{
'Color',[.61 .51 .74]
'Color',[1 .4 0]
'Color', ([18 150 155] ./ 255)
'Color', ([251 111 66] ./ 255)
%}

%{
load 07-Mar-2018-SER-LDAR-OFDM-static-channel-cruise-phase--rate-100Coding-4-QAM-1
s1 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER),b), 'b','LineWidth', 0.8);
xlim([1 2*t]);
set (s1, 'DisplayName', 'no doppler 4 QAM - no coding')
hold on; 
load 07-Mar-2018-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-100Coding-4-QAM-1
s2 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER),b), 'r','LineWidth', 0.8);
xlim([1 2*t]);
set (s2, 'DisplayName', 'with doppler 4 QAM - no coding')
hold on; 
%}
%{
load 05-Mar-2018SERLDAR-OFDM-dynamic-channel-entire-flight-rate-50Coding-4-QAM-1
s3 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER),b), 'g','LineWidth', 0.8);
xlim([1 2*t]);
set (s3, 'DisplayName', 'with doppler')
hold on;
load 05-Mar-2018-SER-LDAR-OFDM-static-channel-entire-flight-rate-50Coding-4-QAM-1
s4 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER),b), 'b','LineWidth', 0.8);
xlim([1 2*t]);
set (s4, 'DisplayName', 'no doppler')
hold on;
%load 07-Mar-2018-SER-LDAR-OFDM-dynamic-channel-cruise-phase--rate-75Coding-4-QAM-1
%s4 = semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER),b), 'k','LineWidth', 0.8);
%xlim([1 2*t]);
%set (s4, 'DisplayName', 'with doppler 4 QAM - 3/4 coding')
%hold on;
title('SER performance of the enitre flight for 4 QAM - half coding');
xlabel('Time, t (sec)');
ylabel('SER');
%axis([0 600 10^-8 10^0])
%hold off
%}

%{
load 05-Mar-2018SERZLDAR-OFDM-dynamic-channel-entire-flight-rate-50Coding-4-QAM-1
s1= semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)), 'r','LineWidth', 1.2);
set (s1, 'DisplayName', 'with doppler')
hold on

load 05-Mar-2018-SER-LDAR-OFDM-static-channel-entire-flight-rate-50-Coding-4-QAM-10
s2= semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)), 'b','LineWidth', 1.2);
set (s2, 'DisplayName', 'no doppler')
hold on
load 05-Mar-2018-SER-add-h-LDAR-OFDM-dynamic-channel-entire-flight-rate-50-Coding-4-QAM-1
s2= semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER)), 'r','LineWidth', 1.2);
set (s2, 'DisplayName', 'with doppler')
hold on
title('SER performance of cruise phase for 16 QAM - rate 1/2 coding');
xlabel('Time');
ylabel('SER');
axis([480 1080 10^-6 10^-1]);
hold off
%}
%{
load 13-Jul-2017LDAR-OFDM-channel-0-rate-1Coding-16QAM
s3= semilogy(Eb_N0_dB,SER,'-*r','LineWidth', 1.9);
set (s3, 'DisplayName', 'no code 16 QAM')
hold on
load 13-Jul-2017LDAR-OFDM-channel-0-rate-1Coding-64QAM
s4= semilogy(Eb_N0_dB,SER,'-sg','LineWidth', 1.9);
set (s4, 'DisplayName', 'no code 64 QAM')
hold on
load 13-Jul-2017LDAR-OFDM-channel-0-rate-1Coding-256QAM
s5= semilogy(Eb_N0_dB,SER,'-+m','LineWidth', 1.9);
set (s5, 'DisplayName', 'no code 256 QAM')
hold on
load 10-Jul-2017LDAR-OFDM-channel-0-rate-50Coding-2QAM
s6= semilogy(Eb_N0_dB,SER,'--ob','LineWidth', 1.9);
set (s6, 'DisplayName', 'half code BPSK')
hold on  
load 11-Jul-2017LDAR-OFDM-channel-0-rate-50Coding-4QAM
s7= semilogy(Eb_N0_dB,SER,'--yx','LineWidth', 1.9);
set (s7, 'DisplayName', 'half code QPSK')
hold on
load 11-Jul-2017LDAR-OFDM-channel-0-rate-50Coding-16QAM
s8= semilogy(Eb_N0_dB,SER,'--*r', 'LineWidth', 1.9);
set (s8, 'DisplayName', 'half code 16 QAM')
hold on
load 11-Jul-2017LDAR-OFDM-channel-0-rate-50Coding-64QAM
s9= semilogy(Eb_N0_dB,SER,'--sg','LineWidth', 1.9);
set (s9, 'DisplayName', 'half code 64 QAM')
hold on
load 11-Jul-2017LDAR-OFDM-channel-0-rate-50Coding-256QAM
s10= semilogy(Eb_N0_dB,SER,'--+m','LineWidth', 1.9);
set (s10, 'DisplayName', 'half code 256 QAM')
hold on
%theoryBer= Theory_BER(Eb_N0_dB,M,b_p_sym); 
%semilogy(Eb_N0_dB,theoryBer,'--bx','LineWidth',1.6);
%hold on
%}
%xlabel('Eb/No (dB)');
%ylabel('Error Ratio');
%axis([0 100 0 7*10^-6]);
%hold off