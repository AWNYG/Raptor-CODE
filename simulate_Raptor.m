function res=simulate_Raptor(H,G,K,redundancy,c,delta,p,maxpacket,Nloop,times)

sum=0;
[M,N]=size(H);
deg=robust(K,c,delta);
for i=1:times
    data=randlist(N-M);
    data_LDPC_coded=mod(data*G,2);
    data_LT_coded=LT_encode(data_LDPC_coded,K,redundancy,deg);
    data_bec=BEC(data_LT_coded,p);
    data_LT_decoded=LT_decode(data_bec,K,maxpacket);
    data_pre=preparedecode(data_LT_decoded);
    data_pre=data_pre(1:N);
    data_LDPC_decoded=LDPC_decoder_Raptor(data_pre,Nloop,H);
    data_LDPC_decoded=data_LDPC_decoded>0;
    data_LDPC_decoded=data_LDPC_decoded(N-M+1:end);
    wrong=verify(data_LDPC_decoded,data);
    sum=sum+wrong;
end

res=sum/times/(N-M);

end