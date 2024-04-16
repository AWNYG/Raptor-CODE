function wrong=verify(data,decoded)

m=size(data,2);
temp=0;

for i=1:m
    if data(i)~=decoded(i)
        temp=temp+1;
    end
end
wrong=temp;

end