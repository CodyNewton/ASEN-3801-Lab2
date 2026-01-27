
function DCM = RotationMatrix313(attitude313)

phi= attitude313(1);
theta=attitude313(2);
psi=attitude313(3);
R_3=[ cos(psi) sin(psi) 0; -sin(psi) cos(psi) 0; 0 0 1];
R_1=[ cos(phi) sin(phi) 0; -sin(phi) cos(phi) 0; 0 0 1];
R_2=[cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)];

DCM=R_1*R_2*R_3;
end