function duk = DMC(dUp, yk, yzadk)
    load('mainvars.mat');
    Yk = zeros(ny*N, 1);
    Yzadk = zeros(ny*N, 1);

    for i=1:N
        Yk((i-1)*ny+1:i*ny) = yk;
        Yzadk((i-1)*ny+1:i*ny) = yzadk; 
    end

    Y0k = Yk + Mp * dUp;
    dUk = K * (Yzadk - Y0k);

    duk = dUk(1:nu);
end
    
    