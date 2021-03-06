clear all;
fileID1 = fopen('z4_PID.txt', 'r');
fileID2 = fopen('z4_PIDwy.txt', 'r');
fileID3 = fopen('z4_PID1.txt', 'r');
fileID4 = fopen('z4_PIDwy1.txt', 'r');
formatSpec = '%f';
y1 = fscanf(fileID1,formatSpec);
y2 = fscanf(fileID2,formatSpec);
y3 = fscanf(fileID3,formatSpec);
y4 = fscanf(fileID4,formatSpec);
Yzad(1:200) = 28.4;
Yzad(201:600) = 35;
Yzad(601:1000) = 30;
fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
fclose(fileID4);
figure;
stairs(y1);
hold on;
plot(Yzad, 'r--');
title("Sterowanie procesu - PID");
xlabel('k');
ylabel('Y(k)');
xlim([0 1000]);
%matlab2tikz('spPIDr.tex');
figure;
stairs(y2);
title("Wyjście procesu - PID");
xlabel('k');
ylabel('U(k)');
xlim([0 1000]);
%matlab2tikz('wpPIDr.tex');
figure;
stairs(y3);
hold on;
plot(Yzad, 'r--');
title("Sterowanie procesu - DMC");
xlabel('k');
ylabel('Y(k)');
xlim([0 1000]);
%matlab2tikz('spPID1r.tex');
figure;
stairs(y4);
title("Wyjście procesu - DMC");
xlabel('k');
ylabel('U(k)');
xlim([0 1000]);
%matlab2tikz('wpPID1r.tex');