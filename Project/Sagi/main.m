clear all;
B_avg=10;M_avg=100;
lambda=0.01;lambda_b=0.001;
% dbstop in NetworkRealization>HPPP
% dbstop in NetworkRealization>Compute_r_ij
% dbstop in NetworkRealization>Generate_H
[B,M,r_ij,H] = NetworkRealization(B_avg,M_avg,lambda_b,lambda);
H_i=H(1:10,:);
Receiver_type=1;
Noise_var=1;
i=2;
 dbstop in ReceiverDesign
[w_i]=ReceiverDesign(H_i,M,Receiver_type,Noise_var,i);


