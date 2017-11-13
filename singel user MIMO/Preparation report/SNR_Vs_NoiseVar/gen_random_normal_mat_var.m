function [H] = gen_random_normal_mat_var(N,M,noise_var)
H = sqrt(1/2).*crandn(N,M).*noise_var;
end