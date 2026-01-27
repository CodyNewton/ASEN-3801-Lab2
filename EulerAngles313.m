
function attitude313 = EulerAngles313(DCM)

attitude313(1)=arctan(DCM(1,3)./DCM(2,3));
attitude313(2)=arccos(DCM(3,3));
attitude313(3)=arctan(DCM(3,1)./-DCM(3,2));

end