clear all;
clc;
close all;
lambda=50;
numOfTransmiters=4;
numOfBS=2;
kNearestBS=1;
nearestTransToBS=zeros(kNearestBS,2);
transBSTable=zeros(numOfTransmiters,(kNearestBS+1).*2);



transPoints = poissrnd(lambda,numOfTransmiters, 2);
bsPoints = poissrnd(lambda,numOfBS, 2);
maxX=max(max(transPoints(:, 1)),max(bsPoints(:,1)));
maxY=max(max(transPoints(:, 2)),max(bsPoints(:,2)));
minX=min(min(transPoints(:, 1)),min(bsPoints(:,1)));
minY=min(min(transPoints(:, 2)),min(bsPoints(:,2)));
R=sqrt(norm(maxX,maxY))./2;


for i=1:numOfTransmiters
    bsPointsChange=bsPoints;
    nearestTransToBS=zeros(kNearestBS,2);
    for j=1:kNearestBS
    [nearestTransToBS(j,:),bsPointsChange]=nearestBS(transPoints(i,:),bsPointsChange,R);
    end
    
    nearestTransToBS_row=nearestTransToBS(1,:)
    for g=2:(kNearestBS)
    nearestTransToBS_row=[nearestTransToBS_row,nearestTransToBS(g,:)]
    end
    %Each row in transBSTable repersent (x_t,y_t) grid where the first two
    %cells are the transmiter location and the k*2 cells after are the nearest BS
    %locations -> (Xt,Yt,Xbs1,Yb1...Xbsk,Ybk)
    transBSTable(i,:)=[transPoints(i,:),nearestTransToBS_row];
end



figure(1)

plot(transPoints(:, 1), transPoints(:, 2), '*');
axis([0 lambda.*2 0 lambda.*2]);
title('BS and Transmiters')
xlabel('x plain')
ylabel('y plain')
hold on
plot(bsPoints(:, 1), bsPoints(:, 2), 'o');
legend('Transmiters','BS');
hold off


transIndexToPlot=1;
figure(2)
plot(transBSTable(transIndexToPlot,1),transBSTable(transIndexToPlot,2), '*');
axis([0 lambda.*2 0 lambda.*2]);
title('Transmiters Vs Nearest BS')
xlabel('x plain')
ylabel('y plain')
hold on
for i=1:kNearestBS
    plot(transBSTable(transIndexToPlot, i.*2+1), transBSTable(transIndexToPlot, i.*2+2), 'o');
end
legend('Transmiters','BS');
hold off


