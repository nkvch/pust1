function duk = DMC(dUp, yk, yzadk)
    load('mainvars.mat');
    Yk = cell(N, 1);
    Yzadk = cell(N, 1);

    for i=1:N
        Yk{i} = yk;
        Yzadk{i} = yzadk; 
    end

    Yk = cell2mat(Yk);
    Yzadk = cell2mat(Yzadk);

    Y0k = Yk + Mp * dUp;
    dUk = K * (Yzadk - Y0k);

    duk = dUk(1:nu);
end
    
    