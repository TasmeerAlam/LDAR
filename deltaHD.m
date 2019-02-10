%Vary Distance and Height H and Distance D
%Vary D
close all
clear all
Hr=1;
for D=1:1000

%Vary H
for H= 1:1000

D2=sqrt((H+Hr)^2 + D^2) ;%Reflection dist
D1=sqrt((H-Hr)^2 +D^2) ; %Direct distance
%Dist2(Index) = D2;
%Dist1(Index) = D1;
delta1=D2-D1 ; %this is the difference in path lenth
DeltaH(D,H)= (2*(H+Hr)^2/D2) - (2*(H-Hr)^2/D1);
DeltaD(D,H)= (2*(D/D2)) - (2*(D)/D1);
Delta(D,H)= delta1;
end
end
mesh(Delta)
figure(2)
mesh(DeltaH)
figure(3)
mesh(DeltaD(1:20,1:20))
DH=Delta(500,1:1000)
HD=Delta(500:1000,1)