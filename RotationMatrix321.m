function DCM = RotationMatrix321(attitude321)


phi= attitude321(1);
theta=attitude321(2);
psi=attitude321(3);


R_1=[1 0 0; 0 cos(phi) sin(phi); 0 -sin(phi) cos(phi) ];
R_2=[cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)];
R_3=[ cos(psi) sin(psi) 0; -sin(psi) cos(psi) 0; 0 0 1];

DCM=R_1*R_2*R_3;


end