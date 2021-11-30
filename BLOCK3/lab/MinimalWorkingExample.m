function MinimalWorkingExample()
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM10 % initialise com port
    fileID = fopen('C:\Users\PUST\Desktop\pust_z10\BLOK2\zadanie2_skokzwykly.txt', 'w');
    global i; i = 0;
    dane(1:350)=0;
    while(i < 350)
        % obtaining measurements
        measurements1 = readMeasurements(1); % read measurements from 1 to 7
        % measurements3 = readMeasurements(3);
        % processing of the measurements and new control values calculation
        skok = 25;
        if i > 10
           skok = skok + 10;
        end
            

        % sending new values of control signals
        sendControls([1, 5], ... send for these elements
                     [0, 0]);  % new corresponding control values
        sendControlsToG1AndDisturbance(0,0);
        %sendControlsToG1AndDisturbance(0,0);
        
        measurement = readMeasurements(1:1)
        fprintf(fileID, '%f \n', measurement);
        % synchronising with the control process
        dane(i+1)= measurement;
        
%         figure(1);
%         plot(dane, 'b');
%         xlabel('Czas [s]')
%         ylabel('Temperatura [°C]')
%         ylim([20 50])
%         xlim([1 350])
%         drawnow;
        waitForNewIteration(); % wait for new batch of measurements to be ready
        i = i + 1;
    end
    fclose(fileID);
end
% clear all;
% addpath('D:\SerialCommunication'); % add a path to the functions
% initSerialControl COM10 % initialise com port
% % f = figure;
% power_G1 = 25;
% fileID = fopen('C:\Users\PUST\Desktop\pust_z10\BLOK2\z5_DMC1.txt', 'w');
% fileID1 = fopen('C:\Users\PUST\Desktop\pust_z10\BLOK2\z5_DMCwy1.txt', 'w');
% 
% Yzad(1:200) = 28.18; %31.12
% % trajektoria wartości zadanej
% Yzad(101:800) = 35;
% %Yzad(601:1000) = 30;
% Z(1:1000)=0;
% Z(351:800)=30;
% Z(601:800)=10;
% 
% k = 1;
% u = 0;
% E = 0;
% time = 1000;
% 
% 
% DMCu = zeros(time + 100,1);
% DMCy = zeros(time + 100,1);
% DMCe = zeros(time + 100,1);
% 
% figure(1);
% figure(2);
% while(1)
% 
%     %% obtaining measurements
% 
%     measurements1 = readMeasurements(1) % read measurements from 1 to 7
%     
%     measurements3 = readMeasurements(3);
%     %% processing of the measurements and new control values calculation
%     % DMC
%     DMCy(k) = measurements1;
%     e = Yzad(k) - measurements1;
%     fprintf(fileID, '%f \n', measurements1);
%     if k ==1
%         roznica = 0;
%     else
%         roznica = Z(k)-Z(k-1);
%     end
%     u = DMC(Yzad(k), measurements1, 340, 30, 1, 0.4, roznica);
%     %u = DMC(Yzad(k), measurements1, 340, 90, 10, 0.4, roznica); plk0  Yzad(1:200) = 28.18; %31.12
%     % trajektoria wartości zadanej %Yzad(201:600) = 35;
%     %u = DMC(Yzad(k), measurements1, 340, 60, 5, 1, roznica); plk1 E=1.5950e+03
%     %u = DMC(Yzad(k), measurements1, 340, 60, 5, 2, roznica); plik2 E=1.6698e+03
%     %u = DMC(Yzad(k), measurements1, 340, 60, 5, 0.4, roznica);; plik3 E=1.5041e+03
%     %u = DMC(Yzad(k), measurements1, 340, 30, 1, 0.4, roznica);; plik4 E =1.2676e+03
%     %u = DMC(Yzad(k), measurements1, 340, 30, 1, 0.4, roznica); z50%E=1.2734e+03
%     %u = DMC(Yzad(k), measurements1, 340, 30, 1, 0.4, roznica); z51 bez pomiaru Z%E=1.4576e+03
%     
%     E = E + e^2;
%     DMCe(k) = e;
%     DMCu(k) = u; 
%     fprintf(fileID1, '%f \n', u);
% 
%     %% sending new values of control signals
%     sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
%                  [ 50, 0, 0, 0, u, 0]);  % new corresponding control values
% 
%      
%     sendControls([1, 5], ... send for these elements
%                      [50, 0]);  % new corresponding control values
%     sendControlsToG1AndDisturbance(u,Z(k));
%     
%     measurement = readMeasurements([1,5]);
%      figure(1);
%      plot(Yzad, 'r--');
%      hold on;
%      plot(Z, 'g--');
%      plot(DMCy,'b-');
%      xlim([1 time]);
%      ylim([25 40]);
%      legend({'Y_z_a_d','Y'})
%      title("Wyjście procesu");
%      
%      figure(2);
%      stairs(DMCu,'b-');
%      xlim([1 time]);
%      ylim([0 100]);
%      title("Sterowanie procesu - DMC");
%      
%      drawnow;
% 
% %      % synchronising with the control process
%     u
%     k=k+1
%     waitForNewIteration(); % wait for new batch of measurements to be ready
% end
% fclose(fileID);
% fclose(fileID1);