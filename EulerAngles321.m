function attitude321 = EulerAngles321(DCM)
%% Written by Cody Newton for ASEN 3801 for Lab 2
% Purpose of the code is to represent the given DCM in pure angles within
% the frame. This is unique to the 3-2-1 rotation matrix.
attitude321(1)=atan(DCM(2,3)./DCM(3,3));
attitude321(2)=acos(DCM(1,3));
attitude321(3)=atan(DCM(1,2)./DCM(1,1));

end