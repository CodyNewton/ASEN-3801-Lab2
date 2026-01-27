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