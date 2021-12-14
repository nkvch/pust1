n = 1500; %czas symulacji
liczba_reg = 2;
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
T=0.5;
%nastawy regulatora PID w wersji ci¹g³ej
if liczba_reg == 1
    param = [-inf -inf inf inf];
    K=0.332613; Ti=1.931338; Td=1.784287; %Parametry uzyskane algorytmem genetycznym
elseif liczba_reg == 2

    param = [-inf -inf -0.25 0.25; -0.25 0.25 inf inf];
    K=[0.17 0.5];
    Ti=[3.4 5.6];
    Td=[0.3 0.9];
elseif liczba_reg == 3
    param = [-inf -inf -0.5 -0.1; -0.5 -0.1 0.1 0.5; 0.1 0.5 inf inf];
    K=[0.1 0.15 0.8];
    Ti=[2.2 0.8 1.1];
    Td=[0.5 0.5 1];
elseif liczba_reg == 4
%     % paramtetry ladnej regulacji
%     param = [-inf -inf -0.7 -0.4; -0.7 -0.4 -0.1 0.2; -0.1 0.2 0.5 0.8; 0.5 0.8 inf inf];
%     K=[0.12 0.1 0.2 0];
%     Ti=[3 1.4 3 0.01];
%     Td=[0.9 1.5 1 0];
%     % parametry bardzo ³adnej
%     param = [-inf -inf -0.7 -0.4; -0.7 -0.4 -0.1 0.2; -0.1 0.2 0.5 0.8; 0.5 0.8 inf inf];
%     K=[0.12 0.07 0.2 0];
%     Ti=[3 1.3 3 0.01];
%     Td=[0.9 1.5 1 0];
%     % parametry z mniejszym E
%     param = [-inf -inf -0.7 -0.4; -0.7 -0.4 -0.1 0.2; -0.1 0.2 0.5 0.8; 0.5 0.8 inf inf];
%     K=[0.12 0.07 0.2 0];
%     Ti=[3 0.4 3 0.01];
%     Td=[0.9 1.5 1 0];
elseif liczba_reg == 5
    param = [-inf -inf -0.7 -0.5; -0.7 -0.5 -0.3 -0.1; -0.3 -0.1 0.1 0.3; 0.1 0.3 0.5 0.7; 0.5 0.7 inf inf];
    K=[0.12 0.2 0.4 0.3 0.7];
    Ti=[3 2.3 1.5 1.9 0.4];
    Td=[1.05 0.8 0.3 1.7 0.7];
end

%wyliczenie nastawów regulatora PID w wersji dyskretnej
r2 = K.*Td./T;
r1 = K.*(T./(2.*Ti)-2.*Td/T-1);
r0 = K.*(1+T./(2.*Ti)+Td./T);


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
w(1:size(param,1)) = 0;

for k=12:n
    Y(k) = symulacja_obiektu10y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2)); %symulacja obiektu
    y(k) = Y(k)-Ypp;
    e(k) = Yzad(k)-Ypp-y(k); %uchyb
   
    for i=1:size(param,1)
        w(i)=trapmf(u(k-1),param(i,:)); 
    end
    
    du = sum(w.*(r2*e(k-2)+r1*e(k-1)+r0*e(k)))/sum(w); %wyliczenie wartoœci sterowania dla chwili k
    
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
% matlab2tikz('../sprawozdanie/rysunki/R_PID_5r_U.tex');

figure;
stairs(Y);
xlabel('k');
ylabel('Y(k)');
%title(sprintf('Wyjœcie, b³¹d %d',E));
hold on;
stairs(Yzad, '--');
legend('Y','Yzad')
hold off;
set(gcf,'Units','centimeters','Position', [ 1 1 14 8]);
% matlab2tikz('../sprawozdanie/rysunki/R_PID_5r.tex');