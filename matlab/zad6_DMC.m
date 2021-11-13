E_min = 99;
N_best = 0;
Nu_best = 0;
lambda_best = 0;

K_=1.6;

for Ti_=1:0.05:20
    for Td_=1:0.05:20
        [N, Nu, lambda, E] = DMC_func(N, Nu, lambda)

        if E < E_min
            E_min = E;
            K_best = K;
            Ti_best = Ti;
            Td_best = Td;
        end
    end
end