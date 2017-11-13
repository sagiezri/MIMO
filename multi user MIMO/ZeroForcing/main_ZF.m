clear all;
N = 6;
r = ones(N,N);a=2;num_unwanted_users = 2;num_stream_each_user = [3,2];
k0 = N-sum(num_stream_each_user);k_ZF = N - k0;
z_data = gen_data(N,k0,k_ZF,num_unwanted_users,num_stream_each_user);
H_other_users = gen_transmit(N,r,a,num_stream_each_user, num_unwanted_users);
H_ZF = H_zero_forcing(H_other_users,num_unwanted_users);
H0F0 = gen_H0F0(N,r,a,k0);
y_interferance = sum_Y_interferance(num_unwanted_users,N,H_other_users,z_data);
Y = H0F0*transpose(z_data{1}) + y_interferance;
[Z_e, W_ZF] = receiver_ZF(Y,H_ZF,H0F0,N);
norm(W_ZF' * y_interferance)
