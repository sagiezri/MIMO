function [k_i] = select_k_i(r_ij,M,B,i,K)
    K = min(B,K);
	[val ind] = sort(r_ij(:,i),'descend');
	ind = sort(ind(1:K));
	k_i = ind(1:K);
	% r_ij(ind(1:k));

end