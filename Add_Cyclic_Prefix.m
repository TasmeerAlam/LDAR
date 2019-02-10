function [ofdm_syms_CP] = Add_Cyclic_Prefix(ofdm_symbols,No_fft_tones,Cyclic_prefix_length)
% This function adds cyclic prefix to the transmitted signal to mitigate
% for ISI. 1/4 of the data field is folded back to the end of each packet.
for i = 1:size(ofdm_symbols,1)
    ofdm_syms_CP(i,:)=[ofdm_symbols(i,(No_fft_tones-No_fft_tones/Cyclic_prefix_length) +1:No_fft_tones),ofdm_symbols(i,:)]; 
end
save ofdm_syms_CP.mat
