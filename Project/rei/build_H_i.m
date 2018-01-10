function [H_i] = build_H_i(H,M,B,L,i,K,k_i)
	k_i_duplicate = repelem(k_i.',L);
%     AA = reshape(repmat(1:L,K,1).',1,L*K);
%     KK = size(k_i_duplicate)
%     AA = size(AA)
	all_index_row = reshape(repmat(1:L,K,1).',1,L*K) + (k_i_duplicate - 1).*L;
	H_i = H(all_index_row,:);

end