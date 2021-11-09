fileID1 = fopen('C:\Users\PUST\Desktop\pust_z10\z2.txt', 'r');
fileID2 = fopen('C:\Users\PUST\Desktop\pust_z10\z2eksperyment.txt', 'r');
fileID3 = fopen('C:\Users\PUST\Desktop\pust_z10\z2_3.txt', 'r');
formatSpec = '%f';
y1 = fscanf(fileID1,formatSpec);
y2 = fscanf(fileID2,formatSpec);
y3 = fscanf(fileID3,formatSpec);
stairs(y1);
hold on
stairs(y2);
stairs(y3);