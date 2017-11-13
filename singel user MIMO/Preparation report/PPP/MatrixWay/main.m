N=6;M=6;
numOfBaseStations=5;
numOfTransmiters=10;
TxRxPlain= zeros(N,M);
randLocatBaseStations=randperm(numel(TxRxPlain), numOfBaseStations);
randLocatTransmiters=randperm(numel(TxRxPlain), numOfTransmiters);

%Also support the case we have R & T in the same area unit
cellMembers=ElementsTypeInCell( randLocatBaseStations,randLocatTransmiters,N,M );
cellMembersSum=sum(cellMembers,2);

for i=1:(N.*M)
   TxRxPlain(i)=cellMembersSum(i);
end

dupTxRxPlain=repmat(TxRxPlain,3);
 
coordinatesBaseStationInDup=SearchElements(TxRxPlain,N,M,1,numOfBaseStations);
coordinatesTransmiterInDupMat=SearchElements(TxRxPlain,N,M,2,numOfTransmiters);

dupCoordinatesTxRxPlain_BS=CoordinatesDupPlain(coordinatesBaseStationInDup,N,M);

%The left is the two Tx coordinates and the two right is the Rx coordinates
MinDistanceTxToRx=MinDisCalcTtoS(dupCoordinatesTxRxPlain_BS,coordinatesTransmiterInDupMat);

