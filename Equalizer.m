function [Equalized_Signal,h_estimate,Cee] = Equalizer(Modulated_Signal, Received_signal,No_fft_tones,h)
% Pilot and equalization
Lp=[1:No_fft_tones/8:No_fft_tones];
for i = 1:size(Modulated_Signal,1)
    Tx_Pilot = Modulated_Signal(i,Lp);
    Rx_Pilot = Received_signal(i,Lp);
    HLs=Rx_Pilot./Tx_Pilot;    % frequency response of the estimated channel at each Transmitted and Received pilot tones
    h_estimate_long=(ifft(HLs,8));     %8-point ifft of the estimated channel
      
    h_estimate_samples(i,:) =h_estimate_long;%(1,1:length(h));    % resizing the estimated channel upto the length of the actual channel for comparison
end
h_estimate = mean(h_estimate_samples);

Cee =0;% mean(sqrt(abs((h.^2-h_estimate.^2))));   %channel estimation error

H_EST_F = fft(h_estimate,64);     %64-point fft of of the estimated channel
for i = 1: size(Received_signal,1)
    Equalized_Signal(i,:)=Received_signal(i,:)./H_EST_F;                       %Equalization by dividing the received signals by the estimated channel
end
%Equalized_Signal = Received_signal;
