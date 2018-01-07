%*************************************************************************%
%Receiver Design function - roles:
%Calculate for each reciver the w_i vector
%Input: H_i(matrix - NXM),M(scalar),Receiver_type(scalar),Noise_var(scalar),i(scalar).
%Output:w_i.
%*************************************************************************%

function [w_i]=ReceiverDesign(H_i,M,Receiver_type,Noise_var,i)
N=size(H_i,1);
%init w_i vector
w_i=zeros(1,N);
%gets h_i vector
h_i=H_i(:,i);
%Check if we're on PZF mode
if Receiver_type~=0
    %Sorting H_i according to minimal norm by the columns     
     H_i_no_hi=H_i;
     %Exclude h_i from the sorting
     H_i_no_hi(:,i)=[];
     %Calculate each column norm - to get the closet transmister - we can cancel up to N-1 interference 
     minNormPointer=(sum(abs(H_i_no_hi)));
     [~,minNormIndex]=sort(minNormPointer(1,:));
     %Put h_i in the first place -> MRC ->PZF..
     H_i_rt=zeros(N,N);
     H_i_rt(:,1)=h_i;
     %All the rest sorted columns after
     H_i_rt(:,2:end)=H_i(:,minNormIndex(1:N-1));
     %h_l always at the first index
     e_i=zeros(Receiver_type,1);
     e_i(1,1)=1;
     %create H_c_i matrix
     H_c_i=H_i_rt(:,1:Receiver_type);
     %Compute w_i vector
     w_i=(H_c_i/(H_c_i'*H_c_i))*e_i;     
     %return a row vector
     w_i=w_i./(w_i.'*h_i);
     w_i=w_i.';
else
%Receiver_type=0 - MMSE
H_HH=H_i*H_i';
w_i=((H_HH+Noise_var.*eye(size(H_HH,2)))\h_i);
%return a row vector
w_i=w_i./(w_i.'*h_i);
w_i=w_i.';
end
    
end