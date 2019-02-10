function [output] = Encoder (data,Coding_trellis,b_p_sym,Coding_scheme,Coding_rate)
%This function changes the transmitted bits from binary to decimal followed by
% Viterbi encoding. Coding_scheme identifies the mode for coding.
%  Use '0' for no coding;
%      '1' for convolutional coding;
%      '2' for BCH coding; 
switch Coding_scheme
    case 0
    
     % Binry to decimal
        a1=length(data)/b_p_sym;
        output1=bi2de(reshape(data,b_p_sym,a1).','left-msb');
        output=output1';
         Coding_rate=length(data)/length(output) / b_p_sym;
         
    case 1   %Convolutional Coding
          
        Puncture_vector = Select_Puncture_Vector(Coding_rate);
        code = convenc(data,Coding_trellis,Puncture_vector);  
        % Binry to decimal
        a1=length(code)/b_p_sym;
        reshaped_code = reshape(code,b_p_sym,a1).';
        output1=bi2de(reshaped_code,'left-msb');
        output=output1';
        Coding_rate=length(data)/length(output) / b_p_sym;
        
    case 2  % BCH Coding
        % Under development
        disp(' BCH coding is not included in this vesion. No coding is applied.')
       
end
   