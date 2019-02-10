clc
if Display_results
    if length(Eb_N0_dB)~=1
        
 figure(10)
%theoryBer= Theory_BER(Eb_N0_dB,M,b_p_sym);
% % 
%semilogy(Eb_N0_dB,theoryBer,'--b','LineWidth',1.6);
% 
%hold on
semilogy(Eb_N0_dB,SER,'-kx','LineWidth',1.9)
hold on

xlabel('Eb/No (dB)');ylabel('Error Ratio');
%title('Error Performance of OFDM transmission with 4 Qam');
%legend('theoretical','CP+coded')
%axis([0 length(Eb_N0_dB) 10^-6 1])
axis([0 50 10^-6 1])
    end
    if length(Eb_N0_dB)==1
        QAM_Signal = reshape(Modulated_Signal,1,numel(Modulated_Signal));
        Rx_signal = reshape(Received_signal,1, numel(Received_signal));
        figure(11); subplot(221);axis tight;plot(real(QAM_Signal),imag(QAM_Signal),'.b');title('Modulated Signal')
        figure(11); subplot(222);axis tight;plot(real( Rx_signal),imag( Rx_signal),'.b');title('Recieved Signal')
        figure(11); subplot(223);axis tight;plot(real(Equalized_Signal),imag(Equalized_Signal),'.b');title('Equalized Signal')
        
        
         
         
         
         
%          
         figure(1);freqz(h)
         figure(2);freqz(h_estimate)
         figure(3);subplot(211); stem(h);
         figure(3);subplot(212); stem(h_estimate);
% 
%         
    end



end