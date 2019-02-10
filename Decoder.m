function [Decoded_bits] = Decoder(Demodulated_signal,Coding_trellis,b_p_sym,Coding_scheme,Coding_rate)
% This function changes the received bits from decimal to binary which is
% followed by Viterbi decoding.Coding_scheme identifies the mode for decoding.
%  Use '0' for no decoding;
%      '1' for Viterbi decoding;
%      '2' for BCH decoing;
switch Coding_scheme
    case 0 %No decoding
    Decoded_dec = Demodulated_signal;
    
    case 1 %Viterbi Decoding
        p=[];
        for v=1:length(Demodulated_signal)
            c=dec2bin(Demodulated_signal(1,v),b_p_sym)-'0';
            p=[p, c];
        end
        Puncture_vector = Select_Puncture_Vector(Coding_rate);
        Decoded_dec = vitdec(p, Coding_trellis, 24, 'trunc','hard',Puncture_vector);
       
    case 2
       Decoded_dec = Demodulated_signal; 
 end
 Decoded_bits = de2bi(Decoded_dec,'left-msb');
 Decoded_bits = reshape(Decoded_bits.',1,numel(Decoded_bits));
 
 