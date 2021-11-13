% implemrntacja PID

function U = PID(e)

    persistent Upop e0 e1 e2 K Ti Td Tp r2 r1 r0

    Gmax = 100;
    Gmin = 0;
         
    if isempty(e0)
        Upop = 0;        
        e0=0; 
        e1=0; 
        e2=0;

        K = 30;
        Ti = 35;
        Td = 4.5;
        Tp = 1;

        r2 = K*Td/Tp;
        r1 = K*(Tp/(2*Ti)-2*Td/Tp - 1);
        r0 = K*(1+Tp/(2*Ti) + Td/Tp);
    end

    e2 = e1;
    e1 = e0;
    e0 = e;
    
    U = r2*e2 + r1*e1 + r0*e0 + Upop;
    
    if U > Gmax
        U = Gmax;
    end
    
    if U < Gmin
        U = Gmin;
    end
    
    Upop = U;
    
end