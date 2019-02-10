% Morgan State University
% WiNetS lab, Electrical and Computer Engineering
% Version 3.1
% Last modified 0n April 24,2018
% This code simulates a communication system with  

close all
clear all
clc
tic
randn('state',0)
rand('state',0)
Block_length=576;
No_fft_tones= 64 ;                        %FFT Size
Total_data_size=No_fft_tones*Block_length;%Total Number of bits

NumMc=10;                      % Number of Montecarlo Runs

load 'Flight_SNR_profile.mat' % load SNR for the entire flight path
sampling = 1;
Eb_N0_dB = SNR10;

load FreQ.mat
z = FreQ;
%z = zeros(1, 300); 

Coding_rate = 1;  %/2;%/2 %3/4%;%% 1/2;%%%
if Coding_rate ==1 ;Coding_scheme = 0;end          % Use '0' for no coding; '1' for convolutional coding; '2' for block coding
if Coding_rate ~=1 ;Coding_scheme = 1;end          % Use '0' for no coding; '1' for convolutional coding; '2' for block coding

Coding_trellis = poly2trellis([7],[171 133]);    %Generator plynomial for coding
Cyclic_prefix_length = 4;          


Equalize = true;
Display_results = true;

%Channel_no = 0; % Identify the simulation channel; Use "0" for AWGN channel;
%Channel_no = 10; % Taxi
%Channel_no = 13; % Take Off
%Channel_no = 11; % Steady State
Duration=60*[3 5 5 5 5 3];  %duration of phase in seconds
%Duration=60*5;
Phase_Time =60*[3 8 13 18 23 26];
%Phase_Time =60*13;
%Channel_set=[10 13 11 11 13 10];
Channel_set=[1 2 3 3 2 1];
%QAM_Size=[1 2 4 8];
QAM_Size = 2;
ser=zeros(1,10);
SER=zeros(length(Eb_N0_dB)/2,length(QAM_Size));
Mirrored_SER=zeros(length(Eb_N0_dB),length(QAM_Size));
Channel_no=zeros(length(Eb_N0_dB)/2);
%Channel_no = 11;
    % Bits per Symbol ( b_p_sym= 2 for 4QAM, b_p_sym= 4 for 16-QAM, b_p_sym= 8 for 64QAM) 
for b = 1:length(QAM_Size); 
    b_p_sym=QAM_Size(b);
    M=2^b_p_sym;                  % M-QAM size


for t =  1:sampling:length(Eb_N0_dB)/2
    %% Channel Selection absed on the proposed flight path
    Channel_no(t)=Channel_set(1);
    %Channel_no(t)=3;
   
    for i= 1:6
    if t>Phase_Time(i)
        Channel_no(t)=Channel_set(i+1);
    end
    end
    
    [b t]
    Z = z(t);
% plot(Channel_no(1:5:end))
% hold on;plot(Eb_N0_dB(1:sampling:end))
    for Mc = 1 : NumMc
        %disp([t Mc])
        data=randi([0,1],1,Total_data_size); % Generate random data
        
        [Encoded_data] = Encoder (data,Coding_trellis,b_p_sym,Coding_scheme,Coding_rate); %Convolutional Coding
        
        [Modulated_Signal] = QAM_mod(Encoded_data,No_fft_tones,M);
        
        ofdm_symbols = OFDM_mod (Modulated_Signal,No_fft_tones);% Generate ofdm symbols
        
        ofdm_syms_CP = Add_Cyclic_Prefix(ofdm_symbols,No_fft_tones,Cyclic_prefix_length);
        
        [Received_ofdm_signal_CP, Serial_ofdm_signal, y,h]=dyn_chan(ofdm_syms_CP,Channel_no(t),Eb_N0_dB(t),b_p_sym, Z);
        
        %[Received_ofdm_signal_CP,h] = Channel(ofdm_syms_CP,Eb_N0_dB(t), Channel_no,b_p_sym);
        
        Received_ofdm_signal = Remove_Cyclic_Prefix(Received_ofdm_signal_CP,No_fft_tones,Block_length,b_p_sym,Coding_rate,Cyclic_prefix_length);
        
        Received_signal = OFDM_demod (Received_ofdm_signal,No_fft_tones);
        
        if Equalize;[Equalized_Signal,h_estimate,Cee] = Equalizer(Modulated_Signal, Received_signal,No_fft_tones,h);end
        if ~ Equalize;Equalized_Signal = Received_signal;end
            
        
        Demodulated_signal = QAM_demod(Equalized_Signal,M);
        
        Decoded_bits = Decoder(Demodulated_signal,Coding_trellis,b_p_sym,Coding_scheme,Coding_rate);
        
        [dummy, ser(Mc)] = biterr(data,Decoded_bits); % Check bit error rate with coding
        
    end % of MC loop
    
    SER(t,b) = sum(ser)/NumMc;
   
end  % Of time loop
 Mirrored_SER(:,b)=  [SER(1:t,b); SER(t:-1:1,b)] ;
%Show_results          % Displays BER curve if Display_results flag is set to true;
hold on;semilogy(1:sampling:length(Mirrored_SER),Mirrored_SER(1:sampling:length(Mirrored_SER),b))
%hold on;plot(1:sampling:t,10.^(Eb_N0_dB(1:sampling:end)/10))
xlim([1 2*t])
end % of b loop ( QAM size )
%filename=[date,'LDAR-OFDM-','Entire_flight-','-rate-',num2str(Coding_rate),'Coding-',num2str(M),'QAM']
filename=[date,'-SER-', 'LDAR-OFDM-','dynamic-channel-','entire-flight','-rate-',num2str(100*Coding_rate),'-Coding-','4-QAM-',num2str(NumMc)]
 
save(filename)
toc