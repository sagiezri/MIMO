function [ dupCoordinates ] = CoordinatesDupPlain(coordinates,N,M)

dupCoordinates = repmat(coordinates,9,1);

for i=1:8
    for j=(i.*(length(coordinates))+1):((i.*(length(coordinates)))+(length(coordinates)))
    if(i==1)
        dupCoordinates(j,1)=dupCoordinates(j,1)+N;
    end
    if(i==2)
       dupCoordinates(j,1)=dupCoordinates(j,1)+N;
        dupCoordinates(j,2)=dupCoordinates(j,2)-M;
    end
    if(i==3)
        dupCoordinates(j,2)=dupCoordinates(j,2)-M;
    end
    if(i==4)
        dupCoordinates(j,1)=dupCoordinates(j,1)-N;
        dupCoordinates(j,2)=dupCoordinates(j,2)-M;
    end
    if(i==5)
        dupCoordinates(j,1)=dupCoordinates(j,1)-N;
    end
    if(i==6)
       dupCoordinates(j,1)=dupCoordinates(j,1)-N;
       dupCoordinates(j,2)=dupCoordinates(j,2)+M;
    end
    if(i==7)
        dupCoordinates(j,2)=dupCoordinates(j,2)+M;
    end
    if(i==8)
        dupCoordinates(j,1)=dupCoordinates(j,1)+N;
        dupCoordinates(j,2)=dupCoordinates(j,2)+M;
    end
        
    end
end



end

