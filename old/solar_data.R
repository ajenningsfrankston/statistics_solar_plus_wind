#
# explore the 20yr solar data
#
source("solar_header.R")
source("extract_solar_data.R")
#source("solar_radiation.R")
#source("SolarAzEl.R")

library(lubridate)
library(ggplot2)

df = "../12842/12842_61.txt"


fl = file(df,open='r')
header <- readLines(fl,1)


# extract header  



x <- solar_header(header)
Lat <- as.numeric(x[5])
Lon <- as.numeric(x[6])
Elev <- as.numeric(x[7])

# extract data 

solar_data <- readLines(fl)

print("read data")

sdata <- lapply(solar_data,extract_solar_data)

print("processed data")

close(fl)

sd = matrix(nrow=length(sdata),ncol=length(sdata[[1]]))

for(i in 1:length(sdata)) {
  sd[i,] <- sdata[[i]]
}

actual_solar <- sd[,9]

date <- paste("19",sd[ ,1],"-",sd[ ,2],"-",sd[ ,3],sep="")

time <- paste(sd[ ,4],":00:00",sep="")

utc_time <- ymd_hms(paste(date,time))

utc_time <- utc_time + hours(x[4])


perf = data.frame(time=hour(utc_time),actual_solar)

continue = TRUE

day = 0

while(continue) {
  
print("n to continue ..")
  
cmd = readline()

if (cmd != 'n')
{ continue = FALSE }

day <- day + 1

pd <- subset(perf,day_of_year==day)


# plot day by day until quit

 disp <- ggplot(pd, aes(time)) +
   geom_line(aes(y=actual_solar,colour="blue"))


 print(disp)
  
}





