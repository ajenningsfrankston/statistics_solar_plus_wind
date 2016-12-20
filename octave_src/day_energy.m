function energy = day_energy(day,Lat,Lon,Alt )
% solar power at latitude, longitude, time, altitude
%   
% day vector form of day [ year month day  ]
% Lat latitude
% Lon longitude
% Alt altitude
%
% power solar_power at the time



for i = 1:24

 hr_energy(i)  = solar_power(day,[i-1 0 0 ],Lat,Lon,Alt) ;
 
end ;

energy = sum(hr_energy) ;

end

