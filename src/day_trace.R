#
# progress of energy balance over the day 
# 
#
library(ggplot2)


source("trim_storage.R")
source("convolution.R")
source("mean.R")
source("sum_probs.R")

storage_capacity = 1.0

hrs = seq(7,22)

demand = vector(mode="numeric",length=24)

demand[] = 1.0
demand[6:9] = 1.5
demand[16:20] = 2.0

# residual (eg. 4am) demand

background_demand = 0.50

demand <- background_demand*demand

# for non demand hours wind feeds to storage

bhrs = seq(1,7)

load(file="../rdata/wind_density.rd")

storage_density <- wind_density


for (hr in bhrs) {
  
  d <- convolution(wind_density,storage_density)
  
  storage_density$x = d$z
  storage_density$y = d$dz
  
  storage_density$x <- storage_density$x - background_demand
  
  
#  plot(storage_density)
  
  storage_density <- trim_storage(storage_density,storage_capacity)
  storage_density <- normd(storage_density)
  
#  plot(storage_density)
  
  
}

mean_storage <- mean(storage_density)


# demand hours 7 to 22: balance between supply, demand and storage 

balance_densities = list() 

load(file="../rdata/list_sum_densities.rd")

peak_density <- sum_densities[[12]]

mean_peak <- mean(peak_density)

storage_trace = data.frame(hrs)
storage_trace["balance"] <- NA
storage_trace["withdraw"] <- NA

for (hr in hrs) {
  
       balance = sum_densities[[hr]]
  
       balance$x <- balance$x - demand[hr]
       
       surplus <- mean(balance)
       mean_storage <- mean_storage + surplus
       if (mean_storage > storage_capacity) { mean_storage <- storage_capacity}
    
       threshold_loc <- min(which(balance$y>0.01))
       threshold <- balance[threshold_loc,]$x
       
       if ((threshold < 0) && (mean_storage > 0)) {
         withdraw <- -threshold
         if (withdraw > mean_storage) { withdraw <- mean_storage }
         
         balance$x <- balance$x + withdraw 
         mean_storage <- mean_storage - withdraw
         
         storage_trace$balance[hr-hrs[1]+1] <- mean_storage
         storage_trace$withdraw[hr-hrs[1]+1] <- withdraw
        
       }
       
       title = paste("Time ",hr,":00"," Balance","  Peak Supply/Base Demand ",format(mean_peak/background_demand,digits=2)) 
       title <- paste(title," Storage ",storage_capacity,sep="")
       
       fname = paste("../plots/balance_",hr,".jpg",sep="")
       
       p <- ggplot(balance,aes(x=x,y=y)) + geom_line() + ggtitle(title)
       p <- p +labs(y="p(x)")
       print(p)
       ggsave(fname)
       Sys.sleep(2)
     
  
}

fname = paste("../plots/storage.jpg",sep="")
p <- ggplot(storage_trace,aes(x=hrs,y=balance)) + geom_line()
print(p)
ggsave(fname)
Sys.sleep(2)
fname = paste("../plots/withdraw.jpg",sep="")
p <- ggplot(storage_trace,aes(x=hrs,y=withdraw)) + geom_line()
print(p)
ggsave(fname)


