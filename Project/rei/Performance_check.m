function [SNR] = Performance_check(Receiver_type,w_i,H_i,i,NoiseVar)
    if Receiver_type ~= 0
        i = 1;
    end
    w_i=w_i';
    SNR_denominator_ai=0;SNR_numerator_ai=0;W_i_denominator=0;
    a_i= w_i*H_i;    
    SNR_numerator_ai=(abs(a_i(i))).^2;
    SNR_denominator_ai=sum((abs(a_i)).^2);
    %Using the numerator value to calculate the second element in the
    %denominator to avoid "for" loops and condintions
    SNR_denominator_ai=SNR_denominator_ai-SNR_numerator_ai;
    W_i_denominator= NoiseVar.*sum(abs(w_i).^2);
    SNR=(SNR_numerator_ai)/(W_i_denominator+SNR_denominator_ai);
    
end
