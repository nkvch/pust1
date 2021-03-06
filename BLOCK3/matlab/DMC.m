%wyznaczenie wektora wsp�czynnik�w s
zad3;

n = 1500; %czas symulacji
%punkt pracy
Upp = 0;
Ypp = 0;
% wst�pna definicja wektor�w
U = zeros(1, n);
Y = zeros(1, n);
U(1:11) = Upp;
U(12:n) = 0;
Y(1:11) = Ypp;
Y(12:n) = 0;

%ograniczenia
Umax = 1;
Umin = -1;
dU = 0.075; %maksymalna zmiana
%horyzont dynamiki
D=15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parametry regulatora DMC: N-horyzont predykcji Nu-horyzont sterowania
%lambda-wspolczynnik kary
N=15; Nu=1; lambda=50;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s(D+1:D+N)=s(D);

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

%wyznaczenie macierzy K
I=eye(Nu);
K=((M'*M+lambda*I)^(-1))*M';

%wartosci zadane
Yzad(1:11)=0;
Yzad(12:400)=0.08;
Yzad(401:600)=-2.5;
Yzad(601:700)=-0.5;
Yzad(701:800)=0;
Yzad(801:1000)=-0.5;
Yzad(1001:1200)=-1.5;
Yzad(1201:1400)=-2.5;
Yzad(1401:n)=-2;
%pomniejszenuie zmiennych regulatora o warto�ci w punkcie pracy tak y,u
%by�y w okolicach 0
u = U- Upp;
y = Y - Ypp;
yzad = Yzad - Ypp;
y(12:n)=0;
u(12:n)=0;
e(1:n)=0;
umin = Umin-Upp;
umax = Umax-Upp;
E = 0; %wska�nik jako�ci regulacji
E_abs = 0;

%zdefiniowanie innych potrzebnych zmiennych
DUP=zeros(D-1,1);
DU=zeros(Nu,1);
Y0=zeros(N,1);
YK=zeros(N,1);
YzadK=zeros(N,1);

for k=12:n
    Y(k) = symulacja_obiektu10y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2)); %symulacja obiektu
    y(k) = Y(k)-Ypp;
    e(k) = yzad(k)-y(k); %uchyb
    
    %wektory obecnej i zadanej warto�ci wyj�cia
    YK(1:N,1)=y(k);
    YzadK(1:N,1)=yzad(k);

    
    Y0 = YK+MP*DUP;
    DU = K*(YzadK-Y0);
    du = DU(1);
    
    %uwzgl�dnienie ogranicze� zmian sygna�u steruj�cego
    if du>dU
        du=dU;
    end
    if du<-dU
        du=-dU;
    end
    
    u(k) = du+u(k-1);
    
    %wyznaczenie nowego wektora deltaUP
    for j=D-1:-1:2
        DUP(j)=DUP(j-1);
    end
    DUP(1) = du;
    
    %uwzgl�dnienie ogranicze� warto�ci sygna�u steruj�cego
    if u(k)>umax
        u(k)=umax;
    end
    if u(k)<umin
        u(k)=umin;
    end
    
    U(k) = u(k)+Upp;
    E = E + e(k)^2; %zwi�kszanie wska�nika
    E_abs = E_abs + abs(e(k));
end


%wykres
figure;
stairs(U);
xlabel('k');
ylabel('U(k)');
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);
% matlab2tikz('../sprawozdanie/rysunki/DMC_N15_Nu1_lambda50_U.tex');

figure;
stairs(Y);
xlabel('k');
ylabel('Y(k)');

hold on;
stairs(Yzad);
legend('Y','Yzad')
hold off;
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);
% matlab2tikz('../sprawozdanie/rysunki/DMC_N15_Nu1_lambda50.tex');




