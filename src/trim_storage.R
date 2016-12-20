trim_storage <- function(storage,capacity) {

# storage cases > capacity to capacity 

if (max(storage$x) > capacity){
  excess_cases <- which(storage$x > capacity)
  full_cases <- sum(storage$y[which(storage$x > capacity)])
  cap <- which.min(abs(storage$x-capacity))
  storage$y[cap] <- storage$y[cap] + full_cases
  if (cap %in% excess_cases) {
    excess_cases <- excess_cases[-which(excess_cases==cap)]
  }
  storage$y[excess_cases] <- 0
} 

storage 

}
