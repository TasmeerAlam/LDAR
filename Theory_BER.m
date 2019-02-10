function [theoryBer]= Theory_BER(Eb_N0_dB, M,b_p_sym)
%This function provides the theoritical curve of BER against SNR.
EsN0dB= Eb_N0_dB+10*log10(b_p_sym); 
%EsN0dB_eff = EsN0dB  + 10*log10(52/64) + 10*log10(64/80); % accounting for the used subcarriers and cyclic prefix

% switch r
%     case 2
%     theoryBer=erfc(sqrt(0.5*(10.^(Es_N0_dB/10)))) - (1/4)*(erfc(sqrt(0.5*(10.^(Es_N0_dB/10))))).^2; %Theretical SER for 4 QAM
    %case 4
    %theoryBer = (1/r)*3/2*erfc(sqrt(r*0.1*(10.^(Eb_N0_dB/10)))); %Theretical BER for 16 QAM, For 16 Qam this theoretical formula need to be used
%     case 6
%       theoryBer = (1/r)*3/2*erfc(sqrt(r*0.1*(10.^(Eb_N0_dB/10)))); %Theretical BER for 16 QAM, For 16 Qam this theoretical formula need to be used
%     case 8
%       theoryBer = (1/r)*3/2*erfc(sqrt(r*0.1*(10.^(Eb_N0_dB/10)))); %Theretical BER for 16 QAM, For 16 Qam this theoretical formula need to be used
%   
% end
k      = sqrt(1/((2/3)*(M-1))); 

%theoryBer = 2*(1-1/sqrt(M))*erfc(k*sqrt(EbNo))- (1-2/sqrt(M)+1/M)*(erfc(k*sqrt(EbNo))).^2;
theoryBer = (2*(1-1/sqrt(M))*erfc(k*sqrt((10.^(EsN0dB/10)))) ...
	              - (1-2/sqrt(M) + 1/M)*(erfc(k*sqrt((10.^(EsN0dB/10))))).^2)/b_p_sym;
