close all;
clear all;
%Prameters
lambda=0.006;lambda_b=0.001;M_avg = 60;B_avg= 10;
L=5;a=2;K=4;
SNRdB_rng=-30:10:60;noise_var_vec=10.^(-SNRdB_rng/10);
Num_of_runs = 1;Num_noise_var = length(noise_var_vec);
N=K*L;

 %dbstop in Performance_check
% All_SINR = zeros(Num_of_runs,M,N+1,Num_noise_var);
for index_runs = 1:Num_of_runs
	[B,M,r_ij,H] = NetworkRealization(L,a,B_avg,M_avg,lambda_b,lambda);
	for i = 1:M
		H_i = select_H_i(B,L,M,i,K,H,r_ij);
		for Receiver_type = 0:N
			for Noise_var = 1:length(noise_var_vec)
				w_i = ReceiverDesign(H_i,M,Receiver_type,noise_var_vec(Noise_var),i);
				SINR_i = Performance_check(w_i.',H_i,i,noise_var_vec(Noise_var));
				All_SINR(index_runs,i,Receiver_type+1,Noise_var) = SINR_i;
			end %end noise_var
		end %end receiver type
	end %end user i
end %end index_runs



%analysis of results

semilogy(SNRdB_rng,squeeze(All_SINR(1,30,1,1:end)),SNRdB_rng,squeeze(All_SINR(1,30,2,1:end)),SNRdB_rng,squeeze(All_SINR(1,30,N+1,1:end)));
legend('MMSE','MRC','ZF')












