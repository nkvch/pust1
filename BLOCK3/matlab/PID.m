n = 1500; %czas symulacji
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
%nastawy regulatora PID w wersji ci¹g³ej
%K = 1.1; Ti = 9.9; Td = 2.8;
K=0.332613; Ti=1.931338; Td=1.784287; %Parametry uzyskane algorytmem genetycznym
% K=1.6680; Ti=3.5; Td=0.84; % parametry ZN
% Tkr = 14*0.5; Kkr = 2.78
%wyliczenie nastawów regulatora PID w wersji dyskretnej
% K=0.3; Ti=4.5; Td=1.54;

r2 = K*Td/T;
r1 = K*(T/(2*Ti)-2*Td/T-1);
r0 = K*(1+T/(2*Ti)+Td/T);


%wartosœci zadane
Yzad(1:11)=0;
Yzad(12:400)=0.08;
Yzad(401:600)=-2.5;
Yzad(601:700)=-0.5;
Yzad(701:800)=0;
Yzad(801:1000)=-0.5;
Yzad(1001:1200)=-1.5;
Yzad(1201:1400)=-2.5;
Yzad(1401:n)=-2;

% % dla skoku
% Yzad(1:11)=0;
% Yzad(12:1000)=-0.1;


%pomniejszenuie zmiennych regulatora o wartoœci w punkcie pracy tak y,u
%by³y w okolicach 0
u = U- Upp;
y = Y - Ypp;
y(12:n)=0;
u(12:n)=0;
e(1:n)=0;
umin = Umin-Upp;
umax = Umax-Upp;
E = 0;%wskaŸnik jakoœci regulacji
E_abs = 0;

for k=12:n
    Y(k) = symulacja_obiektu10y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2)); %symulacja obiektu
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
    E_abs = E_abs + abs(e(k));
    E = E + e(k)^2; %zwiêkszanie wskaŸnika
end


%wykres
figure;
stairs(U);
ylim([-1.1 1.1]);
xlabel('k');
ylabel('U(k)');
%title('Sygna³ steruj¹cy');
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);
matlab2tikz('../sprawozdanie/rysunki/PID_gen_U.tex');
figure;
stairs(Y);
xlabel('k');
ylabel('Y(k)');
%title(sprintf('Wyjœcie, b³¹d %d',E));
hold on;
stairs(Yzad);
legend('Y','Yzad')
hold off;
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);
matlab2tikz('../sprawozdanie/rysunki/PID_gen.tex');