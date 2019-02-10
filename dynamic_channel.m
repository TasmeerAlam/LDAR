function [Received_ofdm_signal_CP]=dynamic_channel(ofdm_syms_CP,Channel_no,Eb_N0_dB,b_p_sym)

Serial_ofdm_signal = reshape (ofdm_syms_CP.',1,numel(ofdm_syms_CP)); 
x = Serial_ofdm_signal(1:end); %input from main OFDM code

load FreQ.mat % Doppler values from Deepak's code
    
if Channel_no == 1  %%taxi channel
    
length_h1 = 16; %length of channel tap
h1 = zeros (1,length_h1); % channel tap
h1([1 3 16]) = [1 0.95 0.2];
h = h1/sqrt(h1*h1'); % normalization
X = transpose (x);
ht = transpose([h, zeros(1,(length(x)-1))]);

z = FreQ(1:180); %doppler values
%z = zeros(1,180);
SI=70; %%SI= (length(x)+length(h))/length(doppler changes)

%N_tap = 3;
%SR=2*Bandwidth;
%dTH= 2*pi*z/SR; % Delta radian per sample
%TH=[0.0,0.0,0.0];

end

if Channel_no == 2  %%take off channel
    
length_h1 = 16; %length of channel tap
h1 = zeros (1,length_h1); % channel tap
h1([1 3 7 16]) = [1 0.95 0.2 0.0003];
h = h1/sqrt(h1*h1'); % normalization
X = transpose (x);
ht = transpose([h, zeros(1,(length(x)-1))]);

z = FreQ(181:480); %doppler values
%z = zeros(1,300);
SI=40; %%SI= (length(x)+length(h))/length(doppler changes)

%N_tap = 4;
%SR=2*Bandwidth;
%dTH= 2*pi*z/SR; % Delta radian per sample
%TH=[0.0,0.0,0.0,0.0];

end

if Channel_no == 3  %%cruise/steady state channel
    
length_h = 16; %length of channel tap
h1 = zeros (1,length_h); % channel tap
h1([1 3]) = [1 0.95];
h = h1/sqrt(h1*h1'); % normalization
X = transpose (x);
ht = transpose([h, zeros(1,(length(x)-1))]);

z = FreQ(481:780); %doppler values
%z = zeros(1,300);
%Z = [z, ones(1, (length(x)+length(h)-length(z)))];
%Z = [1, z, z, z, z, z, z, z, z, z, z, z, z, z, z, z, z, z, z, z, z];
SI=40; %%SI= (length(x)+length(h))/length(doppler changes)

%N_tap = 2;
%SR=2*Bandwidth;
%dTH= 2*pi*z/SR; % Delta radian per sample
%TH=[0.0,0.0];


end

%w = zeros(length(ht));
%c = 1; %percentage of change

for i=length(ht):-1:1
    
  
    
    %ht(3)= (Z((length(ht)+1-i)/SI)*ht(3));
    %Ht = (c*ht + (1-c)*Z(length(ht)+1-i));
    w(:,length(ht)+1-i) = [zeros(length(ht)-i,1);ht(1:i)];
    %ht(3) = ht(3)*exp(1i*Z);
    %ht(length(ht)+1-i) = Z(length(ht)+1-i)*ht(length(ht)+1-i);
    
    if (length(ht)+1-i)/SI == floor((length(ht)+1-i)/SI)
        ht(3)= ht(3)*exp(1i*(z((length(ht)+1-i)/SI)));
    end
    
    
  %{
    if i/SI == floor (i/SI)
    ht = (c*ht + (1-c)*z(i/SI));
    end 
  %}
  
  
end

H = w(1:length(w), 1:length(x)); %Toeplitz matrix using for loop
y = H*X; %convolution
Y = transpose(y);

%{
for k=1:N_tap
	TH(k)=TH(k) + dTH(k); 
    Y=Y*exp(1i*TH(k)); %add frequency shift per tap
end
%}


%iSNR = 10;

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
Received_ofdm_signal_CP= awgn(Y,SNR,'measured'); %add noise at SNR dB
