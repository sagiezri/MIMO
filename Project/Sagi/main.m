clear all;
B_avg=10;M_avg=100;
lambda=0.01;lambda_b=0.001;
dbstop in NetworkRealization>Generate_H
[B,M,r_ij,H] = NetworkRealization(B_avg,M_avg,lambda_b,lambda);
