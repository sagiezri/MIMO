function [SNR] = Performance_check(w_i,H_i,i,NoiseVar)
    SNR_denominator_ai=0;SNR_numerator_ai=0;W_i_denominator=0;
    a_i= w_i'*H_i;    
    SNR_numerator_ai=norm(a_i(i)).^2;
    SNR_denominator_ai=sum(norm(a_i).^2);
    %Using the numerator value to calculate the second element in the
    %denominator to avoid "for" loops and condintions
    SNR_denominator_ai=SNR_denominator_ai-SNR_numerator_ai;
    W_i_denominator= NoiseVar.*(norm(w_i).^2);
    SNR=(SNR_numerator_ai)/(W_i_denominator+SNR_denominator_ai);
end
