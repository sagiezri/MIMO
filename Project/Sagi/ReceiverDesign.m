%*************************************************************************%
%Receiver Design function - roles:
%Calculate for each reciver the w vector
%Input: H_i(matrix - NXM),M(scalar),Receiver_type(scalar),Noise_var(scalar),i(scalar).
%Output:w_i.
%*************************************************************************%

function [w_i]=ReceiverDesign(H_i,M,Receiver_type,Noise_var,i)
%init w_i vector
w_i=zeros(1,size(H_i,1));
%Gets h_i vector
h_i=H_i(:,i);
%Check if we're on PZF mode
if Receiver_type~=0
    %Sorting H_i according minimal norm by the columns ->Calculate H_i_c     
     H_i_c=H_i;
     %Exclude h_i from the sorting
     H_i_c(:,i)=[];
     %Calculate each row norm - to get the closet 
     minNormPointer=zeros(size(H_i_c,1),1);
     minNormPointer(:,1)=abs((sqrt(sum(H_i_c.*H_i_c,2))));
     [minNormPointer(:,2),minNormPointer(:,1)]=sort(minNormPointer(:,1));
     %Put h_i in the first place
     H_i_c(:,1)=h_i;
     H_i_c(:,1:size(H_i_c,1))=H_i_c(:,minNormPointer(:,1));
     %All the rest sorted columns after    
     %We've in each row the w_i vector of the crosspding index.
     %1-MRC,2 and up PZF
     e_i=zeros(1,Receiver_type);
     e_i(1,1)=1;
     if Receiver_type==1
         H_cc=h_i;
     else
       for  c=2:Receiver_type
         H_cc=H_i_c(:,1:c);         
       end
     end  
        w_i=H_cc/(H_cc'*H_cc)*e_i';     
else
%Receiver_type=0 - MMSE
H_HH=H_i*H_i';
w_i=((H_HH+Noise_var.*eye(size(H_HH,2)))\h_i).';
end
    
end