function decoded=LDPC_decoder_Raptor(data,Nloop,H)
index=find(data==0);
[M,N]=size(H);
for l=1:Nloop
    
    Rmn=-data;
    probazero=zeros(M,N);
    probaone=zeros(M,N);

    for i=index
        Ml=find(H(:,i)==1)';

        for j=Ml
            Nl=find(H(j,:)==1);
            temppr=1;

            for k=Nl

                if(k==i)
                    continue;
                end

                temppr=temppr*Rmn(k);
            end

            probazero(j,i)=(temppr+1)/2;
            probaone(j,i)=(1-temppr)/2;
        end

        temp1=sum(probazero(:,i));
        temp2=sum(probaone(:,i));

        if temp1>temp2
            data(i)=-1;
        end

        if temp1<temp2
            data(i)=1;
        end

        if temp1==temp2
            data(i)=0;
        end

    end
    temp3=data>0;

    if(sum(mod(H*temp3',2))==0)
        break;
    end

end

decoded=data;
end