function [Modulated_signal] = QAM_mod(Encoded_data,No_fft_tones,M)
%This function changes the data from serial to parallel which is followed
%by QAM modulation.
        a=length(Encoded_data)/No_fft_tones;
        Parallel_encoded = reshape (Encoded_data,No_fft_tones,a).';
        Modulated_signal = qammod(Parallel_encoded,M); % Use M-ary QAM modulation to produce y.
       
        Modulated_signal = Modulated_signal/sqrt(2/3*(M-1));
           