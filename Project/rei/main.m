close all;
clear all;
%Prameters
M_B_ratio=4;lambda_b=0.002;M_avg = 30;
B_avg=M_avg/M_B_ratio;lambda=lambda_b*M_B_ratio;
L=6;a=2;K=2;
SNRdB_rng=-30:10:60;noise_var_vec=10.^(-SNRdB_rng/10);
Num_of_runs = 1;Num_noise_var = length(noise_var_vec);
N=K*L;
%dbstop in ReceiverDesign

% All_SINR = zeros(Num_of_runs,M,N+1,Num_noise_var);
for index_runs = 1:Num_of_runs
	[B,M,r_ij,H] = NetworkRealization(L,a,B_avg,M_avg,lambda_b,lambda,K);
	for i = 1:M
		H_i = select_H_i(B,L,M,i,K,H,r_ij);
		for Receiver_type = 0:N
			for Noise_var = 1:length(noise_var_vec)
				[w_i,H_to_PC] = ReceiverDesign(H_i,M,Receiver_type,noise_var_vec(Noise_var),i);
				SINR_i = Performance_check(Receiver_type,w_i.',H_to_PC,i,noise_var_vec(Noise_var));
				All_SINR(index_runs,i,Receiver_type+1,Noise_var) = SINR_i;
			end %end noise_var
		end %end receiver type
	end %end user i 
end %end index_runs
All_SINR=sum(All_SINR,1)./Num_of_runs;



%analysis of results
figure
plot(SNRdB_rng,10*log10(squeeze(All_SINR(1,1,1,1:end))),SNRdB_rng,10*log10(squeeze(All_SINR(1,1,2,1:end))),SNRdB_rng,10*log10(squeeze(All_SINR(1,1,N+1,1:end))),SNRdB_rng,10*log10(squeeze(All_SINR(1,1,round(N/2),1:end))));
legend('MMSE','MRC','ZF','between MRC to ZF')
title('SINR(out) Vs SNR(in) ')
xlabel('SNR(in)     [DB]')
ylabel('SNR(out)    [DB]')

All_SINR=sum(All_SINR,1)./M;
figure
plot(SNRdB_rng,log10(log2(1+squeeze(All_SINR(1,1,1,1:end)))),SNRdB_rng,log10(log2(1+squeeze(All_SINR(1,1,2,1:end)))),SNRdB_rng,log10(log2(1+squeeze(All_SINR(1,1,N+1,1:end)))),SNRdB_rng,log10(log2(1+squeeze(All_SINR(1,1,round(N/2),1:end)))))
legend('MMSE','MRC','ZF','between MRC to ZF')
title('Chanel capacity Vs SNR(in) ')
xlabel('SNR(in)     [DB]')
ylabel('Chanel capacity    [DB]')







