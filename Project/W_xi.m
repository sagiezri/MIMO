function [H] = W_xi(num_of_runs,i,K,H_i)
SNRdB_rng=-30:10:60;
noise_var_vec=10.^(-SNRdB_rng/10);

S_ZF=zeros(1,length(num_of_runs));S_MMSE=zeros(1,length(num_of_runs));S_MRC=zeros(1,length(num_of_runs));

S_Valid_MRC=zeros(1,length(num_of_runs));S_Valid_ZF=zeros(1,length(num_of_runs));S_Valid_MMSE=zeros(1,length(num_of_runs));

%Assume M>N - working just with squre matrices
[N,M]=size(H_i);


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
        H_ZF=H_i(1:N,1:N);
        W_ZF=inv(H_ZF');
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
    S_MRC(nc)=sum(SNR_MRC)./num_of_runs;
    S_MMSE(nc)=sum(SNR_MMSE)./num_of_runs;
    

    S_Valid_MRC(nc)=sum(x_Valid_MRC)./num_of_runs;
    S_Valid_ZF(nc)=sum(x_Valid_ZF)./num_of_runs;
    S_Valid_MMSE(nc)=sum(x_Valid_MMSE)./num_of_runs;
    
   

end



figure(1)
plot(SNRdB_rng,10*log10(S_MRC),'r',SNRdB_rng,10*log10(S_ZF),'b',SNRdB_rng,10*log10(S_MMSE),'g',SNRdB_rng,10*log10(1./S_Valid_MRC),'*r',SNRdB_rng,10*log10(1./S_Valid_ZF),'*b',SNRdB_rng,10*log10(1./S_Valid_MMSE),'*g');
title('SNRin_i Vs SNRout_i Per method')
xlabel('SNR In')
ylabel('SNR Out')
legend('MRC-Theroy','ZF-Theroy','MMSE-Theroy','MRC','ZF','MMSE');

end
