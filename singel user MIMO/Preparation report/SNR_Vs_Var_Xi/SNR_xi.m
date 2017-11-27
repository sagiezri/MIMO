function [SNR] = SNR_xi(W,H,M,N,NoiseVar,index)
SNR_denominator_ai=0;SNR_numerator_ai=0;W_i=0;
    a_i= W'*H;    
    SNR_numerator_ai=norm(a_i(index)).^2;
    for i=1:M
        SNR_denominator_ai= SNR_denominator_ai+norm(a_i(1,i)).^2;
    end
    %Using the numerator value to calculate the second element in the
    %denominator to avoid "for" loops and condintions
    SNR_denominator_ai=SNR_denominator_ai-SNR_numerator_ai;
    W_i= NoiseVar.*norm(W(index,1)).^2;
    SNR=(SNR_numerator_ai)/(W_i+SNR_denominator_ai);
end