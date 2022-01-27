function duk = economDMC(dUp, yk, yzadk)
    load('mainvars.mat');
    
    duk = Ke*(yzadk-yk) - Ku * dUp;
end
