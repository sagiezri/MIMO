function [SNR] = SNR_MRC(H,M,N,NoiseVar)   
    SNR=[];        
    for i=1:N
       SNR_numerator_Hi=0;
       SNR_denominator_Hi_Sec=0;
       for j=1:N
          SNR_numerator_Hi=SNR_numerator_Hi+norm(H(j,i));      
       end
       SNR_numerator_Hi_top=(SNR_numerator_Hi).^2;
       for j=1:M
           h_sum_sec=0;
            if (~(j == i))
                for k=1:N             
                    h_sum_sec=h_sum_sec+(conj(H(k,i)).*H(k,j));                  
                end               
               SNR_denominator_Hi_Sec=SNR_denominator_Hi_Sec + (norm(h_sum_sec));
            end
            
       end     
    SNR_denominator_Ai_Fir= NoiseVar.*SNR_numerator_Hi;
    SNR(i,1)=(SNR_numerator_Hi_top)/(SNR_denominator_Ai_Fir+SNR_denominator_Hi_Sec);
    end
end