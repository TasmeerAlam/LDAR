%Vary Distance and Height H and Height Hr

close all
clear all
Hr=1;
D=1000
for Hr=1:1000   %Vary Hr

%Vary H
for H= 1:1000

D2=sqrt((H+Hr)^2 + D^2) ;%Reflection dist
D1=sqrt((H-Hr)^2 +D^2) ; %Direct distance
%Dist2(Index) = D2;
%Dist1(Index) = D1;
delta1=D2-D1 ; %this is the difference in path lenth
% DeltaH(D,H)= (2*(H+Hr)^2/D2) - (2*(H-Hr)^2/D1);
% DeltaD(D,H)= (2*(D/D2)) - (2*(D)/D1);
Delta(Hr,H)= delta1;
end
end
mesh(Delta)
