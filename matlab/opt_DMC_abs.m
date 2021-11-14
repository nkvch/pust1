E_abs_min = 999;
E_min = 99;
N_best = 0;
Nu_best = 0;
lambda_best = 0;

zad3;

global s;

N_ = 200;

for Nu_=1:100
    for lambda_=10:200
        [N, Nu, lambda, E, E_abs] = DMC_func(N_, Nu_, lambda_, s);

        if E_abs < E_abs_min
            E_abs_min = E_abs
            N_best = N
            Nu_best = Nu
            lambda_best = lambda
        end
    end
end