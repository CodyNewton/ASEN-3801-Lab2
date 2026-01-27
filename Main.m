clc; 
clear; 
close all;


files={'3801_sec001_Test1.csv','3801_sec001_Test2.csv','3801_sec001_Test3.csv'};

% calling the load file that cleans the data and converts it to the
% necessary format and units. The file names were put into a cell array for
% ease of switching between the two
[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] =LoadASPENData(files{1});  



figure();
hold on 
plot3(av_pos_inert(1,:),av_pos_inert(2,:),av_pos_inert(3,:));
plot3(tar_pos_inert(1,:),tar_pos_inert(2,:),tar_pos_inert(3,:));













