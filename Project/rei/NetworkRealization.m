%*************************************************************************%
%Network realization function - roles:
%1.Calculate number of users & BS in our simulation space
%2.Compute r_ij matrix - the distance between each user to BS
%3.Build with r_ij & g_ij(normal disturbed values that chatisctic our
%channel) & a the big H matrix.

%Global input: a(scalar),L(scalar).
%Input: B_avg(scalar),M_avg(scalar),lambda_b(scalar),lambda(scalar).
%Output:B(scalar),M(scalar),r_ij(real matrix-BXM),H(complex matrix-BLXM).
%*************************************************************************%

function [B,M,r_ij,H] = NetworkRealization(L,a,B_avg,M_avg,lambda_b,lambda,K)

  
    [User_location,BS_location,M,B,R]=HPPP(B_avg,M_avg,lambda_b,lambda);
    
    
    function [User_location,BS_location,M,B,R]=HPPP(B_avg,M_avg,lambda_b,lambda)
            R_M=sqrt(M_avg./lambda);
            R_B=sqrt(B_avg./lambda_b);
            if R_M==R_B
                R=R_M;          
            else
                disp('Please enter Users & BS correspanding to thier lambda'); 
                 R=0;
            end
            %Number of Users & BS 
            M=poissrnd(M_avg);
            B=poissrnd(B_avg);
            M = max(M,K*L);
            B = max(B,K);
            %Users & BS location
            User_location=zeros(1,M);
            BS_location=zeros(1,B);
            User_location=(rand(M, 1).*R)+1i.*(rand(M, 1).*R);
            BS_location=(rand(B,1).*R)+1i.*(rand(B,1).*R);
            User_location=User_location.';
            BS_location=BS_location.';
    end
 
 function [r_ij]=Compute_r_ij(User_location,BS_location,M,B,R)
            %Generate BXM matrix by duplicate each user row
            User_location=repelem(User_location,B,1);
            %Generate BXM matrix by duplicate each BS col
            BS_location=repelem(BS_location.',1,M);
            %Create r_ij matrix according to the Eq from the HLD
            r_ij=sqrt(((-R/2)+mod(real(User_location)-real(BS_location)+(R/2),R)).^2+((-R/2)+mod(imag(User_location)-imag(BS_location)+(R/2),R)).^2);           
end

    [r_ij]=Compute_r_ij(User_location,BS_location,M,B,R);
    
    
function [H]=Generate_H(L,a,r_ij,M,B)
            %Create BLXM matrix - the channel to each antena - L global
            H=(sqrt(1/2).*crandn(B.*L,M));
            %Duplicate each row in r_ij to match the H matrix
            r_ij_H=repelem(r_ij,L,1);
            %Compute H matrix - a global
            H=(H.*r_ij_H).^(-a./2);           
end
  
    [H]=Generate_H(L,a,r_ij,M,B);    

end


    



    


