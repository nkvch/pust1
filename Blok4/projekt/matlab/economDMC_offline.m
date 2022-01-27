DMC_offline;

Ku_cale = K * Mp;
Ku = Ku_cale(1:nu, :);

Ke = zeros(nu, ny);

for i=1:N
    Ke = Ke + K(1:nu,1+(i-1)*ny:ny+(i-1)*ny);
end

save('mainvars.mat');
