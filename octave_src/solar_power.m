function power = solar_power(date,time,Lat,Lon,Alt )
% solar power at latitude, longitude, time, altitude
%   
% date vector form of date [ year month day  hr min sec ]
% Lat latitude
% Lon longitude
% Alt altitude
%
% power solar_power at the time

vdate = [date time ] ;


dstr = datestr(vdate,'yyyy/mm/dd HH:MM:SS') ;

[Az El dc] = SolarAzEl(dstr,Lat,Lon,Alt) ;

power = solar_radiation(Az,El,dc) ;


end

