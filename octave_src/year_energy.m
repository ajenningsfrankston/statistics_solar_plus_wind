function energy = year_energy(year,Lat,Lon,Alt )
% average day in month for each month of year
% 
% year  year  
% month month
% Lat latitude
% Lon longitude
% Alt altitude
%
% energy average energy

for i = 1:12

month_str = datestr(datenum([year i 1]),'mmm') ;
	
energy = average_day_of_month(year,i,Lat,Lon,Alt) ;

printf(" %s %4.2f  \n",month_str,energy) ;

end ;
