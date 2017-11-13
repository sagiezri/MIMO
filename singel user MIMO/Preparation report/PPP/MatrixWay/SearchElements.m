function [ elementsCoordinates ] = SearchElements( A,N,M,searchValue,elementsNum )
k=1;
 elementsCoordinates=zeros(elementsNum,2);
 for i=1:N
    for j=1:M
            if(A(i,j)==searchValue || A(i,j)==3)
                elementsCoordinates(k,1)=i+N;
                elementsCoordinates(k,2)=j+M;
                k=k+1;
            end
     end
 end
end
%Sagi
