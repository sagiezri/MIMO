function [ nearestBS,bsPoints ] = nearestBS(transPoint,bsPoints,R)
minDisTtoR=inf;
transR=mod(sqrt(norm(transPoint(1,1),transPoint(1,2))),R);
%transR=sqrt(norm(transPoint(1,1),transPoint(1,2)));

for i=1:length(bsPoints)
    bsR=mod(sqrt(norm(bsPoints(i,1),bsPoints(i,2))),R);
    %bsR=sqrt(norm(bsPoints(i,1),bsPoints(i,2)));
    disTtoBS=abs(transR-bsR);
    if(minDisTtoR>disTtoBS)
    minDisTtoR=disTtoBS;
    nearestBS=bsPoints(i,:);
    indexToRemove=i;
    end
end
bsPoints(indexToRemove,:)=[];

