function data_coded=LT_encode(data,K,redundancy,deg)   %分成K个包，生成M个包

M=round(K*(1+redundancy));  %生成M个包
sumdata=numel(data);    %确定总元素量
L=ceil(sumdata/K);      %得到每个包的长度（向上取整）
data=[data,zeros(1,K*L-sumdata)];   %末尾补零
data=reshape(data,L,K); %一维数组重排

deg_M=randsample(1:length(deg),M,true,deg);   %生成每个包的度
deg_M=round(deg_M);     %取整

G=zeros(K,M);           %生成矩阵预设空间
data_temp=zeros(K+1+L,M);   %预设空间，第一行度数，后K行包的标记，最后L行数据

data_temp(1,:)=deg_M;   %为每个包的度赋值

for i=1:M

    G(1:data_temp(1,i),i)=1;    %先生成1在最前
    G(:,i)=G(randperm(K),i);    %随机重排，表示随机个包参与异或
    
end

data_temp(2:K+1,:)=G;           %第二行到K+1行为包的标记
data_temp(K+2:K+1+L,:)=(rem((data*G),2)~=0);    %最后L行存放数据包
data_coded=data_temp;

end