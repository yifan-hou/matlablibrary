function [ num,x_history,f_history ] = GASA( fargs,aargs, max, min )
%GASA Summary of this function goes here
%   Detailed explanation goes here
dim = fargs(1);

tpt = aargs(1);      %初始温度
stop_iter_n = aargs(2);      %停止条件
inner_loop_num = aargs(3); %内循环次数
gamma = aargs(4);       %指数退火系数
k2 = aargs(5);          %外循环接受因数

Np = aargs(6); %种群大小
Ns = aargs(7); %生存者数目
Pm = aargs(8); %突变概率

%产生初始种群
P=rand(dim,Np)*9+1;
V=zeros(Np,1);

f_history = 0;   %每次迭代后的函数值 
x_history = zeros(dim,1);                     %每次迭代后的解

now_count = 0;
now = 0;
iter = 0;
while now_count<stop_iter_n    %停止迭代稳定条件
    iter = iter + 1;
    
    %
    %    GA
    %
    
    %归一化衡量价值
    for i = 1:Np
        V(i) = (objFunc(P(:,i),fargs) - min)/(max-min);
    end
    
    
    %GA操作：选择交叉变异
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
    
    %
    %   记录
    %
    
    %至此，完成一代的产生
    x_history(:,iter) = P(:,I(Np));
    f_history(iter) = objFunc(P(:,I(Np)),fargs);
    
    %判断收敛准则满足否
    value0=f_history(iter);
    if abs(value0 - now) < 1e-6
        now_count = now_count+1;
    else
        now_count = 0;
    end
    now = value0;
    
    %
    %   SA
    %
   
    for e = 1:Np
        x=P(:,e);
        value0=objFunc(x,fargs);         %evaluate old solution
        for i=1:inner_loop_num     %内循环
            while 1
                %1. 产生一个距离值，温度越大，这个值越大
                dist = 3;%sqrt(dim)*sqrt(0.3*tpt);
                %2. 随机产生一个这个长度的向量，加到原x上
                x_perturbed = x + (rand(dim,1)-0.5)*dist;
                if u_check(x_perturbed,dim,1,10) > 0
                    break;
                end
            end
            
            value1=objFunc(x_perturbed,fargs);     %evaluate new solution
            %         Metropolis 抽样
            delta_value=value0-value1;  %能量差值
            if delta_value<0
                x=x_perturbed;
            else
                if exp(-delta_value/(k2*tpt))>rand() %以能量按概率选择是否接受新解
                    x=x_perturbed;
                end
            end
        end%end inner loop
        P(:,e) = x;
    end
    tpt=tpt*gamma;   %指数退火
    
end
num = iter;

end

