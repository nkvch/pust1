n = 1000; %czas symulacji
liczba_reg = 5;
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
    param = [-1 -0.9 0.9 1];
    D={20};
    lambda={1};
    N={10};
    Nu={1};
    
elseif liczba_reg == 2
    param = [-1 -0.6 -0.25 0.25; -0.25 0.25 0.6 1];
    D={20,20};
    lambda={1,1};
    N={10,10};
    Nu={1,1};
elseif liczba_reg == 3
    param = [-1 -0.75 -0.5 -0.1; -0.5 -0.1 0.1 0.5; 0.1 0.5 0.75 1];
    D={20,20,20};
    lambda={1,1,1};
    N={10,10,10};
    Nu={1,1,1};
elseif liczba_reg == 4
    param = [-1 -0.9 -0.7 -0.4; -0.7 -0.4 -0.1 0.2; -0.1 0.2 0.5 0.8; 0.5 0.8 0.9 1];
    D={20,20,20,20};
    lambda={1,1,1,1};
    N={10,10,10,10};
    Nu={1,1,1,1};
elseif liczba_reg == 5
    param = [-1 -0.9 -0.7 -0.5; -0.7 -0.5 -0.3 -0.1; -0.3 -0.1 0.1 0.3; 0.1 0.3 0.5 0.7; 0.5 0.7 0.9 1];
    D={20,20,20,20,20};
    lambda={1,1,1,1,1};
    N={10,10,10,10,10};
    Nu={1,1,1,1,1};
end

%Wektory odpowiedzi skokowych
s=cell(1, liczba_reg);
for i=1:liczba_reg
    U_tmp(1:200)=param(i,2);
    U_tmp(20:200)=param(i,3);
    Y_tmp(1:20)=skok(param(i,2));
    s_tmp(1:180)=0;
    for k=7:200
        Y_tmp(k)= symulacja_obiektu10y_p3(U_tmp(k-5), U_tmp(k-6), Y_tmp(k-1), Y_tmp(k-2));
    end
    for j=21:200
        s_tmp(j-20)=(Y_tmp(j)-skok(param(i,2)))/(param(i,3)-param(i,2));
    end
    s{i}=s_tmp;
end  

param(1,1:2)=-inf;
param(liczba_reg,3:4)=inf;

%wartosœci zadane
Yzad(1:11)=0;
Yzad(12:150)=-2.5;
Yzad(151:300)=-2;
Yzad(301:500)=-1.5;
Yzad(501:600)=0;
Yzad(601:800)=-0.5;
Yzad(801:n)=0.05;
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

%Inicjalizacja macierzy i wektorów dla regulatorów
dup=cell(1,liczba_reg); 
M=cell(1,liczba_reg);   
MP=cell(1,liczba_reg);
K=cell(1,liczba_reg);
Ku=cell(1,liczba_reg);
Ke=cell(1,liczba_reg);

for k=1:liczba_reg
    dup{k}(1:D{k}-1) = 0;
    
    M{k}=zeros(N{k},Nu{k});
    for i=1:Nu{k}
        M{k}(i:N{k},i)=s{k}(1:N{k}-i+1);
    end
    MP{k}=zeros(N{k},D{k}-1);
    for i=1:(D{k}-1)
        MP{k}(1:N{k},i)=s{k}(i+1:N{k}+i)-s{k}(i);
    end
    
    K{k}=((M{k}'*M{k}+lambda{k}*eye(Nu{k}))^-1)*M{k}';
    Ku{k}=K{k}(1,:)*MP{k};
    Ke{k}=sum(K{k}(1,:));
end

for k=12:n
    Y(k) = symulacja_obiektu10y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2)); %symulacja obiektu
    y(k) = Y(k)-Ypp;
    e(k) = Yzad(k)-Ypp-y(k); %uchyb
   
    du_sum = 0;
    for i=1:liczba_reg
        du{i}=Ke{i}*e(k)-Ku{i}*dup{i}'; %regulator
        
        
        u(k)=u(k-1);
        for n=D{i}-1:-1:2
            dup{i}(n)=dup{i}(n-1); %przesuniêcie wartoœci wektora dup
        end
        dup{i}(1)=du{i};
        w(i)=trapmf(u(k-1),param(i,:));%trapezowa funkcja przynaleznosci
        du_sum = du_sum + du{i}*w(i);
    end
    
    u(k)= u(k-1)+du_sum/sum(w);
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