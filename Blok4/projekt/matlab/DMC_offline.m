zad2_odp_skokowe;

s = pagetranspose(s_mn(:, :, 1:150));
%horyzont dynamiki
D=size(s, 3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parametry regulatora DMC: N-horyzont predykcji Nu-horyzont sterowania
%lambda-wspolczynnik kary
%N=50; Nu=2; lambda=0.5;
N=50; Nu=2; lambda=0.4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=D+1:D+N
    s(:, :, k) = s(:, :, D);
end
 %uzupelnienie wektora wsp�czynnik�w s

%wyznaczenie macierzy MP
nu = size(s, 2);
ny = size(s, 1);

MP=zeros(ny*N, nu*(D-1));

for i=1:(D-1)
    for iy=1:ny
        for iu=1:nu
            MP(iy:ny:ny*N, nu*(i-1) + iu) = s(iy, iu, i+1:N+i)-s(iy, iu, i);
        end
    end
end

%wyznaczenie macierzy M
% M=zeros(N,Nu);
% for i=1:Nu
%     M(i:N,i)=s(1:N-i+1);
% end

% MzP=zeros(N,Dz);
% for i=1:Dz
%     if i == 1
%         MzP(1:N,1)=sz(1:N);
%     else
%         MzP(1:N,i)=sz(i:N+i-1)-sz(i-1);
%     end
% end

% %wyznaczenie macierzy K
% I=eye(Nu);
% K=((M'*M+lambda*I)^(-1))*M';

% %wartos�ci zadane
% Yzad(1:29)=0;
% %Yzad(12:n)=1.1;
% Yzad(30:n)=1;

% e(1:n)=0;
% E = 0; %wska�nik jako�ci regulacji

% %zdefiniowanie innych potrzebnych zmiennych
% DUP=zeros(D-1,1);
% DU=zeros(Nu,1);
% Y0=zeros(N,1);
% YK=zeros(N,1);
% YzadK=zeros(N,1);
% dzP=zeros(Dz,1);
