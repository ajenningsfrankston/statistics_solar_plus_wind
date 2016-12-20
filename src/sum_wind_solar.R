#
# distribution of wind + power 
#
library(gtools)
library(ggplot2)
library(readr)

all_files <- list.files(path="../rdata")
solar_files <- all_files[which(startsWith(all_files,"solar_density"))]
solar_files <- mixedsort(solar_files)

source("convolution.R")
source("normd.R")

load(file="../rdata/wind_density.rd")

sum_densities = list()

for (solar_file in solar_files) {
  
  spath <- file.path("../rdata",solar_file)
  
  load(file=spath)

  d <- convolution(wind_density,solar_density)
  
  time <- parse_number(solar_file)
  
  pd = data.frame(x=d$z,y=d$dz)
  
  pd <- normd(pd)
  
  sum_densities[[time]] <- pd
  
  
  title = paste("Time of day ",time,":00",sep="")
  
  p <- ggplot(pd,aes(x=x,y=y)) + geom_line() + ggtitle(title)
  print(p)
  Sys.sleep(1)
  
}

save(sum_densities,file="../rdata/list_sum_densities.rd")