function [H] = gen_transmit(N,r,a,num_stream_each_transmit, num_unwanted_users)
    for i = 1:num_unwanted_users
        H_rand = chanel(N).*(r.^(a/2));%gen chanel for each user to BS
        [U,sig,V_H] = svd(H_rand);
        F = V_H(:,1:num_stream_each_transmit(i));
        HjFj = H_rand*F;
        H{i} = HjFj;
    end
end