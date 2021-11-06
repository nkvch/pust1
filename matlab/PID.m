n = 300; %czas symulacji
%punkt pracy
Upp = 3;
Ypp = 0.9;
% wst�pna definicja wektor�w
U = zeros(1, n);
Y = zeros(1, n);
U(1:11) = Upp;
U(12:n) = 0;
Y(1:11) = Ypp;
Y(12:n) = 0;


%ograniczenia
Umax = 3.3;
Umin = 2.7;
dU = 0.075;
%nastawy regulatora PID w wersji ci�g�ej
K = 1.3; Ti = 10; Td = 3; T=0.5;
%wyliczenie nastaw�w regulatora PID w wersji dyskretnej
r2 = K*Td/T;
r1 = K*(T/(2*Ti)-2*Td/T-1);
r0 = K*(1+T/(2*Ti)+Td/T);

%warto�ci zadane
Yzad(1:11)=0.9;
Yzad(12:n)=1.3;
Yzad(100:n)=0.7;
%pomniejszenuie zmiennych regulatora o warto�ci w punkcie pracy tak y,u
%by�y w okolicach 0
u = U- Upp;
y = Y - Ypp;
y(12:n)=0;
u(12:n)=0;
e(1:n)=0;
umin = Umin-Upp;
umax = Umax-Upp;
E = 0; %wska�nik jako�ci regulacji

for k=12:n
    Y(k) = symulacja_obiektu10Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2)); %symulacja obiektu
    y(k) = Y(k)-Ypp;
    e(k) = Yzad(k)-Ypp-y(k); %uchyb
    
    u(k) = r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1); %wyliczenie warto�ci sterowania dla chwili k
    du = u(k)-u(k-1); %wyznaczenie zmiany sygna�u steruj�cego du
    
    %uwzgl�dnienie ogranicze� zmian sygna�u steruj�cego
    if du>dU
        du=dU;
    end
    if du<-dU
        du=-dU;
    end
    
    u(k) = du+u(k-1);
    
    %uwzgl�dnienie ogranicze� warto�ci sygna�u steruj�cego
    if u(k)>umax
        u(k)=umax;
    end
    if u(k)<umin
        u(k)=umin;
    end
    
    U(k) = u(k)+Upp;
    E = E + e(k)^2; %zwi�kszanie wska�nika
end


%wykres
subplot(2,1,1);
stairs(U);
ylim([2.5 3.4]);
xlabel('k');
ylabel('U(k)');
title('Sygna� steruj�cy');
subplot(2,1,2);
stairs(Y);
xlabel('k');
ylabel('Y(k)');
title(sprintf('Wyj�cie, b��d %d',E));
hold on;
stairs(Yzad);
legend('Y','Yzad')
hold off;

