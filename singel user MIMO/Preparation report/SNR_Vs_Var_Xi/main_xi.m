clear all;
num_of_runs = 100;
SNRdB_rng=-30:10:60;
S_ZF=0;S_MMSE=0;S_MRC=0;S_MRC_Th=0;S_ZF_Th=0;
N_T=6;M=6;
noise_var_vec=10.^(-SNRdB_rng/10);
SNR_MRC_Theory=zeros(1,M);SNR_ZF_Theory=zeros(1,M);

%'i' for x & x_estimation index
i=5;

%For a case that we want to use the "real" H matrix
%{
%For generate the H matrix
L=4;a=2;lambdaTx=0.005;lambdaBs=0.001;axisXY=100;
[r_ij_BS,M,B]=Gen_R_ij(lambdaTx,lambdaBs,axisXY);

%Duplicate for each antena in each BS
r_ij=repelem(r_ij_BS,L,1);
N_T=B.*L;
H = gen_random_normal_mat(N_T,M).*((r_ij).^(-a./2));
%}


for runsCounter=1:num_of_runs
    for nc=1:length(noise_var_vec)
        
        sum_MRC_Theory=0;
        sum_ZF_Theory=0;
        noise_var=noise_var_vec(nc);
        H = gen_random_normal_mat(N_T,M);n = gen_random_normal_mat_var(N_T,1,noise_var);x = gen_random_normal_mat(M,1);
        y = H*x+n;
        
        %MRC
        W_MRC = H;
        W_MRC_i = W_MRC(:,i);
        x_MRC_e = W_MRC_i'*y;
        SNR_MRC(:,nc) = SNR_xi(W_MRC,H,M,N_T,noise_var,i);
        %Start the theoretical compute 
        for c=1:N_T
            sum_MRC_Theory =sum_MRC_Theory+(norm(H(c,i))).^2;
        end
        SNR_MRC_Theory(1,nc)=sum_MRC_Theory./noise_var;
    
        %ZF
        W_ZF=inv(H);
        W_ZF_i = W_ZF(:,i);
        x_ZF_e = W_ZF_i'*y;
        SNR_ZF(:,nc) = SNR_xi(W_ZF_i,H,M,N_T,noise_var,i);
        %Start the theoretical compute
        for c=1:N_T
            sum_ZF_Theory=sum_ZF_Theory+norm(W_ZF(c,i)).^2;
        end
        SNR_ZF_Theory(1,nc)=1./(noise_var.*(sum_ZF_Theory));
        
        %MMSE
        W_MMSE = inv((H*H'+eye(N_T)))*H;
        W_MMSE_i = W_MMSE(:,i);
        x_MMSE_e = W_MMSE_i'*y;
        SNR_MMSE(:,nc) = SNR_xi(W_MMSE_i,H,M,N_T,noise_var,i);
    end
    
    %Compute for each Var loop
    S_ZF=S_ZF+SNR_ZF;
    S_MMSE=S_MMSE+SNR_MMSE;
    S_MRC=S_MRC+SNR_MRC;
    
    S_MRC_Th=S_MRC_Th+SNR_MRC_Theory;
    S_ZF_Th=S_ZF_Th+SNR_ZF_Theory;
end

S_ZF=S_ZF./num_of_runs;S_MMSE=S_MMSE./num_of_runs;S_MRC=S_MRC./num_of_runs;

S_MRC_Th=S_MRC_Th./num_of_runs;S_ZF_Th=S_ZF_Th./num_of_runs;


figure(1)
plot(noise_var_vec,SNR_MRC,'r')
title('SNR Vs Noise var Per method - One interation')
xlabel('Nosie Var')
ylabel('SNR')
hold on
plot(noise_var_vec,SNR_ZF,'b')
hold on
plot(noise_var_vec,SNR_MMSE,'g')
legend('MRC','ZF','MMSE')
hold on

figure(2)
plot(noise_var_vec,S_MRC,'r')
title('SNR Vs Noise var Per method - n iterations')
xlabel('Nosie Var')
ylabel('SNR')
hold on
plot(noise_var_vec,S_ZF,'b')
hold on
plot(noise_var_vec,S_MMSE,'g')
legend('MRC','ZF','MMSE')
hold on

%Difference between "real" SNR to the theoritical
disp('MRC comperation - real to theoretical')
S_MRC_Th-S_MRC
disp('ZF comperation - real to theoretical')
S_ZF_Th-S_ZF

