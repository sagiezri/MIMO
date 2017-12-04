clear all;
num_of_runs = 1000;
SNRdB_rng=-60:10:60;
noise_var_vec=10.^(-SNRdB_rng/10);

S_ZF=zeros(1,length(num_of_runs));S_MMSE=zeros(1,length(num_of_runs));S_MRC=zeros(1,length(num_of_runs));

S_Valid_MRC=zeros(1,length(num_of_runs));S_Valid_ZF=zeros(1,length(num_of_runs));S_Valid_MMSE=zeros(1,length(num_of_runs));

N=6;M=6;

%'i' for x & x_estimation index
i=5;



H_i = gen_random_normal_mat(N,M);
for nc=1:length(noise_var_vec)
        noise_var=noise_var_vec(nc);
        x_e_MRC=0;x_e_ZF=0;
    for runsCounter=1:num_of_runs
        
        n = gen_random_normal_mat_var(N,1,noise_var);x = gen_random_normal_mat(M,1);
        y = H_i*x+n;
        
        %MRC
        W_MRC_i = H_i(:,i);
        W_MRC_i=W_MRC_i./(W_MRC_i'*H_i(:,i));
        SNR_MRC(runsCounter) = SNR_xi(W_MRC_i,H_i,noise_var,i);
        x_Valid_MRC(runsCounter)=norm((x(i)-W_MRC_i'*y).^2);       
        
        %ZF
        W_ZF=inv(H_i');
        W_ZF_i = W_ZF(:,i);
        W_ZF_i =  W_ZF_i./( W_ZF_i'*H_i(:,i));
        SNR_ZF(runsCounter) = SNR_xi(W_ZF_i,H_i,noise_var,i);
        x_Valid_ZF(runsCounter)=(norm(x(i)-W_ZF_i'*y).^2);
       
        
        %MMSE
        W_MMSE = ((H_i*H_i'+eye(N).*noise_var))\H_i;
        W_MMSE_i = W_MMSE(:,i);
        W_MMSE_i=W_MMSE_i./(W_MMSE_i'*H_i(:,i));
        SNR_MMSE(runsCounter) = SNR_xi(W_MMSE_i,H_i,noise_var,i);
        x_Valid_MMSE(runsCounter)=(norm(x(i)-W_MMSE_i'*y).^2);
    end
    
    %Compute for each Var loop
    S_ZF(nc)=sum(SNR_ZF)./num_of_runs;
    %S_MMSE(nc)=sum(SNR_MMSE)./num_of_runs;
    S_MRC(nc)=sum(SNR_MRC)./num_of_runs;
    S_MMSE(nc)=sum(SNR_MMSE)./num_of_runs;
    
    S_Valid_MRC(nc)=sum(x_Valid_MRC)./num_of_runs;
    S_Valid_ZF(nc)=sum(x_Valid_ZF)./num_of_runs;
    S_Valid_MMSE(nc)=sum(x_Valid_MMSE)./num_of_runs;
    
   
end



figure(1)
plot(SNRdB_rng,10*log10(S_MRC),'r',SNRdB_rng,10*log10(S_ZF),'b',SNRdB_rng,10*log10(S_MMSE),'g',SNRdB_rng,10*log10(1./S_Valid_MRC),'*r',SNRdB_rng,10*log10(1./S_Valid_ZF),'*b',SNRdB_rng,10*log10(1./S_Valid_MMSE),'*g');
title('SNR Vs Noise var Per method - n iterations')
xlabel('SNR In')
ylabel('SNR Out')
legend('MRC-Theroy','ZF-Theroy','MMSE-Theroy','MRC','ZF','MMSE');

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

