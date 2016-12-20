function dc = day_of_year(varargin)
%
% calculates day of year
%
[year month day hour min sec] = datevec(datenum(varargin{:}));

dc = datenum(year,month,day) - datenum(year,1,1) + 1 ;