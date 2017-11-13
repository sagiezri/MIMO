function [ nearestBaseStation ] = MinDisCalcTtoS(dupCoordinatesTxRxPlain_BS,coordinatesTransmiterInDupMat)
    
nearestBS=1;

for i=1:length(coordinatesTransmiterInDupMat)
    minDis=(sqrt(norm(coordinatesTransmiterInDupMat(i)-dupCoordinatesTxRxPlain_BS(1))));
    
    for j=1:length(dupCoordinatesTxRxPlain_BS)   
        
        if(minDis>(sqrt(norm(coordinatesTransmiterInDupMat(i)-dupCoordinatesTxRxPlain_BS(j)))))
            minDis=(sqrt(norm(coordinatesTransmiterInDupMat(i)-dupCoordinatesTxRxPlain_BS(j))));
            nearestBS=j;
         end
    end
    nearestBaseStation(i,:)=[coordinatesTransmiterInDupMat(i,:),dupCoordinatesTxRxPlain_BS(nearestBS,:)]; 
end

end


