function U = PID_roz(e)

    persistent Upop e0 e1 e2
    T=1;
    liczba_reg = 3;
    Gmax = 100;
    Gmin = 0;
    %nastawy regulatora PID w wersji ci¹g³ej
    if liczba_reg == 1
        param = [-inf -inf inf inf];
        K=0.332613; Ti=1.931338; Td=1.784287; %Parametry uzyskane algorytmem genetycznym
    elseif liczba_reg == 2
        param = [-inf -inf -0.25 0.25; -0.25 0.25 inf inf];
        K=[0.2 0.4];
        Ti=[4 1.5];
        Td=[1.3 1];
    elseif liczba_reg == 3
        param = [-inf -inf -0.5 -0.1; -0.5 -0.1 0.1 0.5; 0.1 0.5 inf inf];
        K=[0.1 0.15 0.8];
        Ti=[2.7 1.5 1.2];
        Td=[0.5 0.5 1];
    end


    if isempty(e0)
        Upop = 0;        
        e0=0; 
        e1=0; 
        e2=0;
        
        %wyliczenie nastawów regulatora PID w wersji dyskretnej
        r2 = K.*Td./T;
        r1 = K.*(T./(2.*Ti)-2.*Td/T-1);
        r0 = K.*(1+T./(2.*Ti)+Td./T);     
    end

    e2 = e1;
    e1 = e0;
    e0 = e;
    
    for i=1:size(param,1)
       w(i)=trapmf(Upop,param(i,:)); 
    end
    
    du = sum(w.*(r2*e2+r1*e1+r0*e0))/sum(w); %wyliczenie wartoœci sterowania dla chwili k
    
    U = du+Upop;
    
    if U > Gmax
        U = Gmax;
    end
    
    if U < Gmin
        U = Gmin;
    end
    
    Upop = U;
    
end