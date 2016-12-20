function energy = average_day_of_month(year,month,Lat,Lon,Alt )
% average day in month
% 
% year  year  
% month month
% Lat latitude
% Lon longitude
% Alt altitude
%
% energy average energy

no_days = eomday(year,month) ;

total_energy = 0 ;

for i = 1:no_days
	total_energy = total_energy + day_energy([year month i],Lat,Lon,Alt) ;
end ;

energy = total_energy/no_days ;

