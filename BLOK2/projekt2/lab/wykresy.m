clear all;
fileID1 = fopen('z2.txt', 'r');
fileID2 = fopen('z2_2L.txt', 'r');
fileID3 = fopen('z2_3.txt', 'r');
fileID4 = fopen('z1L.txt', 'r');
formatSpec = '%f';
y1 = fscanf(fileID1,formatSpec);
y2 = fscanf(fileID2,formatSpec);
y3 = fscanf(fileID3,formatSpec);
y4 = fscanf(fileID4,formatSpec);
fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
fclose(fileID4);
figure;
stairs(y1);
hold on
stairs(y2);
stairs(y3);
xlabel('k');
ylabel('T[°C]');
figure;
stairs(y4);
xlabel('k');
ylabel('T[°C]');
% matlab2tikz('odpskok3.tex');