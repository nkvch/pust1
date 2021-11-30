function U = DMC(yzad, y, D, N, Nu, lambda,Z)
    
    persistent init  S M  Mp K dUP Upop MzP dzP
    Dz = 50;
    if isempty(init)

        %odczyt danych s i sz        Ypp=ones(350,1)*28.18;
        
        
        for i = D+1:D+N
            S(i) = S(D);
        end
        
        M = zeros(N, Nu);
        for i = 1:Nu
            M(i:N,i)=S(1:N-i+1);
        end
        
        Mp = zeros(N, D-1);
        for i = 1:(D-1)
            Mp(1:N,i) = S(i+1:N+i) - S(i);
        end
        
        I = eye(Nu);        
        K = ((M'*M + lambda*I)^(-1))*M';
        dUP = zeros(D-1,1);
        dzP = zeros(Dz,1);
        Upop = 25;
        init = 1;
        
        MzP=zeros(N,Dz);
        for i=1:Dz
            if i == 1
                MzP(1:N,1)=sz(1:N);
            else
                MzP(1:N,i)=sz(i:N+i-1)-sz(i-1);
            end
        end
    end

    Gmax = 100;
    Gmin = 0;
    
    Y0 = zeros(N,1);
    dU = zeros(Nu,1);
    
    Yzad = yzad*ones(N,1);
    Y = y*ones(N,1);
    
    Y0 = Y + Mp*dUP+MzP*dzP;
    dU = K*(Yzad - Y0);
    du = dU(1);
    
  
    for n=D-1:-1:2
      dUP(n) = dUP(n-1);
    end
    dUP(1) = du;
   
    U = Upop + du;
    
    for j=Dz:-1:2
        dzP(j)=dzP(j-1);
    end
    dzP(1) = Z(k)-Z(k-1);
    
    if U > Gmax
        U = Gmax;
    end
    
    if U < Gmin
        U = Gmin;
    end
    
    Upop = U;
end