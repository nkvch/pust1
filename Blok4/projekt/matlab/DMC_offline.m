clear;
zad2_odp_skokowe;

s = {};
D = 150;

for i=1:D
    s{i} = s_mn(:, :, i)';
end


N=150; Nu=50; lambda=100;


Mp = cell(N, D - 1);

for i=1:(D-1)
    for j=1:N
        if j + i > D
            Mp{j,i} = s{D} - s{i};
        else
            Mp{j,i} = s{j + i} - s{i};
        end
    end
end

Mp = cell2mat(Mp);

M = cell(N, Nu);
%Macierz odopowiedzi skokowych
for i=1:Nu
    M(i:N,i)=s(1:N-i+1);
    M(1:i-1,i)={zeros(ny, nu)};
end

M = cell2mat(M);

psi = eye(ny*N);

Lambda = eye(nu*Nu) * lambda;

K = (M' * psi * M + Lambda)^(-1) * M' * psi;

save('mainvars.mat');
