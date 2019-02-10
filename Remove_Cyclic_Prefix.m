function [Received_ofdm_signal] = Remove_Cyclic_Prefix(Received_ofdm_signal_CP,No_fft_tones,Block_length,b_p_sym,Coding_rate,Cyclic_prefix_length)
%This function changes the signal from serial to parallel and
%removes the cyclic prefix.

for i = 1:Block_length/(b_p_sym *Coding_rate)
    Received_ofdm_signal(i,:)= Received_ofdm_signal_CP((i-1)*(No_fft_tones+(No_fft_tones/Cyclic_prefix_length))+(No_fft_tones/Cyclic_prefix_length)+1:((i-1)*(No_fft_tones+No_fft_tones/Cyclic_prefix_length))+No_fft_tones+No_fft_tones/Cyclic_prefix_length); 
end
