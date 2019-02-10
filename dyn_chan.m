function [Received_ofdm_signal_CP, Serial_ofdm_signal, y,h]=dyn_chan(ofdm_syms_CP,Channel_no,Eb_N0_dB,b_p_sym,Z)

Serial_ofdm_signal = reshape (ofdm_syms_CP.',1,numel(ofdm_syms_CP));
X = [Serial_ofdm_signal,zeros(1,length(Serial_ofdm_signal))];

%load FreQ.mat

switch Channel_no 
    case 1  %%taxi channel
    length_h = 16;
    h1 = zeros(1,16);
    h1([1 3 16]) = [1 (0.95*exp(1i*Z)) 0.2];
    h = h1/sqrt(h1*h1');
    ht = [h,zeros(1,length_h)];
    %z = FreQ(1:180);
    %Z = [z, ones(1, length(Serial_ofdm_signal))];


    case 2  %%take off channel
    length_h = 16;
    h1 = zeros(1,16);
    h1([1 3 7 16]) = [1 (0.95*exp(1i*Z)) 0.2 0.0003];
    h = h1/sqrt(h1*h1');
    ht = [h,zeros(1,length_h)];
    %z = FreQ(181:480);
    %Z = [z, ones(1, length(Serial_ofdm_signal))];


    case 3  %%cruise channel
    length_h = 16;
    h1 = zeros(1,16);
    h1([1 3]) = [1 (0.95*exp(1i*Z))];
    %h1([1 3]) = [1 0.95];
    h = h1/sqrt(h1*h1');
    ht = [h,zeros(1,length_h)];
    %z = FreQ(481:780);
    %Z = [z, ones(1, length(Serial_ofdm_signal))];
end

for k = 1: length(Serial_ofdm_signal)+length_h-1
    y(k)=0;
    for i = 1:length_h
        if k-i+1>0
            %H(i) = ht(i);
            %if (k-i+1)/SI == floor ((k-i+1)/SI)
            %end
            y(k) =y(k)+X(k-i+1)*ht(i);
            %H(3) =  ht(3)*exp(1i*(Z(k-i+1)));
            
        else 
            
        end
    end
end

Es_N0_dB= Eb_N0_dB + 10*log10(b_p_sym);   % Relation between ESNo and EBNo

        switch b_p_sym
           case 1
                SNR=Es_N0_dB- 10*log10((40/29.9)); %Normalization factor  for 4  QAM................Change 2
           case 2
                SNR=Es_N0_dB- 10*log10((40/29.9)); %Normalization factor  for 4  QAM................Change 2
            case 4
                SNR=Es_N0_dB - 10*log10((64/80));  % Normalization factor for 16 qam
            case 6 
                SNR=Es_N0_dB- 10*log10((64/68));  % Normalization factor for 16 qam
            case 8 
                SNR=Es_N0_dB- 10*log10((64/68));  % Normalization factor for 16 qam
        end
Received_ofdm_signal_CP= awgn(y,SNR,'measured'); %add noise at SNR dB