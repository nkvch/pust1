function uk = PID(K, Ti, Td, ek, ek1, ek2, uk1)
    %ograniczenia
    Umax = 3;
    Umin = -3;
    dU = 1000;

    T=0.5;
    
    %wyliczenie nastawów regulatora PID w wersji dyskretnej
    r2 = K*Td/T;
    r1 = K*(T/(2*Ti)-2*Td/T-1);
    r0 = K*(1+T/(2*Ti)+Td/T);

    uk = r2*ek2+r1*ek1+r0*ek+uk1;

    du = uk-uk1;
    
    if du > dU
        du = dU;
    end
    if du < -dU
        du = -dU;
    end
    
    uk = du + uk1;

    if uk > Umax
        uk = Umax;
    end
    if uk < Umin
        uk = Umin;
    end
end
    
    