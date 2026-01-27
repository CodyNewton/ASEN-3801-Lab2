function attitude313 = EulerAngles313(DCM)
%% Written by Cody Newton for ASEN 3801 in Lab 2
% Purpose of the code is to use the angle relations within the DCM in order
% to find the frame changes in pure angles. This is unique to the 3-1-3
% rotation.
attitude313(1)=atan(DCM(1,3)./DCM(2,3));
attitude313(2)=acos(DCM(3,3));
attitude313(3)=atan(DCM(3,1)./-DCM(3,2));

end