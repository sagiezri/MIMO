clear all;
clc;
close all;
lambdaTx=0.05;
lambdaBs=0.02;
areaSize=1e3;
numPointsTx=poissrnd(areaSize*lambdaTx);
numPointsBS=poissrnd(areaSize*lambdaBs);
transPoints = rand(numPointsTx, 2).*areaSize;
bsPoints = rand(numPointsBS, 2).*areaSize;
% R=sqrt(2.*areaSize)./2;

bsPoints=bsPoints(:,1)+j.*bsPoints(:,2);
transPoints=transPoints(:,1)+j.*transPoints(:,2);

% r_ij=zeros(numPointsTx,numPointsBS);
% for i=1:numPointsTx
%     for j=1:numPointsBS
%      r_ij(i,j)=mod(abs(bsPoints(j)-transPoints(i)),R);
%     end
% end




figure(1)
plot(real(transPoints), imag(transPoints), '*');
title('BS and Transmiters')
xlabel('x plain')
ylabel('y plain')
hold on
plot(real(bsPoints), imag(bsPoints), 'o');
legend('Transmiters','BS');
hold off



