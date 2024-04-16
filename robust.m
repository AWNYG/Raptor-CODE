function deg=robust(K,c,delta)

S=c*log(K/delta)*sqrt(K);

rou=zeros(1,K);
rou(1)=1/double(K);

for d=2:K

    rou(d)=1/double(d)/double(d-1);

end

n=fix(K/S);
tau=zeros(1,K);

for d=1:n-1

    tau(d)=S/double(K)/double(d);

end

if n>0

    tau(n)=S/double(K)*log(S/delta);

end

beta=sum(rou)+sum(tau);
deg=zeros(1,K);

for d=1:K

    deg(d)=(rou(d)+tau(d))/beta;
    
end

deg_max=max(round(find(deg>0.1/K)));
deg=deg(1:deg_max);     %去除为零的部分

end