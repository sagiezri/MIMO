clear all;
N = 6;
z_ZF = gen_data(N,N);
r = ones(1,N);a=2;num_transmit = 3;num_stream_each_transmit = [2,2,2];
H = gen_transmit(N,r,a,num_stream_each_transmit, num_transmit);
H_ZF = H_zero_forcing(H,num_transmit);
H0F0 = H{1,1};
sum_y_interferance = zeros(N,N);
for i = 2:num_transmit
   HjFj_Zj = H{1,i}*transpose(z_ZF(:,2*(i-1)+1:(2*i)));
   sum_y_interferance = sum_y_interferance + HjFj_Zj;
end
Y_ZF = H0F0*transpose(z_ZF(:,1:2)) + sum_y_interferance;
[Z_e, W_ZF] = receiver_ZF(Y_ZF,H_ZF,H0F0,N);
norm(W_ZF' * sum_y_interferance)
