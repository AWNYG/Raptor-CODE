

xr=130:10:200;
yr=zeros(1,8);
p = parpool(6);


parfor i=1:8
    for j=1:10
        yr(i)=yr(i)+simulate_Raptor(H,G,800,100,2,0.13,0.53,0.1,xr(i),20,1000);
    end
end

delete(p);