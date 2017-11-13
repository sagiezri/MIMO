clear all;
N = 6;M=6;
r = ones(N,M);a=2;
num_of_runs = 1;
sum_SNR_ZF_W=[];
sum_SNR_MMSE_W=[];
sum_SNR_MRC_W=[];
noise_var_vec=[];
noise_var=1;
while noise_var<10
    noise_var=noise_var.*10;
    noise_var_vec(1,log10(noise_var))=log10(noise_var);
    for index = 1:num_of_runs
        H = gen_random_normal_mat(N,M);n = gen_random_normal_mat_var(N,1,noise_var);x = gen_random_normal_mat(M,1);
        y = H*x+n;
        W_MRC = H;
        x_MRC_e = W_MRC'*y;
        W_ZF = inv((H'));
        x_ZF_e = W_ZF'*y;
        W_MMSE = inv((H*H'+eye(N)))*H;
        x_MMSE_e = W_MMSE'*y;
        %SNR by W
        SNR_MRC_W(:,index) = SNR_W(W_MRC,H,M,M,1);
        SNR_ZF_W(:,index) = SNR_W(W_ZF,H,M,M,1);
        SNR_MMSE_W(:,index) = SNR_W(W_MMSE,H,M,M,1);
        %SNR By H
        SNR_MRC_H(:,index) = SNR_MRC(H,M,M,1);
        SNR_ZF_H(:,index) = SNR_ZF(H,M,M,1);
        %SNR_MMSE_H(:,index) = SNR(H,M,M,1);   
     
    end
    S_ZF_W=sum(SNR_ZF_W,2)./num_of_runs;
    S_MMSE_W=sum(SNR_MMSE_W,2)./num_of_runs;
    S_MRC_W=sum(SNR_MRC_W,2)./num_of_runs;
    S1_ZF_W=S_ZF_W(1);
    S1_MMSE_W=S_MMSE_W(1);
    S1_MRC_W=S_MRC_W(1); 
    sum_SNR_ZF_W(1,log10(noise_var)) = S1_ZF_W;
    sum_SNR_MMSE_W(1,log10(noise_var)) = S1_MMSE_W;
    sum_SNR_MRC_W(1,log10(noise_var)) = S1_MRC_W;
 
    
    S_ZF_H=sum(SNR_ZF_H,2)./num_of_runs;
    %S_MMSE_W=sum(SNR_MMSE_W,2)./num_of_runs;
    S_MRC_H=sum(SNR_MRC_H,2)./num_of_runs;
    S1_ZF_H=S_ZF_H(1);
    %S1_MMSE_W=S_MMSE_W(1);
    S1_MRC_H=S_MRC_H(1); 
    sum_SNR_ZF_H(1,log10(noise_var)) = S1_ZF_H;
    %sum_SNR_MMSE_W(1,log10(noise_var)) = S1_MMSE_W;
    sum_SNR_MRC_H(1,log10(noise_var)) = S1_MRC_H;
end

    
Def_HW_ZF=sum_SNR_ZF_H-sum_SNR_ZF_W;
Def_HW_MRC=sum_SNR_MRC_H-sum_SNR_MRC_W;


figure(1)
plot(noise_var_vec,sum_SNR_MRC_W,'r')
title('SNR Vs Noise var Per method')
xlabel('Log(Nosie Var)')
ylabel('SNR')
hold on
plot(noise_var_vec,sum_SNR_ZF_W,'b')
hold on
plot(noise_var_vec,sum_SNR_MMSE_W,'g')
legend('MRC','ZF','MMSE')

figure(2)
plot(noise_var_vec,sum_SNR_MRC_H,'r')
title('SNR Vs Noise var Per method')
xlabel('Log(Nosie Var)')
ylabel('SNR')
hold on
plot(noise_var_vec,sum_SNR_ZF_H,'b')
%hold on
%plot(noise_var_vec,sum_SNR_MMSE_W,'g')
%legend('MRC','ZF','MMSE')



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
