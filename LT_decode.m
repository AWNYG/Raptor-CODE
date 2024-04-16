function data_decoded=LT_decode(data,K,maxpacket)

[m,n]=size(data);
L=m-1-K;
data_decode_temp=zeros(L+1,K);

if n>maxpacket

    data=data(:,1:maxpacket);   %限制包的获取数量
    
end

data=(unique(data','row'))';    %去除重复列

while(~isempty(find(data(1,:)==1))) %有度为1的包就循环
    
    tempindex=find(data(1,:)==1);   %度为1的包的列编号
    tau1packet=data(:,tempindex);   %获取这些包

    data(:,tempindex)=[];       %在data中删除度为1的包

    temp_n=size(tau1packet,2);

    for i=1:temp_n

        tempindex=find(tau1packet(2:K+1,i)==1); %找到度为1的包的标记

        if data_decode_temp(1,tempindex)==0     %监测该解码包是否已添加

            data_decode_temp(1,tempindex)=1;    %防止重复添加
            data_decode_temp(2:L+1,tempindex)=tau1packet(K+2:m,i);  %将已解码的包添加

        end
        
        if sum(data_decode_temp(1,:))==K
            break;
        end

        tempindex2=find(data(tempindex+1,:)==1);    %找到和该度为1的包有关联的未解码包
        data(1,tempindex2)=data(1,tempindex2)-1;    %有关联的包度减1
        data(tempindex+1,tempindex2)=data(tempindex+1,tempindex2)-1;    %将这个度为1的包在未解码包中的的标记消去
        data(K+2:m,tempindex2)=data(K+2:m,tempindex2)+tau1packet(K+2:m,i);  %数据包直接相加，最后模2得异或

    end

    if sum(data_decode_temp(1,:))==K
        break;
    end

    tempindex=find(data(1,:)==0);   %找到度为0的包
    data(:,tempindex)=[];           %删去度为0的包
    data(K+2:m,:)=rem((data(K+2:m,:)),2)~=0;    %得异或
    data=(unique(data','row'))';    %去除重复列

end

data_decoded=data_decode_temp;  %输出解码包，第一行代表每个包是否解码，1是解码，0是未解码。后L行代表解码的数据

end