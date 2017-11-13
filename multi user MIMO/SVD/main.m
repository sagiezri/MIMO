clear all;
N = 6;
Z = gen_data(1,N);
r = 1;a=2;num_transmit = 1;num_stream_each_transmit = 2;
H = chanel(N).*(r.^(a/2));
[U,sigma,V_H]=svd(H);
W=U;F=(V_H)';
n=randn(N);
Y_SVD=H*F*transpose(Z);

Z_e=(W'*Y_SVD);
sigma-Z_e\Z;