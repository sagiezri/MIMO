clear all;
clc;
close all;
lambdaTx=50;
lambdaBs=20;
areaSize=1e3;
numPointsTx=poissrnd(lambdaTx);
numPointsBS=poissrnd(lambdaBs);
transPoints = rand(numPointsTx, 2).*areaSize;
bsPoints = rand(numPointsBS, 2).*areaSize;
R=sqrt(2.*areaSize)./2;

bsPoints=bsPoints(:,1)+j.*bsPoints(:,2);
transPoints=transPoints(:,1)+j.*transPoints(:,2);

r_ij=zeros(numPointsTx,numPointsBS);
for i=1:numPointsTx
    for j=1:numPointsBS
     r_ij(i,j)=mod(abs(bsPoints(j)-transPoints(i)),R);
    end
end




% figure(1)
% plot(transPoints(:, 1), transPoints(:, 2), '*');
% title('BS and Transmiters')
% xlabel('x plain')
% ylabel('y plain')
% hold on
% plot(bsPoints(:, 1), bsPoints(:, 2), 'o');
% legend('Transmiters','BS');
% hold off



