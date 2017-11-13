function [H] = gen_transmit(N,r,a,num_stream_each_transmit, num_transmit)
    for i = 1:num_transmit
        H_rand = chanel(N).*(r(i).^(a/2));
        [U,sig,V_H] = svd(H_rand);
        F = V_H(:,1:num_stream_each_transmit);
        HjFj = H_rand*F;
        H{1,i} = HjFj;
    end
end