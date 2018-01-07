function [H_i] = select_H_i(B,L,M,i,K,H,r_ij)
	
	k_i = select_k_i(r_ij,M,B,i,K);
	H_i = build_H_i(H,M,B,L,i,K,k_i);

end
