close all;
clear all;
N=8;M=12;
Num_of_runs = 1000;
norm_row_a_i = zeros(Num_of_runs,N);
for index_runs = 1:Num_of_runs
    H= crand(N,M);
    maxNormPointer=(sum(abs(H).^2));
    [~,maxNormIndex]=sort(maxNormPointer,'descend');
    H_i = H(:,maxNormIndex);
    a_i = zeros(N,M);
    for PZF=1:N
        H_PZF = H_i(:,1:PZF);
        e_i = zeros(PZF,1);e_i(1)=1;
        w_i = (H_PZF/(H_PZF'*H_PZF))*e_i; 
        a_i(PZF,:) = w_i'*H_i;
    end
    norm_row_a_i(index_runs,:)=sum(abs(a_i).^2,2);
end
avg_norm_a_i = sum(norm_row_a_i)./Num_of_runs;
stem(1:N,avg_norm_a_i)



