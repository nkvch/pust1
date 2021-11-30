function E_abs = PID_func(X)
K=X(1);
Ti=X(2);
Td=X(3);
n = 1000; %czas symulacji
%punkt pracy
Upp = 0;
Ypp = 0;
% wstêpna definicja wektorów
U = zeros(1, n);
Y = zeros(1, n);
U(1:11) = Upp;
Y(1:11) = Ypp;


%ograniczenia
Umax = 1;
Umin = -1;
dU = 0.075;
T=0.5;

%wyliczenie nastawów regulatora PID w wersji dyskretnej
r2 = K*Td/T;
r1 = K*(T/(2*Ti)-2*Td/T-1);
r0 = K*(1+T/(2*Ti)+Td/T);


%wartosci zadane
Yzad(1:11)=0;
%Yzad(12:n)=1.1;
Yzad(12:150)=0.09;
Yzad(151:300)=-0.5;
Yzad(301:500)=-0.7;
Yzad(501:600)=-1.5;
Yzad(601:800)=-1;
Yzad(801:n)=0.1;
%pomniejszenuie zmiennych regulatora o wartoci w punkcie pracy tak y,u
%by³y w okolicach 0
u = U - Upp;
y = Y - Ypp;
y(12:n)=0;
u(12:n)=0;
e(1:n)=0;
umin = Umin-Upp;
umax = Umax-Upp;
E = 0; %wskanik jakoci regulacji
E_abs = 0;

for k=12:n
    Y(k) = symulacja_obiektu10y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2)); %symulacja obiektu
    y(k) = Y(k)-Ypp;
    e(k) = Yzad(k)-Ypp-y(k); %uchyb
    
    u(k) = r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1); %wyliczenie wartoci sterowania dla chwili k
    du = u(k)-u(k-1); %wyznaczenie zmiany sygna³u steruj¹cego du
    
    %uwzglêdnienie ograniczeñ zmian sygna³u steruj¹cego
    if du>dU
        du=dU;
    end
    if du<-dU
        du=-dU;
    end
    
    u(k) = du+u(k-1);
    
    %uwzglêdnienie ograniczeñ wartoci sygna³u steruj¹cego
    if u(k)>umax
        u(k)=umax;
    end
    if u(k)<umin
        u(k)=umin;
    end
    
    U(k) = u(k)+Upp;
    E = E + e(k)^2; %zwiêkszanie wskanika
    E_abs = E_abs + abs(e(k));
end


end

