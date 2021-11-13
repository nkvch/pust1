E_abs_min = 999;
K_best = 1.3;
Ti_best = 10;
Td_best = 3;

K_=1;

for Ti_=1:0.05:20
    for Td_=1:0.05:20
        [K, Ti, Td, E, E_abs] = PID_func(K_, Ti_, Td_);

        if E_abs < E_abs_min
            E_abs_min = E_abs
            K_best = K
            Ti_best = Ti
            Td_best = Td
        end
    end
end

K_=1.1;

for Ti_=1:0.05:20
    for Td_=1:0.05:20
        [K, Ti, Td, E, E_abs] = PID_func(K_, Ti_, Td_);

        if E_abs < E_abs_min
            E_abs_min = E_abs
            K_best = K
            Ti_best = Ti
            Td_best = Td
        end
    end
end

