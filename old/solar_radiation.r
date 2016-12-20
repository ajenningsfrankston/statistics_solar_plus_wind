solar_radiation <-function(p){

#PURPOSE: Calculate solar radiation 
#-------------------------------------------------------------------
  #USAGE: srad = solarradiation(az,el,d)
  #where: az azimuth location of the sun in degrees
  #       el elevation location of the sun in degrees
  #       d  day of the year (365 day year)
  #
  #      srad is the solar radiation in W/m2 
  #
  #EXAMPLE:
    #      srad = solar_radiation(223,53,122)
    #
    az <- p[1]
    el <- p[2]
    d  <- p[3]
    
    tau_a    <- 365     #length of the year in days
    S0 <- 1367          #solar constant W m^-2   default 1367
    dr<- 0.0174532925   #degree to radians conversion factor
    fcirc <- 360*dr     #360 degrees in radians
    
    
    I0 <- S0 * (1 + 0.0344*cos(fcirc*d/tau_a)) #extraterr rad 
    dS <- az*dr 
    
    alpha_s <- el*dr 
    sinAlpha <- sin(alpha_s) 
    
    M<-sqrt(1229+((614*sinAlpha))^2)-614*sinAlpha #Air mass ratio
    tau_b <- 0.56*(exp(-0.65*M) + exp(-0.095*M))
    
    srad <- 0.6*I0*tau_b 
    
}