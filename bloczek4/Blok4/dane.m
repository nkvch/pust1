% D110 lewy wiatrak W1
% D111 W2
% D112 W3
% D113 W4

% D114 G1
% d115 G2




% D100 T1
% D101 T2
% D102 T3
% D103 T4
% D104 T5



%Punkt pracy W1=W2=50 (500) G1=25 G2=30  T1= 29,81 T3=31,43

%PID1.MAT
K_1 := 6.0;
K_2 := 5.0;

TProb := 4.0;

TI_1 := 100;
TI_2 := 90;

TD_1 := 2;
TD_2 := 1;


%PID2.MAT
K_1 := 3.0;
K_2 := 2.0;

TProb := 4.0;

TI_1 := 100;
TI_2 := 90;

TD_1 := 1.3;
TD_2 := 1;

%PID3
K_1 := 1.0;
K_2 := 3.0;

TProb := 4.0;

TI_1 := 10.0;
TI_2 := 9.0;

TD_1 := 3.0;
TD_2 := 2.0;

%PID4
K_1 := 6.0;
K_2 := 6.0;

TProb := 4.0;

TI_1 := 100.0;
TI_2 := 110.0;

TD_1 := 0.0;
TD_2 := 0.0;

%DMC1
D=480; N=15; Nu=10;
lambda1=1; lambda2=1;
psi1=1; psi2=1;

