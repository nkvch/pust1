clear all;
close all;
load('wspolczynnikis.mat')
czas_symulacji = 100;
nu=2;
ny=2;

%Macierz odopowiedzi skokowych
for i=1:length(s11)
    S(i)={[s11(i) s12(i);...
           s21(i) s22(i)]};
end
    
%Parametry dobrane eksperymentalnie
D=480; N=15; Nu=10;
lambda1=1; lambda2=1;
psi1=1; psi2=1;

%Punkty pracy W1=W2=50 (500) G1=25 (250) G2=30 (300)  T1= 29,81 T3=31,43
u1pp=250;
u2pp=300;

y1pp=2981;
y2pp=3143;


%Macierz Mp
for i=1:(D-1)
    for j=1:N
        if j+i>D
            Mp{j,i}=S{D}-S{i};
        else
            Mp{j,i}=S{j+i}-S{i};
        end
    end
end
C
%Macierz M
for i=1:Nu
    M(i:N,i)=s(1:N-i+1);
    M(1:i-1,i)={[0 0 0 0; 0 0 0 0; 0 0 0 0;]};
end



%Macierz psi
for i=1:N
   for j=1:N
       if i == j
           Psi{i,j} =[psi1 0; 0 psi2];
       else
           Psi{i,j} =[0 0; 0 0];
       end
       
   end
end


%Macierz Lambd
for i=1:Nu
   for j=1:Nu
       if i == j
           Lambda{i,j} =[lambda1 0; 0 lambda2];
       else
           Lambda{i,j} =[0 0; 0 0];
       end
       
   end
end

%zamiana na macierze
Lambda_m = cell2mat(Lambda);
Mp_m = cell2mat(Mp);
M_m = cell2mat(M);
Psi_m = cell2mat(Psi);

%wyliczenie macierzy K
K=(*M_m+Lambda_m)^(-1)*M_m'*Psi_m;
y1_zad = zeros(1,czas_symulacji);
y2_zad = zeros(1,czas_symulacji);
y1 = zeros(1,czas_symulacji)+2;
y2 = zeros(1,czas_symulacji)+3;

%obliczenie Ku
K1 = K(1:ny,:);
Ku = K1*Mp_m;
csvwrite('Ku.txt',Ku);
csvwrite('Ku.csv',Ku(1,:)');


fileID = fopen('wiersz1.txt','w');
% petla
for i=1:length(K1)
    fprintf( fileID, 'KU_1[%d] := %d;\n', i-1, Ku(1,i));
end
fclose(fileID);

fileID = fopen('wiersz2.txt','w');
% petla
for i=1:length(K1)
    fprintf( fileID, 'KU_2[%d] := %d;\n', i-1, Ku(2,i));
end
fclose(fileID);



%obliczenie Ke
Ke(1,1)=sum(K1(1,1:2:N*ny));
Ke(1,2)=sum(K1(1,2:2:N*ny));
Ke(2,1)=sum(K1(2,1:2:N*ny));
Ke(2,2)=sum(K1(2,2:2:N*ny));

%du=Ke*e(:,k)-Ku*dUp; 

%wektor dUp
dup=zeros(nu,1);
for i=1:D-1
    dUp(i,1)={dup};
end


for k=1:czas_symulacji
    %Uchyb
    E(1,k)=y1_zad(k)-y1(k);
    E(2,k)=y2_zad(k)-y2(k);
    
    for i=1:N
        y_k(i,1) = {[y1(k); y2(k)]};
    end
    y_k_m = cell2mat(y_k);
    
    
end
