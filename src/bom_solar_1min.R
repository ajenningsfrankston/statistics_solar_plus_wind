#
# explore the bom 1 minute data
#
source("normd.R")

library(stats4)

#bom 1 minute data 

df = "../bom_1min/sl_015590_2015_06.txt"

d <- read.csv(df,header=FALSE,skip=1)

sd <- d[c(1:7,13)]

sd$mins_since_00 <- sd[,6]*60 + sd[,7]

colnames(sd) <- c("ID","station number","year","month","day","hour","min","direct_irradiance","mins_since_00")

sd <- sd[,c(1,2,3,4,5,6,7,9,8)]

# 5 minute samples

sd5 <- subset(sd,(sd$mins_since_00 %% 5) == 0)

sd5 <- sd5[,c(6,9)]

hour_stats <- lapply(unique(sd5$hour), function(x) (subset(sd5, sd5$hour == x))$direct_irradiance)

hour_stats <- lapply(hour_stats, function(x) lapply(x, function(x) x[!is.na(x)]))

# normalise maximum solar power to correspond to 3.0MW output (1:1 with wind generator)

pmult <- 3.0/1000

# 10am to 4pm densities

hrs = seq(7,22)

solar_densities = list() 

for (hr in hrs) {

  pdata <- unlist(hour_stats[hr])
  
  pdata <- pdata*pmult
  
  solar_density <- density(pdata,from=0,to=7.5)
  
  plot(solar_density,main=toString(hr))
  
# density file has hour tag ..
  
  dname <- paste("solar_density_",toString(hr),sep="")
  
  save(solar_density,file=paste("../rdata/",dname,".rd",sep=""))
  
  solar_densities[[hr]] <- normd(solar_density)
  
  # print(hr)
  # print(mean(solar_densities[[hr]]))

}

save(solar_densities,file="../rdata/list_solar_densities.rd")





