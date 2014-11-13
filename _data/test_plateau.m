Obj = load('test.mat');
Obj = Obj.Dalsu;
n = length(Obj);
i = ceil(0.1*n);
while i<0.9*n
    back5 = (Obj(i)-Obj(ceil(i-0.05*n)))/0.05;
    back1 = (Obj(i)-Obj(i-1))/(1/n);
    for1 = (Obj(i+1)-Obj(i))/(1/n);
    for5 = (Obj(floor(i+0.05*n))-Obj(i))/0.05;
    if back5>0 && back1>0 && for1<0 && for5<0.5*back1
        return
    end
    i = i+1;
end