% function MinimalWorkingExample()
%     addpath('D:\SerialCommunication'); % add a path to the functions
%     initSerialControl COM10 % initialise com port
%     fileID = fopen('C:\Users\PUST\Desktop\pust_z10\z2_2_2.txt', 'w');
%     global i; i = 0;
%     skok = 20;
%     while(i < 350)
%         % obtaining measurements
%         measurements1 = readMeasurements(1); % read measurements from 1 to 7
%         % measurements3 = readMeasurements(3);
%         % processing of the measurements and new control values calculation
%         
%         sterowanie = 25;
%         if i > 20
%            sterowanie = sterowanie + skok;
%         end
%             
% 
%         % sending new values of control signals
%         sendControls([1, 5], ... send for these elements
%                      [0, 0]);  % new corresponding control values
%         
%         
%         measurement = readMeasurements(1:1)
%         fprintf(fileID, '%f \n', measurement);
%         % synchronising with the control process
%         waitForNewIteration(); % wait for new batch of measurements to be ready
%         i = i + 1;
%     end
%     fclose(fileID);
% end
 

clear all;
addpath('D:\SerialCommunication'); % add a path to the functions
initSerialControl COM10 % initialise com port
% f = figure;
power_G1 = 25;
fileID = fopen('C:\Users\PUST\Desktop\pust_z10\b2\z4_PID1.txt', 'w');
fileID1 = fopen('C:\Users\PUST\Desktop\pust_z10\b2\z4_PIDwy1.txt', 'w');

Yzad(1:200) = 28.18; %31.12
% trajektoria wartości zadanej
Yzad(201:600) = 35;
Yzad(601:1000) = 30;
Z(1:1000)=0;

k = 1;
u = 0;
E = 0;
time = 1000;


DMCu = zeros(time + 100,1);
DMCy = zeros(time + 100,1);
DMCe = zeros(time + 100,1);

figure(1);
figure(2);
while(1)

    %% obtaining measurements

    measurements1 = readMeasurements(1) % read measurements from 1 to 7
    
    measurements3 = readMeasurements(3);
    %% processing of the measurements and new control values calculation
    % DMC
    DMCy(k) = measurements1;
    e = Yzad(k) - measurements1;
    fprintf(fileID, '%f \n', measurements1);   
    u = DMC(Yzad(k), measurements1, 300, 90, 10, 0.4, Z);
    E = E + e^2;
    DMCe(k) = e;
    DMCu(k) = u; 
    fprintf(fileID1, '%f \n', u);

    %% sending new values of control signals
    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                 [ 50, 0, 0, 0, u, 0]);  % new corresponding control values

     
    sendControls([1, 5], ... send for these elements
                     [50, 0]);  % new corresponding control values
    sendControlsToG1AndDisturbance(u,Z(k));
    
    measurement = readMeasurements([1,5]);
     figure(1);
     plot(Yzad, 'r--');
     hold on;
     plot(DMCy,'b-');
     xlim([1 time]);
     ylim([25 40]);
     legend({'Y_z_a_d','Y'})
     title("Wyjście procesu");
     
     figure(2);
     stairs(DMCu,'b-');
     xlim([1 time]);
     ylim([0 100]);
     title("Sterowanie procesu - DMC");

     drawnow;

%      % synchronising with the control process
    u
    k=k+1
    waitForNewIteration(); % wait for new batch of measurements to be ready
end
fclose(fileID);
fclose(fileID1);