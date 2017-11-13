function [Z_ZF] = gen_data(N,k0,k_ZF,num_unwanted_users,num_stream_each_user)
    size_of_data_each_user = [k0 num_stream_each_user];
    for i = 1:length(size_of_data_each_user)
        Z_ZF{i} = sqrt(1/2).*crandn(N,size_of_data_each_user(i));
    end
end