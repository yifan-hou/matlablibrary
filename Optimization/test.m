aargs.dim = 7;
aargs.range = ones(7,1)*[0 10];
aargs.group_size = 50;
aargs.stop_iter_n = 100;
aargs.omega = 0.8;
aargs.phi_p = 0.2;
aargs.phi_g = 0.2;

[ num,x_history,f_history ] = PSO(aargs,@objFunc);

plot(f_history);
