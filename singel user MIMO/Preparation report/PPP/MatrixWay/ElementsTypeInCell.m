function [ cellData ] = ElementsTypeInCell( randLocatBaseStations,randLocatTransmiters,N,M )
cellData=zeros(N.*M,2);
for i=1:length(randLocatBaseStations)
    cellData(randLocatBaseStations(i),1)=1;
end
for i=1:length(randLocatTransmiters)
    cellData(randLocatTransmiters(i),2)=2;
end

    
end

