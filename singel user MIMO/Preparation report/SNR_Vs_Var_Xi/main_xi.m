clear all;
num_of_runs = 10000;
SNRdB_rng=-30:10:60;
S_ZF=0;S_MMSE=0;S_MRC=0;
%For a case that we want to use the "real" H matrix
%{
%For generate the H matrix
L=4;a=2;lambdaTx=0.005;lambdaBs=0.001;axisXY=100;
[r_ij_BS,M,B]=Gen_R_ij(lambdaTx,lambdaBs,axisXY);

%Duplicate for each antena in each BS
r_ij=repelem(r_ij_BS,L,1);
N_T=B.*L;
H = gen_random_normal_mat(N_T,M).*((r_ij).^(-a./2));
%
%}

noise_var_vec=10.^(-SNRdB_rng/10);
%Index number x_i & x estimation 
i=5;

N_T=6;M=6;

for runsCounter=1:num_of_runs
for nc=1:length(noise_var_vec)
    noise_var=noise_var_vec(nc);
    H = gen_random_normal_mat(N_T,M);n = gen_random_normal_mat_var(N_T,1,noise_var);x = gen_random_normal_mat(M,1);
    y = H*x+n;
    W_MRC = H;
    W_MRC_i = W_MRC;
    x_MRC_e = W_MRC_i'*y;
    SNR_MRC(:,nc) = SNR_xi(W_MRC,H,M,N_T,noise_var,i);
    
    W_ZF=inv(H);
    W_ZF_i = W_ZF(:,i);
    x_ZF_e = W_ZF_i'*y;
    SNR_ZF(:,nc) = SNR_xi(W_ZF_i,H,M,N_T,noise_var,i);
    
    W_MMSE = inv((H*H'+eye(N_T)))*H;
    W_MMSE_i = W_MMSE(:,i);
    x_MMSE_e = W_MMSE_i'*y;
    SNR_MMSE(:,nc) = SNR_xi(W_MMSE_i,H,M,N_T,noise_var,i);
end
    S_ZF=S_ZF+SNR_ZF;
    S_MMSE=S_MMSE+SNR_MMSE;
    S_MRC=S_MRC+SNR_MRC;
end

S_ZF=S_ZF./num_of_runs;S_MMSE=S_MMSE./num_of_runs;S_MRC=S_MRC./num_of_runs;

figure(1)
plot(noise_var_vec,SNR_MRC,'r')
title('SNR Vs Noise var Per method')
xlabel('Log(Nosie Var)')
ylabel('SNR')
hold on
plot(noise_var_vec,SNR_ZF,'b')
hold on
plot(noise_var_vec,SNR_MMSE,'g')
legend('MRC','ZF','MMSE')
hold on

figure(2)
plot(noise_var_vec,S_MRC,'r')
title('SNR Vs Noise var Per method')
xlabel('Log(Nosie Var)')
ylabel('SNR')
hold on
plot(noise_var_vec,S_ZF,'b')
hold on
plot(noise_var_vec,S_MMSE,'g')
legend('MRC','ZF','MMSE')
hold on
 
 
% plot(1:6,sum_SNR_MRC,'r')
% title('SNR per method')
% xlabel('sample')
% ylabel('SNR')
% hold on
% plot(1:6,sum_SNR_ZF,'b')
% hold on
% plot(1:6,sum_SNR_MMSE,'g')
% legend('MRC','ZF','MMSE')
% num_unwanted_users = 2;num_stream_each_user = [3,2];
% k0 = N-sum(num_stream_each_user);k_ZF = N - k0;
% z_data = gen_data(N,k0,k_ZF,num_unwanted_users,num_stream_each_user);
% H_other_users = gen_transmit(N,r,a,num_stream_each_user, num_unwanted_users);
% H_ZF = H_zero_forcing(H_other_users,num_unwanted_users);
% H0F0 = gen_H0F0(N,r,a,k0);
% y_interferance = sum_Y_interferance(num_unwanted_users,N,H_other_users,z_data);
% Y = H0F0*transpose(z_data{1}) + y_interferance;
% [Z_e, W_ZF] = receiver_ZF(Y,H_ZF,H0F0,N);
% norm(W_ZF' * y_interferance)