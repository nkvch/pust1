clear all;
fileID1 = fopen('zadanie2_1skokpop.txt', 'r');
fileID2 = fopen('zadanie2_2skokpop.txt', 'r');
fileID3 = fopen('zadanie2_3skokpop.txt', 'r');

formatSpec = '%f';
y1 = fscanf(fileID1,formatSpec);
y2 = fscanf(fileID2,formatSpec);
y3 = fscanf(fileID3,formatSpec);

fclose(fileID1);
fclose(fileID2);
fclose(fileID3);

figure;
stairs(y1);
hold on
stairs(y2);
stairs(y3);
xlabel('k');
ylabel('T[°C]');

matlab2tikz('../sprawozdanie/rysunki/zad2_lab.tex');
