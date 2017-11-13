clear all;
N = 6;M=6;
r = ones(N,M);a=2;
num_of_runs = 1000;
sum_SNR_ZF=[];
sum_SNR_MMSE=[];
sum_SNR_MRC=[];
noise_var_vec=[];
noise_var=1;
while noise_var<99999
    noise_var=noise_var.*10;
    noise_var_vec(1,log10(noise_var))=log10(noise_var);
    for index = 1:num_of_runs
        H = gen_random_normal_mat(N,M);n = gen_random_normal_mat_var(N,1,noise_var);x = gen_random_normal_mat(M,1);
        y = H*x+n;
        W_MRC = H;
        x_MRC_e = W_MRC'*y;
        SNR_MRC(:,index) = SNR(W_MRC,H,M,M,1);
        W_ZF = inv((H'));
        x_ZF_e = W_ZF'*y;
        SNR_ZF(:,index) = SNR(W_ZF,H,M,M,1);
        W_MMSE = inv((H*H'+eye(N)))*H;
        x_MMSE_e = W_MMSE'*y;
        SNR_MMSE(:,index) = SNR(W_MMSE,H,M,M,1);
    end
    S_ZF=sum(SNR_ZF,2)./num_of_runs;
    S1_ZF=S_ZF(1);
    sum_SNR_ZF(1,log10(noise_var)) = S1_ZF;
    S_MMSE=sum(SNR_MMSE,2)./num_of_runs;
    S1_MMSE=S_MMSE(1);
    sum_SNR_MMSE(1,log10(noise_var)) = S1_MMSE;
    S_MRC=sum(SNR_MRC,2)./num_of_runs;
    S1_MMSE=S_MRC(1);
    sum_SNR_MRC(1,log10(noise_var)) = S1_MMSE;
end

    
plot(noise_var_vec,sum_SNR_MRC,'r')
title('SNR Vs Noise var Per method')
xlabel('Log(Nosie Var)')
ylabel('SNR')
hold on
plot(noise_var_vec,sum_SNR_ZF,'b')
hold on
plot(noise_var_vec,sum_SNR_MMSE,'g')
legend('MRC','ZF','MMSE')




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
