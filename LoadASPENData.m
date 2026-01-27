% Cody Newton, Josiah Eubuen, Sovann Bonini, Jacob Johnson
% ASEN 3801
% LoadASPENData
% Created 1/27/2026

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inputs: Data Files: '3801_sec001_Test1.csv','3801_sec001_Test2.csv','3801_sec001_Test3.csv'

%Outputs: t_vec: 1 x 𝑛𝑛 time vector in seconds where 𝑛𝑛 = the total number of frames from the dataset.
%           The frame rate of the camera is 100 Hz so the frame number can be converted to time in seconds.
%         av_pos_inert: 3 x 𝑛𝑛 matrix of position vectors in meters for the aerospace vehicle in Frame 𝐸.
%         av_att: 3 x 𝑛𝑛 matrix of attitude vectors listing the 3-2-1 Euler angles in radians for the
%           aerospace vehicle relative to Frame 𝐸𝐸.
%         tar_pos_inert: 3 x 𝑛𝑛 matrix of position vectors in meters for the target in Frame 𝐸𝐸.
%         tar_att: 3 x 𝑛𝑛 matrix of attitude vectors listing the 3-2-1 Euler angles in radians for the
%           target relative to Frame 𝐸𝐸
% above copied from lab Documentation 


%Methodology: Takes in the raw data checks for nan values to get rid of
%them in the data set. Then seperates the raw data into useful categories
%to then pass into ConvertASPENData and pass the outputs out. Also plots
%the graph for question 3 as this is the easiest place to acess the data. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





function [t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] =LoadASPENData(filename)
% Reading in the data
test=readmatrix(filename); 

%% cleaning up the data 
if(find(isnan(test)))
idx=find(isnan(test)); % finding all NaN values in the data
[rowIdx, ~] = ind2sub(size(test), idx); % finding row idx of all NaN values in data 

test(rowIdx,:)=[]; % eliminating all NaN values in data

end
%% Parsing the data 
Frame=test(:,1);
time=Frame/100;
t_vec=time';
for i=1:3
Target.HelicalAngles(:,i)=test(:,1+i);
Target.Position(:,i)=test(:,4+i);
Vehicle.HelicalAngles(:,i)=test(:,7+i);
Vehicle.Position(:,i)=test(:,10+i);
end
[av_pos_inert, av_att, tar_pos_inert, tar_att] = ConvertASPENData(Vehicle.Position', Vehicle.HelicalAngles', Target.Position', Target.HelicalAngles');

%% Question 3 Plotting
figure(1);
hold on 
plot3(Vehicle.Position(:,1),Vehicle.Position(:,2),Vehicle.Position(:,3),'b',LineWidth=2 );
plot3(Target.Position(:,1),Target.Position(:,2),Target.Position(:,3),'r--',LineWidth=2);
legend('Drone Position','Target Position')
xlabel('Position (mm)')
ylabel('Postion (mm)')
zlabel('Positon (mm)')
title('Drone & Target Position (N Frame)')
view(3);
end