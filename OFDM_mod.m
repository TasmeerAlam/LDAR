function[ofdm_symbols] = OFDM_mod (Modulated_Signal,No_fft_tones)
%This function applies ifft at the transmitter to change the signal in to OFDM tones.

for i = 1:size(Modulated_Signal,1)
    ofdm_symbols(i,:) = ifft(Modulated_Signal(i,:),No_fft_tones);
end