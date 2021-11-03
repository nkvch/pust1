fileID1 = fopen('z2.txt', 'r');
fileID2 = fopen('z2_2.txt', 'r');
fileID3 = fopen('z2_3.txt', 'r');
formatSpec = '%f';
y1 = fscanf(fileID1,formatSpec);
y2 = fscanf(fileID2,formatSpec);
y3 = fscanf(fileID3,formatSpec);
fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
stairs(y1);
hold on
stairs(y2);
stairs(y3);