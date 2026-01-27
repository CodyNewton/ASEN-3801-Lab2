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

end