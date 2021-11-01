N = 300;
Upp = 3;
Ypp = 0.9;
U = zeros(1, N);
Y = zeros(1, N);
U(1:11) = Upp;
U(12:N) = 0;
Y(1:11) = 0.9;
Y(12:N) = 0;
U(12:N) = Upp + 0.3;
Umax = 3.3;
Umin = 2.7;
dU = 0.075;
%nastawy regulatora PID w wersji ci¹g³ej
K = 1.3; Ti = 10; Td = 3; T=0.5;
%wyliczenie nastawów regulatora PID w wersji dyskretnej
r2 = K*Td/T;
r1 = K*(T/(2*Ti)-2*Td/T-1);
r0 = K*(1+T/(2*Ti)+Td/T);

Yzad(1:11)=0.9;
Yzad(12:N)=1.3;
Yzad(100:N)=0.7;
%pomniejszenuie zmiennych regulatora o wartoœci w punkcie pracy tak y,u
%by³y w okolicach 0
u = U- Upp;
y = Y - Ypp;
y(1:N)=0;
u(1:N)=0;
e(1:N)=0;
umin = Umin-Upp;
umax = Umax-Upp;


for k=12:N
    Y(k) = symulacja_obiektu10Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2)); %symulacja obiektu
    y(k) = Y(k)-Ypp;
    e(k) = Yzad(k)-Ypp-y(k); %uchyb
    
    u(k) = r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1); %wyliczenie wartoœci sterowania dla chwili k
    du = u(k)-u(k-1); %wyznaczenie zmiany sygna³u steruj¹cego du
    
    %uwzglêdnienie ograniczeñ zmian sygna³u steruj¹cego
    if du>dU
        du=dU;
    end
    if du<-dU
        du=-dU;
    end
    
    u(k) = du+u(k-1);
    
    %uwzglêdnienie ograniczeñ wartoœci sygna³u steruj¹cego
    if u(k)>umax
        u(k)=umax;
    end
    if u(k)<umin
        u(k)=umin;
    end
    
    U(k) = u(k)+Upp;
end
subplot(2,1,1);
stairs(U);
ylim([2.5 3.4]);
xlabel('k');
ylabel('U(k)');
title('Sygna³ steruj¹cy');
subplot(2,1,2);
stairs(Y);
xlabel('k');
ylabel('Y(k)');
title('Wyjœcie');
hold on;
stairs(Yzad);
legend('Y','Yzad')
hold off;

