clo%se all;
clear all;
%Prameters
lambdaTx=0.05;lambdaBs=0.005;axisXY=100;
L=4;a=2;k=30;
K=zeros(1,k);
num_of_runs=1000;
%Stage 1
H=ChannelCalculation(L,a,lambdaTx,lambdaBs,axisXY);
[N,M]=size(H);

%Stage 2
Htemp=H;
for i=1:M
    for p=1:k
       [Htemp,K(i,p)]=Knearest(Htemp,i,k);       
    end
end

%Stage 3
%Chosen Transmister 
i=2;
H_i=H(K(i,:),:);
W_xi(num_of_runs,i,K(i,:),H_i);


%SNRout VS K
%{
SNRVsK=zeros(k-10,3);
for u=10:k
    Htemp=H;
    for i=1:M
        for p=1:u
            [Htemp,K(i,p)]=Knearest(Htemp,i,u);       
    
        end
    end


i=2;
H_i=H(K(i,1:u),:);
SNRVsK(u,:)=W_xi_k(num_of_runs,i,K(i,:),H_i);
end
index=1:1:length(SNRVsK);
figure(2)
plot(index,10*log10(SNRVsK(index,1)),'r',length(SNRVsK),10*log10(SNRVsK(index,2)),'b',length(SNRVsK),10*log10(SNRVsK(index,3)),'g');
title('SNRout_i Vs K Per method')
xlabel('k')
ylabel('SNR Out')
legend('MRC-Theroy','ZF-Theroy','MMSE-Theroy','MRC','ZF','MMSE');
%}