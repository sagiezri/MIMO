function [H,Ki] = Knearest(H,i,k)

minDisTtoBS=10e8;
[rowsH,~]=size(H);
Ki=zeros(1,k);
for j=1:rowsH
    r_ij=norm(H(j,i));
    if (minDisTtoBS>r_ij)
        minDisTtoBS=r_ij;
        Ki=j;
    end
end
H(Ki,i)=10e8;
end