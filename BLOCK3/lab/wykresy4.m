clear all;
fileID1 = fopen('z4_DMC.txt', 'r');
fileID2 = fopen('z4_DMC1.txt', 'r');
fileID3 = fopen('z4_DMC2.txt', 'r');
fileID4 = fopen('z4_DMC3.txt', 'r');
fileID5 = fopen('z4_DMC4.txt', 'r');
fileID11 = fopen('z4_DMCwy.txt', 'r');
fileID21 = fopen('z4_DMCwy1.txt', 'r');
fileID31 = fopen('z4_DMCwy2.txt', 'r');
fileID41 = fopen('z4_DMCwy3.txt', 'r');
fileID51 = fopen('z4_DMCwy4.txt', 'r');
formatSpec = '%f';
y1 = fscanf(fileID1,formatSpec);
y2 = fscanf(fileID11,formatSpec);
fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
fclose(fileID4);
Yzad(1:600)=28.18;
Yzad(201:600) = 35;
figure;
stairs(y1);
hold on
stairs(Yzad);
xlabel('k');
ylabel('T[°C]');
matlab2tikz('4DMC.tex');
figure;
stairs(y2);
xlabel('k');
ylabel('%');
matlab2tikz('4DMCU.tex');
