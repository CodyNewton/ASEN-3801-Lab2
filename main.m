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

%the two following arrays are used for the remaining questions
ylabels_pos = ["X-Position (mm)", "Y-Position (mm)", "Z-Position (mm)"]; %set up an array of ylabels
ylabels_att = ["Alpha (Deg)", "Beta (deg)", "Gamma (Deg)"]; %set up an array of ylabels

figure(2)
for j = 1:length(ylabels_pos)
    subplot(3,1,j)
    hold on 
    sgtitle('Position Vs. Time (E-Frame)')
    plot(t_vec,av_pos_inert(j,:),LineWidth=2, Color="b");
    plot(t_vec,tar_pos_inert(j,:),LineWidth=2, Color="r");
    xlabel('Time (s)')
    ylabel(ylabels_pos(j));
end

figure(3)
for i = 1:length(ylabels_att)
    subplot(3,1,i)
    hold on 
    sgtitle('Angles Vs. Time (E-Frame)')
    plot(t_vec,rad2deg(av_att(i,:)),LineWidth=2, Color="b");
    plot(t_vec,rad2deg(tar_att(i,:)),LineWidth=2, Color="r");
    xlabel('Time (s)')
    ylabel(ylabels_att(i));
end

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
for k = 1:length(ylabels_att)
    subplot(3,1,k)
    sgtitle('Angle Vs. Time (313)')
    plot(t_vec,rad2deg(attitude313(k,:)),LineWidth=2)
    xlabel('Time (s)')
    ylabel(ylabels_att(k)); %fetch angle name for the ylabel in ylabels_att array
end

%% Question 6
% calculating the target relative position 
% vector using V_A-V_B=V_(B->A) 
Tar_rel_av = tar_pos_inert - av_pos_inert; 

% plotting 
figure(5)
hold on 
for a = 1:length(ylabels_pos)
    subplot(3,1,a)
    sgtitle('Relative Position Vs. Time (E-Frame)')
    plot(t_vec,Tar_rel_av(a,:),LineWidth=2)
    xlabel('Time (s)')
    ylabel(ylabels_pos(a))
end

%% Question 7

%Converting the Relative Position Vector to B Frame using the DCM at that time. 
for i=1:length(av_att) 
    DCM=RotationMatrix321(av_att(1:3,i));
    Tar_rel_av_B(1:3,i)=DCM*Tar_rel_av(1:3,i);
end

%plotting 
figure(6)
hold on 
for b = 1:length(ylabels_pos)
    subplot(3,1,b)
    sgtitle('Relative Position Vs. Time (B-Frame)')
    plot(t_vec,Tar_rel_av_B(b,:),LineWidth=2)
    xlabel('Time (s)')
    ylabel(ylabels_pos(b))
end

%% Export figures
figHandles = findall(0, 'Type', 'figure');

for i = 1:length(figHandles)
    filename = sprintf('Figure_%d.png', i);
    exportgraphics(figHandles(i), filename, 'Resolution', 300);
end

%% Functions

function attitude313 = EulerAngles313(DCM)
%% Written by Cody Newton for ASEN 3801 in Lab 2
% Purpose of the code is to use the angle relations within the DCM in order
% to find the frame changes in pure angles. This is unique to the 3-1-3
% rotation.
attitude313(1)=atan(DCM(1,3)./DCM(2,3));
attitude313(2)=acos(DCM(3,3));
attitude313(3)=atan(DCM(3,1)./-DCM(3,2));

end

function attitude321 = EulerAngles321(DCM)
%% Written by Cody Newton for ASEN 3801 for Lab 2
% Purpose of the code is to represent the given DCM in pure angles within
% the frame. This is unique to the 3-2-1 rotation matrix.
attitude321(1)=atan(DCM(2,3)./DCM(3,3));
attitude321(2)=acos(DCM(1,3));
attitude321(3)=atan(DCM(1,2)./DCM(1,1));

end

function DCM = RotationMatrix313(attitude313)
%% Written by Josiah Ebuen for ASEN 3801 in Lab 2
% Purpose of this function is to find the directional cosine matrix that
% defines the attitude arrangements for each unique case. The input
% argument is the three unique angles for each transformation and the output 
% is a square matrix of the DCM. The main difference for this matrix is that 
% only two angles are used.In this lab it is for Function 3.

%% Convert the Angles into radians for the calculation
% Roll input from attitude argument
alpha = attitude313(1);
% Pitch input from attitude argument
beta = attitude313(2);
% Yaw input from attitude argument
gamma = attitude313(3);

%% Calculate the rotation matrix for rach movement about the specified axis
Ralpha = [cos(alpha), sin(alpha), 0; -sin(alpha), cos(alpha), 0; 0, 0, 1];
Rbeta = [1,0,0;0,cos(beta),sin(beta);0,-sin(beta),cos(beta)];
Rgamma = [cos(gamma), sin(gamma), 0; -sin(gamma), cos(gamma), 0; 0, 0, 1];

%% Calculate the total DCM Matrix
DCM = Ralpha * Rbeta * Rgamma;

end

function DCM = RotationMatrix321(attitude321)
%% Written by Josiah Ebuen for ASEN 3801 in Lab 2
% Purpose of this function is to find the directional cosine matrix that
% defines the attitude arrangements for each unique case. The input argumen
% is the three unique angles for each transformation and the output is a
% square matrix of the DCM. In this lab it is for Function 2.

%% Convert the Angles into radians for the calculation
% Roll input from attitude argument
alpha = attitude321(1);
% Pitch input from attitude argument
beta = attitude321(2);
% Yaw input from attitude argument
gamma = attitude321(3);

%% Calculate the rotation matrix for rach movement about the specified axis
Ralpha = [1,0,0;0,cos(alpha),sin(alpha);0,-sin(alpha),cos(alpha)];
Rbeta = [cos(beta), 0, -sin(beta); 0, 1, 0; sin(beta), 0, cos(beta)];
Rgamma = [cos(gamma), sin(gamma), 0; -sin(gamma), cos(gamma), 0; 0, 0, 1];

%% Calculate the total DCM Matrix
DCM = Ralpha * Rbeta * Rgamma;

end








