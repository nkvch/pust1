clear all;
    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
%process w punkcie pracy (u0, y0)!!
L=0.1;
M=[1 -0.9];
delay = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step Response z dlugoscia dynamiki D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%D=100+delay;
%StepResponse = zeros(1,D);
StepResponse =  importdata('C:\Users\User\Desktop\odp_skok.txt');
disp(StepResponse);
%StepResponse(0) = 0 - nie jest implementowane
%StepResponse(delay+1) = L;
%for i=delay+2:1:D
%    StepResponse(i) = simulateProces(StepResponse(i-1),1);
%end

%wartosc sterowania
Upast = ones(1000,1);
%przyrosty sterowania
dUpast = zeros(1000,1);
%wartosci wyjsc rzeczywiste zmierzone
Ypast = ones(1000,1);
%wartosci estymowane
eYpast = ones(1000,1);

%zmienna pomocnicza
loop= 0;
%chwila w przeszlosci (k-t) z ktorej startujemy obliczanie estymacji
t = 30;

%pomiar wartosci poczatkowej sterowania - mozna zalozyc ze rowne 0
u0 = 50;
Upast = Upast * u0;

%pomiar wartosci poczatkowej wyjscia
y0 = readMeasurements(1:1);
Ypast = Ypast * y0;
%ustawienie estymaty rownej wartosci poczatkowej 
eYpast = Ypast;

Upast(1000) = u0;
Ypast(1000) = y0;

figure;
k=1000;
while loop < k
    loop = loop+1
    
    %y_k = f(y_k_1 + u_k_1) sumulacja procesu
    %czyli pomiar obecnej wartosci
    Y=readMeasurements(1:1);
    %simulateProces((Ypast(1000)-y0,Upast(1000-delay)-u0);
    Ypast = circshift(Ypast,-1);
    Ypast(1000) = Y;
    
    %generacja sterowania na chwile obecna k
    %w DMC liczone jest sterowanie u(k|k) 
    Upast = circshift(Upast,-1);
    Upast(1000)=u0;
    if(loop <= 200)
        Upast(1000) = 10+u0;
    end
    if(loop > 200) && (loop <= 400)
        Upast(1000) = 30+u0;
    end
    if(loop > 400) && (loop <= 600)
        Upast(1000) = 0+u0;
    end
    if(loop > 600) && (loop <= 800)
        Upast(1000) = -20+u0;
    end
    if(loop > 800) && (loop < 1000)
        Upast(1000) = -10+u0;
    end
    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                 [ 50, 0, 0, 0, Upast(1000), 0]);  % new corresponding control values
    dUpast = circshift(dUpast,-1);
    dUpast(1000) = Upast(1000)-Upast(999);
    
    %liczenie estymaty w oparciu o wzory z DMC
    %sterowanie wyliczone na chwile k nie jest uwzgledniane w predykcji
    %liczonej na chwile k
    eY=estimateY(Ypast(1000-t), dUpast, StepResponse, t);
    eYpast = circshift(eYpast,-1);
    eYpast(1000) = eY;
    plot(1:1:1000,Ypast(1:1:1000),'r',1:1:1000,eYpast(1:1:1000),'b',1:1:1000,Upast(1:1:1000),'g')
    if(abs(eY - Y)>2)
        disp('ERROR DETECTED')
    end
    pause(1);
end

