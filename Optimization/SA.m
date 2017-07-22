function [ num,x_history,f_history ] = SA( fargs,aargs )
%SA Simulated Anealling
%   fargs: arguments for func,1:dim,2:type,3:smoothness
%   aargs: arguments for algorithm
%       1:initial temperature
%       2:stop steps
%       3:inner loop number
%       4:annealing factor
%       5:outter loop accept factor
dim = fargs(1);

tpt = aargs(1);      %初始温度
stop_iter_n = aargs(2);      %停止条件
inner_loop_num = aargs(3); %内循环次数
gamma = aargs(4);       %指数退火系数
k2 = aargs(5);          %外循环接受因数

x=rand(dim,1)*9+1;  %初始解

num=1; %统计迭代次数
f_history(num)=objFunc(x,fargs);   %每次迭代后的函数值 
x_history = x;                     %每次迭代后的解

now_count = 0;
now = objFunc(x,fargs);
while now_count<stop_iter_n    %停止迭代稳定条件
    value0=objFunc(x,fargs);         %evaluate old solution
    
    if abs(value0 - now) < 1e-6
        now_count = now_count+1;
    else
        now_count = 0;
    end
    now = value0;
    
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
        f_history(num+1)=value0;
        if delta_value<0
            x=x_perturbed;
            f_history(num+1)=value1;
        else
            if exp(-delta_value/(k2*tpt))>rand() %以能量按概率选择是否接受新解
                x=x_perturbed;
                f_history(num+1)=value1;
            end
        end        
    end
    num=num+1;
    x_history(:,num)=x;
     
    tpt=tpt*gamma;   %指数退火
end%while

end

