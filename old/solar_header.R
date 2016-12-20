solar_header <- function(hstring) {
# 
# wrangle NRDEC data
#
  
h <- scan(text=hstring,what=" ")

No = h[1]
City = h[2]
State = h[3]
TimeZone = as.numeric(h[4])

ns = as.character(substring(h[5],1,1))
Latitude <- as.numeric(substring(h[5],2)) + as.numeric(h[6])/100.0
if (ns == 'S') { Latitude <- -Latitude }

we = as.character(substring(h[7],1,1))
Longitude <- as.numeric(substring(h[7],2)) + as.numeric(h[8])/100.0
if (we == 'E') { Longitude <- -Longitude }

Elevation = as.numeric(h[9])
  
  
data.frame(No,City,State,TimeZone,Latitude,Longitude,Elevation)
}