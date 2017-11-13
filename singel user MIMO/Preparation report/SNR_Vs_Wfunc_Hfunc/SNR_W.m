function [SNR] = SNR_W(W,H,M,N,NoiseVar)
    A = W'*H;    
    SNR=[];        
    for i=1:M
       SNR_numerator_Ai=0;
       SNR_numerator_Ai=norm(A(i,i));
       SNR_denominator_Ai=0;
       W_i=0;
       for j=1:M
            if (~(j == i))
               SNR_denominator_Ai=SNR_denominator_Ai + norm(A(i,j));
            end
       end
       for k=1:N        
          W_i=W_i+norm(W(i,k));
       end
    W_i= NoiseVar.*W_i;
    SNR(i,1)=(SNR_numerator_Ai)/(W_i+SNR_denominator_Ai);
    end
end