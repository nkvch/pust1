n = 1000; %czas symulacji
liczba_reg = 5;
%punkt pracy
Upp = 0;
Ypp = 0;

% wst�pna definicja wektor�w
U = zeros(1, n);
Y = zeros(1, n);
U(1:11) = Upp;
Y(1:11) = Ypp;


%ograniczenia
Umax = 1;
Umin = -1;
T=0.5;
%nastawy regulatora PID w wersji ci�g�ej
if liczba_reg == 1
    param = [-inf -inf inf inf];
    K=0.332613; Ti=1.931338; Td=1.784287; %Parametry uzyskane algorytmem genetycznym
elseif liczba_reg == 2

    param = [-inf -inf -0.25 0.25; -0.25 0.25 inf inf];
    K=[0.2 0.4];
    Ti=[4 1.5];
    Td=[1.3 1];
elseif liczba_reg == 3
    param = [-inf -inf -0.5 -0.1; -0.5 -0.1 0.1 0.5; 0.1 0.5 inf inf];
    K=[0.1 0.15 0.8];
    Ti=[2.7 1.5 1.2];
    Td=[0.5 0.5 1];
elseif liczba_reg == 4
    param = [-inf -inf -0.7 -0.4; -0.7 -0.4 -0.1 0.2; -0.1 0.2 0.5 0.8; 0.5 0.8 inf inf];
    K=[0.12 0.1 0.2 0.4];
    Ti=[2.7 1.3 2.9 1.3];
    Td=[0.9 0.5 0.2 0.8];
elseif liczba_reg == 5
    param = [-inf -inf -0.7 -0.5; -0.7 -0.5 -0.3 -0.1; -0.3 -0.1 0.1 0.3; 0.1 0.3 0.5 0.7; 0.5 0.7 inf inf];
    K=[0.12 0.2 0.4 0.3 0.7];
    Ti=[3 1.9 1.5 1.9 0.4];
    Td=[0.9 0.5 0.3 1.7 0.7];
end

%wyliczenie nastaw�w regulatora PID w wersji dyskretnej
r2 = K.*Td./T;
r1 = K.*(T./(2.*Ti)-2.*Td/T-1);
r0 = K.*(1+T./(2.*Ti)+Td./T);


%wartos�ci zadane
Yzad(1:11)=0;
Yzad(12:150)=-2.5;
Yzad(151:300)=-2;
Yzad(301:500)=-1.5;
Yzad(501:600)=0;
Yzad(601:800)=-0.5;
Yzad(801:n)=0.05;
%pomniejszenuie zmiennych regulatora o warto�ci w punkcie pracy tak y,u
%by�y w okolicach 0
u = U- Upp;
y = Y - Ypp;
y(12:n)=0;
u(12:n)=0;
e(1:n)=0;
umin = Umin-Upp;
umax = Umax-Upp;
E = 0;%wska�nik jako�ci regulacji
E_abs = 0;
w(1:size(param,1)) = 0;

for k=12:n
    Y(k) = symulacja_obiektu10y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2)); %symulacja obiektu
    y(k) = Y(k)-Ypp;
    e(k) = Yzad(k)-Ypp-y(k); %uchyb
   
    for i=1:size(param,1)
        w(i)=trapmf(u(k-1),param(i,:)); 
    end
    
    du = sum(w.*(r2*e(k-2)+r1*e(k-1)+r0*e(k)))/sum(w); %wyliczenie warto�ci sterowania dla chwili k
    
    u(k) = du+u(k-1);
    
    %uwzgl�dnienie ogranicze� warto�ci sygna�u steruj�cego
    if u(k)>umax
        u(k)=umax;
    end
    if u(k)<umin
        u(k)=umin;
    end
    
    U(k) = u(k)+Upp;
    E_abs = E_abs + abs(e(k));
    E = E + e(k)^2; %zwi�kszanie wska�nika
end


%wykres
figure;
stairs(U);
ylim([-1.1 1.1]);
xlabel('k');
ylabel('U(k)');
%title('Sygna� steruj�cy');
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);
figure;
stairs(Y);
xlabel('k');
ylabel('Y(k)');
%title(sprintf('Wyj�cie, b��d %d',E));
hold on;
stairs(Yzad);
legend('Y','Yzad')
hold off;
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);