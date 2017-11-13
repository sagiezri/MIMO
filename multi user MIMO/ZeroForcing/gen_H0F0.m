function [H0F0] = gen_H0F0(N,r,a,k0)
        H_rand = chanel(N).*(r.^(a/2));%gen chanel for each user to BS
        [U,sig,V_H] = svd(H_rand);
        F = V_H(:,1:k0);
        H0F0 = H_rand*F;
end