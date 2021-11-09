% implemrntacja PID

function U = PID(e)

    persistent Upop
    persistent e0
    persistent e1
    persistent e2
    persistent K
    persistent Ti
    persistent Td
    persistent Tp
    persistent r2
    persistent r1
    persistent r0
    
     % Ograniczenia sterowania
    Gmax = 100;
    Gmin = 0;
    
%     Upp = 26;
%     Ypp = 31.12;
     
    if isempty(e0)
        Upop = 0;          % sterowanie w punkcie pracy
        e0=0; 
        e1=0; 
        e2=0;

        % Nastawy regulatora
        K = 30; %Kk = 43, Tk = 36
        Ti = 35;% * 4;  %inf;    10
        Td = 4.5;% * 0.6; %    0.4
        Tp = 1;

        r2 = K*Td/Tp;
        r1 = K*(Tp/(2*Ti)-2*Td/Tp - 1);
        r0 = K*(1+Tp/(2*Ti) + Td/Tp);
    end
    
    % przesunięcie uchybów
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