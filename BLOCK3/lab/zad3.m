clear all;

fileID1 = fopen('./dane/z4_PID1.txt', 'r');
fileID2 = fopen('./dane/z4_PIDwy1.txt', 'r');

formatSpec = '%f';
u = fscanf(fileID2,formatSpec);
y = fscanf(fileID1,formatSpec);

yzad(1:50) = 30.93;
yzad(51:300) = 35.93;
yzad(301:500) = 45.93;
yzad(501:800) = 30.93;


fclose(fileID1);
fclose(fileID2);

figure;
stairs(y);
hold on;
stairs(yzad, '--');
xlabel('k');
ylabel('T[°C]');
ylim([30 48]);
legend({'Y', 'Y zad'}, 'Location', 'northeast');
% matlab2tikz('../sprawozdanie/rysunki/zad3_lab_DRAFT.tex');

figure;
stairs(u);
xlabel('k');
ylabel('U[%]');
% matlab2tikz('../sprawozdanie/rysunki/zad3_lab_U_DRAFT.tex');

