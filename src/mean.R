mean <- function(d) {
  
  
  # mean of random variable from its discrete distribution
  
    mean <- (d$x[2]-d$x[1])*(d$y %*% d$x)
  
  
}