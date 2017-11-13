function [y_interferance] = sum_Y_interferance(num_unwanted_users,N,H_other_users,z_data)
y_interferance = zeros(N,N);
for i = 1:num_unwanted_users
    HjFj_Zj = H_other_users{i}*transpose(z_data{i+1});
   y_interferance = y_interferance + HjFj_Zj;
end
end