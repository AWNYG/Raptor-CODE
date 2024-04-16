function data_pre=preparedecode(data_LTdecoded)

    temp=find(data_LTdecoded(1,:)==1);
    data_LTdecoded(:,temp)=(data_LTdecoded(:,temp)-0.5)*2;
    data_LTdecoded(1,:)=[];
    data_pre=data_LTdecoded(:)';

end