function bi_list=randlist(n)   %生成随机二进制序列

temp=zeros(1,n);
temp(1,1:round(rand()*n))=1;
temp=temp(1,randperm(n));
bi_list=temp;

end