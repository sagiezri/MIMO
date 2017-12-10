function [H] = ChannelCalculation(L,a,lambdaTx,lambdaBs,axisXY)
M=poissrnd(lambdaTx*axisXY.^2);
B=poissrnd(lambdaBs*axisXY.^2);
MPoints = rand(M, 2).*axisXY;
BPoints = rand(B, 2).*axisXY;
r_ij=zeros(B,M);

BPoints=BPoints(:,1)+1i.*BPoints(:,2);
MPoints=MPoints(:,1)+1i.*MPoints(:,2);

Mx=real(MPoints);
My=imag(MPoints);
Bx=real(BPoints);
By=imag(BPoints);

for i=1:M
     r_ij(:,i)=sqrt((((-axisXY./2)+mod(abs(Mx(i)-Bx)+(axisXY./2),axisXY))).^2+(((-axisXY./2)+mod(abs(My(i)-By)+(axisXY./2),axisXY))).^2);  
end

r_ij=repelem(r_ij,L,1);
N=B.*L;
H = gen_random_normal_mat(N,M).*((r_ij).^(-a./2));


figure(1)
plot(Mx, My, '*');
title('BS and Transmiters')
xlabel('x plain')
ylabel('y plain')
hold on
plot(Bx, By, 'o');
legend('Transmiters','BS');
hold off

end
