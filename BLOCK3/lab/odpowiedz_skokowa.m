clear all;
fileID1 = fopen('./dane/z2_20.txt', 'r');
fileID2 = fopen('./dane/z2_30.txt', 'r');
fileID3 = fopen('./dane/z2_40.txt', 'r');
fileID4 = fopen('./dane/z2_50.txt', 'r');
fileID5 = fopen('./dane/z2_60.txt', 'r');
fileID6 = fopen('./dane/z2_70.txt', 'r');
fileID7 = fopen('./dane/z2_80.txt', 'r');

formatSpec = '%f';
y1 = fscanf(fileID1,formatSpec);
y2 = fscanf(fileID2,formatSpec);
y3 = fscanf(fileID3,formatSpec);
y4 = fscanf(fileID4,formatSpec);
y5 = fscanf(fileID5,formatSpec);
y6 = fscanf(fileID6,formatSpec);
y7 = fscanf(fileID7,formatSpec);

fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
fclose(fileID4);
fclose(fileID5);
fclose(fileID6);
fclose(fileID7);

marks = {
    sprintf('U = %.0f', 20),
    sprintf('U = %.0f', 30),
    sprintf('U = %.0f', 40),
    sprintf('U = %.0f', 50),
    sprintf('U = %.0f', 60),
    sprintf('U = %.0f', 70),
    sprintf('U = %.0f', 80)
};

figure;
stairs(y1);
hold on
stairs(y2);
stairs(y3);
stairs(y4);
stairs(y5);
stairs(y6);
stairs(y7);
xlabel('k');
ylabel('T[°C]');
legend(marks,'Location', 'northwest');
matlab2tikz('../sprawozdanie/rysunki/zad2_lab.tex');
