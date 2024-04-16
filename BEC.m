function data_bec=BEC(data,p)

n=size(data,2);
temp=zeros(1,n);

for i=1:n
    if rand()<p
        temp(i)=1;
    end
end

temp=find(temp==1);
data(:,temp)=[];
data_bec=data;

end