%wyznaczenie wektora wsp�czynnik�w s
%zad3;  %naleze wykona� przed uruchomieniem
s=s(1:175);
sz=s;
%sz = ...;

n = 300; %czas symulacji
%punkt pracy
Upp = 0;
Zpp = 0;
Ypp = 0;
% wst�pna definicja wektor�w
U = zeros(1, n);
Y = zeros(1, n);
Z = zeros(1, n); %ZAK��CENIE MIERZALNE


%horyzont dynamiki
D=158; Dz=68;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parametry regulatora DMC: N-horyzont predykcji Nu-horyzont sterowania
%lambda-wspolczynnik kary
N=60; Nu=1; lambda=200;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s(D+1:D+N) = s(D); %uzupelnienie wektora wsp�czynnik�w s
sz(Dz+1:Dz+N) = sz(Dz);

%wyznaczenie macierzy MP
MP=zeros(N,D-1);
for i=1:(D-1)
    MP(1:N,i)=s(i+1:N+i)-s(i);
end

%wyznaczenie macierzy M
M=zeros(N,Nu);
for i=1:Nu
    M(i:N,i)=s(1:N-i+1);
end

MzP=zeros(N,Dz);
for i=1:Dz
    if i == 1
        MzP(1:N,1)=sz(1:N);
    else
        MzP(1:N,i)=sz(i:N+i-1)-sz(i-1);
    end
end

%wyznaczenie macierzy K
I=eye(Nu);
K=((M'*M+lambda*I)^(-1))*M';

%wartos�ci zadane
Yzad(1:30)=0;
%Yzad(12:n)=1.1;
Yzad(31:n)=1;

e(1:n)=0;
E = 0; %wska�nik jako�ci regulacji

%zdefiniowanie innych potrzebnych zmiennych
DUP=zeros(D-1,1);
DU=zeros(Nu,1);
Y0=zeros(N,1);
YK=zeros(N,1);
YzadK=zeros(N,1);
dzP=zeros(Dz,1);


for k=12:n
    Y(k) = symulacja_obiektu10y_p2(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2)); %symulacja obiektu
    e(k) = Yzad(k)-Y(k); %uchyb
    
    %wektory obecnej i zadanej warto�ci wyj�cia
    YK(1:N,1)=Y(k);
    YzadK(1:N,1)=Yzad(k);

    
    Y0 = YK+MP*DUP+MzP*dzP;
    DU = K*(YzadK-Y0);
    du = DU(1);
    
    U(k) = du+U(k-1);
   
    %wyznaczenie nowego wektora deltaUP
    for j=D-1:-1:2
        DUP(j)=DUP(j-1);
    end
    DUP(1) = du;
    %wyznaczenie nowego wektora dzP
    for j=Dz:-1:2
        dzP(j)=dzP(j-1);
    end
    dzP(1) = Z(k)-Z(k-1);
   
    
    E = E + e(k)^2; %zwi�kszanie wska�nika
end


%wykres
figure;
subplot(2,1,1);
stairs(U);
%ylim([0 1]);
xlabel('k');
ylabel('U(k)');
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);
subplot(2,1,2);
stairs(Z);
%ylim([0 1]);
xlabel('k');
ylabel('Z(k)');
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);
%matlab2tikz('../sprawozdanie/rysunki/strojenie_DMC_petla_U.tex');

figure;
stairs(Y);
xlabel('k');
ylabel('Y(k)');
xlim([0 n]);

hold on;
stairs(Yzad);
legend('Y','Yzad')
hold off;
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);
%matlab2tikz('../sprawozdanie/rysunki/strojenie_DMC_petla.tex');




