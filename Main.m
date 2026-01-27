% Cody Newton, Josiah Eubuen, Sovann Bonini, Jacob Johnson
% ASEN 3801
% Main
% Created 1/27/2026

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inputs: Data Files: '3801_sec001_Test1.csv','3801_sec001_Test2.csv','3801_sec001_Test3.csv'

%Outputs: Various Figures 

%Methodology: Takes in the raw data calls various functions to clean data
%and process it into various frames using DCMS calculated from the given
%data. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; 
clear; 
close all;


files={'3801_sec001_Test1.csv','3801_sec001_Test2.csv','3801_sec001_Test3.csv'};

% calling the load file that cleans the data and converts it to the
% necessary format and units. The file names were put into a cell array for
% ease of switching between the two
[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] =LoadASPENData(files{2});  


%%  Question 4
% plotting
figure(2)
hold on 
subplot(3,1,1)
sgtitle('Position Vs. Time (E-Frame)')
plot(t_vec,av_pos_inert(1,:),LineWidth=2)
xlabel('Time (s)')
ylabel('X-Position (mm)')
ylim([-2300 2000])
subplot(3,1,2)


plot(t_vec,av_pos_inert(2,:),LineWidth=2)
xlabel('Time (s)')
ylabel('Y-Position (mm)')
legend('Drone Position',Location='SouthEast')
ylim([-3000 300])
subplot(3,1,3)


plot(t_vec,av_pos_inert(3,:),LineWidth=2)
xlabel('Time (s)')
ylabel('Z-Position (mm)')
ylim([-3000 200])

figure(3)
hold on 
subplot(3,1,1)
sgtitle('Angles Vs. Time (E-Frame)')
plot(t_vec,av_att(1,:)*180/pi,LineWidth=2)
xlabel('Time (s)')
ylabel('Alpha (Deg)')

subplot(3,1,2)


plot(t_vec,av_att(2,:)*180/pi,LineWidth=2)
xlabel('Time (s)')
ylabel('Beta (Deg)')
legend('Drone Attitude',Location='SouthEast')

subplot(3,1,3)


plot(t_vec,av_att(3,:)*180/pi,LineWidth=2)
xlabel('Time (s)')
ylabel('Gamma (Deg)')


%% Question 5

% Converting to 313 angles using the methodology explained in the lab
% document
for i=1:length(av_att)
DCM=RotationMatrix321(av_att(1:3,i));
attitude313(1:3,i) = EulerAngles313(DCM);
end

% plotting
figure(4)
hold on 
subplot(3,1,1)
sgtitle('Angle Vs. Time (313)')
plot(t_vec,attitude313(1,:)*180/pi,LineWidth=2)
xlabel('Time (s)')
ylabel('Alpha (Deg)')

subplot(3,1,2)


plot(t_vec,attitude313(2,:)*180/pi,LineWidth=2)
xlabel('Time (s)')
ylabel('Beta (Deg)')
legend('Drone Attitude',Location='NorthEast')
ylim([-10 200])
subplot(3,1,3)


plot(t_vec,attitude313(3,:)*180/pi,LineWidth=2)
xlabel('Time (s)')
ylabel('Gamma (Deg)')

%% Question 6

Tar_rel_av=tar_pos_inert-av_pos_inert; % calculating the target relative position vector using the V_A-V_B=V_(B->A) 


% plotting 
figure(5)
hold on 
subplot(3,1,1)
sgtitle('Relative Position Vs. Time (E-Frame)')
plot(t_vec,Tar_rel_av(1,:),LineWidth=2)
xlabel('Time (s)')
ylabel('X-Position (mm)')

subplot(3,1,2)


plot(t_vec,Tar_rel_av(2,:),LineWidth=2)
xlabel('Time (s)')
ylabel('Y-Position (mm)')
legend('Drone Position',Location='NorthEast')

subplot(3,1,3)


plot(t_vec,Tar_rel_av(3,:),LineWidth=2)
xlabel('Time (s)')
ylabel('Z-Position (mm)')





%% Question 7

%Converting the Relative Position Vector to B Frame using the DCM at that
%time. 
for i=1:length(av_att) 
DCM=RotationMatrix321(av_att(1:3,i));
Tar_rel_av_B(1:3,i)=DCM*Tar_rel_av(1:3,i);
end



%plotting 
figure(6)
hold on 
subplot(3,1,1)
sgtitle('Relative Position Vs. Time (B-Frame)')
plot(t_vec,Tar_rel_av_B(1,:),LineWidth=2)
xlabel('Time (s)')
ylabel('X-Position (mm)')

subplot(3,1,2)


plot(t_vec,Tar_rel_av_B(2,:),LineWidth=2)
xlabel('Time (s)')
ylabel('Y-Position (mm)')
legend('Drone Position',Location='NorthEast')

subplot(3,1,3)


plot(t_vec,Tar_rel_av_B(3,:),LineWidth=2)
xlabel('Time (s)')
ylabel('Z-Position (mm)')