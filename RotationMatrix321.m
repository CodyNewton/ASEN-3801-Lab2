function DCM = RotationMatrix321(attitude321)
%% Written by Josiah Ebuen for ASEN 3801 in Lab 2
% Purpose of this function is to find the directional cosine matrix that
% defines the attitude arrangements for each unique case. The input argumen
% is the three unique angles for each transformation and the output is a
% square matrix of the DCM. In this lab it is for Function 2.

%% Convert the Angles into radians for the calculation
% Roll input from attitude argument
alpha = attitude321(1) * (pi/180);
% Pitch input from attitude argument
beta = attitude321(2) * (pi/180);
% Yaw input from attitude argument
gamma = attitude321(3) * (pi/180);

%% Calculate the rotation matrix for rach movement about the specified axis
Ralpha = [1,0,0;0,cos(alpha),sin(alpha);0,-sin(alpha),cos(alpha)];
Rbeta = [cos(beta), 0, -sin(beta); 0, 1, 0; sin(beta), 0, cos(beta)];
Rgamma = [cos(gamma), sin(gamma), 0; -sin(gamma), cos(gamma), 0; 0, 0, 1];

%% Calculate the total DCM Matrix
DCM = Ralpha * Rbeta * Rgamma;

end