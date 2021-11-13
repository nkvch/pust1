function [N, Nu, lambda, E] = DMC_func(N, Nu, lambda)

s=s(1:175);

n = 1000; %czas symulacji
%punkt pracy
Upp = 3;
Ypp = 0.9;
% wstêpna definicja wektorów
U = zeros(1, n);
Y = zeros(1, n);
U(1:11) = Upp;
U(12:n) = 0;
Y(1:11) = Ypp;
Y(12:n) = 0;

%ograniczenia
Umax = 3.3;
Umin = 2.7;
dU = 0.075; %maksymalna zmiana
%horyzont dynamiki
D=175;


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
Yzad(1:11)=0.9;
%Yzad(12:n)=1.1;
Yzad(12:150)=1.35;
Yzad(151:300)=0.8;
Yzad(301:500)=1.0;
Yzad(501:550)=1.05;
Yzad(551:600)=1.1;
Yzad(601:650)=1.15;
Yzad(651:700)=1.2;
Yzad(701:750)=1.15;
Yzad(751:800)=1.1;
Yzad(751:800)=1.05;
Yzad(801:850)=1.0;
Yzad(851:n)=0.6;
%pomniejszenuie zmiennych regulatora o wartoci w punkcie pracy tak y,u
%by³y w okolicach 0
u = U- Upp;
y = Y - Ypp;
yzad = Yzad - Ypp;
y(12:n)=0;
u(12:n)=0;
e(1:n)=0;
umin = Umin-Upp;
umax = Umax-Upp;
E = 0; %wskanik jakoci regulacji

%zdefiniowanie innych potrzebnych zmiennych
DUP=zeros(D-1,1);
DU=zeros(Nu,1);
Y0=zeros(N,1);
YK=zeros(N,1);
YzadK=zeros(N,1);

for k=12:n
    Y(k) = symulacja_obiektu10Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2)); %symulacja obiektu
    y(k) = Y(k)-Ypp;
    e(k) = yzad(k)-y(k); %uchyb
    
    %wektory obecnej i zadanej wartoci wyjcia
    YK(1:N,1)=y(k);
    YzadK(1:N,1)=yzad(k);

    
    Y0 = YK+MP*DUP;
    DU = K*(YzadK-Y0);
    du = DU(1);
    
    %uwzglêdnienie ograniczeñ zmian sygna³u steruj¹cego
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
    
    %uwzglêdnienie ograniczeñ wartoci sygna³u steruj¹cego
    if u(k)>umax
        u(k)=umax;
    end
    if u(k)<umin
        u(k)=umin;
    end
    
    U(k) = u(k)+Upp;
    E = E + e(k)^2; %zwiêkszanie wskanika
end


end

