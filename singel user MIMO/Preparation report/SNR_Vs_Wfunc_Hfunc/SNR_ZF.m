function [SNR] = SNR_ZF(H,M,N,NoiseVar)  
H_ZF=inv((H'));

SNR=[];        
    for i=1:M
        H_SNR_i_ZF=0;
       for j=1:N        
          H_SNR_i_ZF=H_SNR_i_ZF+norm(H_ZF(i,j));
       end
    H_SNR_i_ZF= (1./NoiseVar).*(1./H_SNR_i_ZF);
    SNR(i,1)=(H_SNR_i_ZF);
    end
end