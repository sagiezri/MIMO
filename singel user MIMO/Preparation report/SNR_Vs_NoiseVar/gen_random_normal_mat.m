function [H] = gen_random_normal_mat(N,M)
H = sqrt(1/2).*crandn(N,M);
end