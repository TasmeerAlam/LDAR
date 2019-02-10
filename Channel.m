function [Received_ofdm_signal_CP ,h,Serial_ofdm_signal, ofdm_syms_CP] = Channel(ofdm_syms_CP,Eb_N0_dB, Channel_no,b_p_sym)
 %This function selects channel h and transmits the signal through the channel h. Channel impulse
 %response is defined in the main code. Measured AWGN is added with the specified SNR. Channel_no identifies which channel ti be used. 
 %    '0' for AWGN 
 
        Serial_ofdm_signal = reshape (ofdm_syms_CP.',1,numel(ofdm_syms_CP)); 
        %x = Serial_ofdm_signal(1:end);
        switch  Channel_no
             case 0
                 h = [1];
             case 1
                 h = [1  (2/4)  (2/8)];
             case 2
                 h = [1 0 (2/4) 0 (2/8)];
             case 3
                 h = [1 0 0 (2/4) 0 0 (2/8)];
             case 4
                 h = [1  0.8   0.6];
             case 5
                 h = [1 0.98 0 0 0 0 0.1];
                 
              case 10
                 h = zeros(1,16);
                 taps=[1 0.95 0.2];
                 h([1 3 16])=taps;
                 
             case 11
                 h = zeros(1,16);
                 h([1 3]) = [1 0.95];
           
             case 12
                 h = zeros(1,41);
                 taps=[1 0.95 0.2 0.2];
                 h([1 9 34 41])=taps;
                 
             case 13
                 h = zeros(1,16);
                taps=[1 0.95 0.2 0.0003];
                 h([1 3 7 16])=taps;
                 
             case 14
                 h = zeros(1,31);
                taps=[1 0.95 0.2 0.0003 0.0005];
                 h([1 3 7 16 31])=taps;
             case 15
                taps = [1 0.98 0 0 0 0 0.1];
                 h= [0 2 6 15 30 42];
             case 16
                 h = zeros(1,3);
                 taps=[1 .95]; 
                 h([1 3])= taps;
             case 17 
                 h = zeros(1,41);
                taps=[1 .95 .2 .2]; 
                 h([1 9 34 41]) = taps;
  
% Dr Rice channels start from 20
           case 20 
               h = zeros(1,16);
             taps=[1 .95 .2];
           h([1 3 16])=taps;
           
           case 21
           h = zeros(1,3);
           taps=[1 .95];
           h([1 3])=taps;
                
            case 30
               h = zeros(1,31);
                taps=[1 .95 .2 .00003 .00005];
                h([1 3 7 16 31])=taps;
                
            case 31
                h = zeros(1,31);
                taps=[1 .2 .2];
                h([1 16 31])=taps;
                
            case 32
                h = zeros(1,41);
                taps=[1 .95 .2 .2];
                h([1 9 34 41])=taps;
              
                
            case 33
                h = zeros(1,16);
                taps=[1 .95 .2 .0003];
                h([1 3 7 16])=taps;
           case 34
                h = [1];
                
                
        end
       h = h/sqrt(h*h'); % normalization 
        y = conv(h,Serial_ofdm_signal);
        
        %ADD DOPPLER
        
        Es_N0_dB= Eb_N0_dB + 10*log10(b_p_sym);   % Relation between ESNo and EBNo

        
        switch b_p_sym
           case 1
                SNR=Es_N0_dB - 10*log10((40/29.9)); %Normalization factor  for 4  QAM................Change 2
           case 2
                SNR=Es_N0_dB - 10*log10((40/29.9)); %Normalization factor  for 4  QAM................Change 2
            case 4
                SNR=Es_N0_dB - 10*log10((64/80));  % Normalization factor for 16 qam
            case 6 
                SNR=Es_N0_dB - 10*log10((64/68));  % Normalization factor for 16 qam
            case 8 
                SNR=Es_N0_dB - 10*log10((64/68));  % Normalization factor for 16 qam
        end
       
        
        Received_ofdm_signal_CP=awgn(y,SNR,'measured');
        