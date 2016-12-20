extract_solar_data <- function(xstring) {  
#
# process a row of data 
#
# e.g. 61  1  1  1    0    0    0 ?0    0 ?0    0 ?0
#

  s <- scan(text=xstring,what=" ",quiet=TRUE)

  suppressWarnings(as.numeric(unlist(s)))
}