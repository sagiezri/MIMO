clear all;
B_avg=10;M_avg=100;
lambda=0.01;lambda_b=0.001;
% dbstop in NetworkRealization>HPPP
% dbstop in NetworkRealization>Compute_r_ij
% dbstop in NetworkRealization>Generate_H
[B,M,r_ij,H] = NetworkRealization(B_avg,M_avg,lambda_b,lambda);

%Tests values
%Receiver_type=4;
Noise_var=10e-9;
H_i=H(1:10,:);
i=45;
%One iteration
%  dbstop in ReceiverDesign
%  [w_i]=ReceiverDesign(H_i,M,Receiver_type,Noise_var,i);

%Multiple iterations
 Receiver_type=0:size(H_i,1);
 for c=1:length(Receiver_type)
    [w_i(c,:)]=ReceiverDesign(H_i,M,Receiver_type(c),Noise_var,i);
 end
for j=2:size(H_i,1)+1
SNR_MMSE_MRC_ZF(1,j) = SNR_xi(w_i(j,:).',H_i,Noise_var,i);
end
SNR_MMSE_MRC_ZF(1,1) = SNR_xi(w_i(1,:).',H_i,Noise_var,i);
plot(SNR_MMSE_MRC_ZF);
