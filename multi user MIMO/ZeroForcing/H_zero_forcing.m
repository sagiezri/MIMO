function [H_ZF] = H_zero_forcing(H,num_unwanted_users)
H_ZF = [];
    for i = 1:num_unwanted_users
        H_ZF = [H_ZF H{i}];
    end
end
