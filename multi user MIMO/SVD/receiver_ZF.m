function [Z_e, W] = receiver_ZF(Y_ZF,H_ZF,H0F0,N)
W = (eye(N) - (H_ZF*(inv((H_ZF')*H_ZF))*H_ZF'))*(H0F0);
Z_e = W'*Y_ZF;
end