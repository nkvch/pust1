clear all;
fileID1 = fopen('./dane/z1prob2.txt', 'r');
formatSpec = '%f';
y1 = fscanf(fileID1,formatSpec);
figure;
stairs(y1);
xlabel('k');
ylabel('T[°C]');
matlab2tikz('../sprawozdanie/rysunki/zad1_lab.tex');
