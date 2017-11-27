function [SNR] = SNR_xi(W,H,M,N,NoiseVar,index)
SNR_denominator_ai=0;SNR_numerator_ai=0;W_i=0;
    a_i= W'*H;    
    SNR_numerator_ai=norm(a_i(index));
    for i=1:M
        SNR_denominator_ai= SNR_denominator_ai+norm(a_i(1,i));
    end
    SNR_denominator_ai=SNR_denominator_ai-SNR_numerator_ai;
    W_i= NoiseVar.*norm(W(index,1));
    SNR=(SNR_numerator_ai)/(W_i+SNR_denominator_ai);
end