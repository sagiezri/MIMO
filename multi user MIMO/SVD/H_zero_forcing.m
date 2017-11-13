function [H_ZF] = H_zero_forcing(H,num_transmit)
    if num_transmit > 1
        H_ZF = H{1,2};
        for i = 3:num_transmit
            H_ZF = [H_ZF,H{1,i}];
        end   
    else
        H_ZF = 0;
    end
end
