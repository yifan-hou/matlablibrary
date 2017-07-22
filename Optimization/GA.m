function [ num,x_history,f_history ] = GA( fargs,aargs, max, min )
%GA Genetic Algorithm
%   fargs: arguments for func,1:dim,2:type,3:smoothness
%   aargs: arguments for algorithm
%       1:population size
%       2:survivors number
%       3:probability of mutation
%       4:终止步数
%   max: maximum value of the objFunc
%   min: minimum value of the objFunc
dim = fargs(1);
Np = aargs(1); %种群大小
Ns = aargs(2); %生存者数目
Pm = aargs(3); %突变概率
stop_iter_n = aargs(4);      %停止条件

x_history = zeros(dim,1);
f_history = 0;
%产生初始种群
P=rand(dim,Np)*9+1;
V=zeros(Np,1);


now_count = 0;
now = objFunc(P(:,1),fargs);
iter = 0;
while now_count<stop_iter_n    %停止迭代稳定条件
    iter = iter + 1;
    %归一化衡量价值
    for i = 1:Np
        V(i) = (objFunc(P(:,i),fargs) - min)/(max-min);
    end
    
    %适者生存,Ns个最优的留在种群中
    %产生Np-Ns个后代替换掉最差的Np-Ns个
    offsp = zeros(dim,Np-Ns);
    
    %准备轮盘选
    t_all = ones(1,Np)*V;
    label = zeros(Np,1);
    label(1)=V(1)/t_all;
    for i = 2:Np
        label(i) = label(i-1) + V(i)/t_all;
    end
    for i = 1:(Np-Ns)/2
        %轮盘选
        dice = rand();
        goal = 1;
        for j = 1:Np
            if dice > label(j)
                goal = goal + 1;
            else
                break;
            end
        end
        P1 = P(:,goal);
        dice = rand();
        goal = 1;
        for j = 1:Np
            if dice > label(j)
                goal = goal + 1;
            else
                break;
            end
        end
        P2 = P(:,goal);
        
        %交叉
        c_point = floor(rand()*dim+1);%交叉点，1~dim的随机整数
        beta = rand();
        offsp(:,2*i-1) = P1;
        offsp(:,2*i)   = P2;
        offsp(c_point,2*i-1) = P1(c_point) - beta*(P1(c_point)-P2(c_point));
        offsp(c_point,2*i  ) = P2(c_point) - beta*(P1(c_point)-P2(c_point));
        for jj = c_point + 1:dim
            offsp(jj,2*i-1) = P2(jj);
            offsp(jj,2*i  ) = P1(jj);
        end
        %至此，产生了两个后代
    end
    %至此，产生了全部后代。替换最差的解
    [t,I] = sort(V);
    for i = 1:Np-Ns
        P(:,I(i))=offsp(:,i);
    end
    
    %突变,除了最优其它的都有概率突变
    Nm = Pm*dim*(Np-1);%可能发生突变的位点数目
    for i = 1:Nm
        t1 = floor(rand()*(Np-1)+1);
        t2 = floor(rand()*dim+1);
        P(t2,I(t1)) = rand()*9+1;
    end
    
    %至此，完成一代的产生。记录最优解
    x_history(:,iter) = P(:,I(Np));
    value0 = objFunc(P(:,I(Np)),fargs);
    f_history(iter) = value0;
    
    %判断停止条件
    if abs(value0 - now) < 1e-6
        now_count = now_count+1;
    else
        now_count = 0;
    end
    now = value0;
end
num = iter;
end