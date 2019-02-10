function[Received_signal] = OFDM_demod (Received_ofdm_signal,No_fft_tones)
%This function applies fft at the receicer end to remove the OFDM effects.
       for i = 1:size(Received_ofdm_signal,1)
           Received_sig(i,:) = fft(Received_ofdm_signal(i,:),No_fft_tones);
       
       end
       Rec_sig_A = Received_sig(:,1:24);
       Rec_sig_B = 0.01*Received_sig(:,25:40);
       Rec_sig_C = Received_sig(:,41:64);
       
       Received_signal = [ Rec_sig_A, Rec_sig_B, Rec_sig_C];
      
        