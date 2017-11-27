function [r_ij,numPointsTx,numPointsBS] = Gen_R_ij(lambdaTx,lambdaBs,axisXY)

numPointsTx=poissrnd(lambdaTx*axisXY.^2);
numPointsBS=poissrnd(lambdaBs*axisXY.^2);
transPoints = rand(numPointsTx, 2).*axisXY;
bsPoints = rand(numPointsBS, 2).*axisXY;


bsPoints=bsPoints(:,1)+j.*bsPoints(:,2);
transPoints=transPoints(:,1)+j.*transPoints(:,2);

xTrans=real(transPoints);
yTrans=imag(transPoints);
xBS=real(bsPoints);
yBS=imag(bsPoints);

for i=1:numPointsTx
     r_ij(:,i)=sqrt((((-axisXY./2)+mod(abs(xTrans(i)-xBS)+(axisXY./2),axisXY))).^2+(((-axisXY./2)+mod(abs(yTrans(i)-yBS)+(axisXY./2),axisXY))).^2);  
end

% figure(1)
% plot(xTrans, yTrans, '*');
% title('BS and Transmiters')
% xlabel('x plain')
% ylabel('y plain')
% hold on
% plot(xBS, yBS, 'o');
% legend('Transmiters','BS');
% hold off
end


