# Bring in Blandy EC data
#install.packages("BiocManager")
#BiocManager::install("rhdf5")
#install.packages("neonUtilities")
options(stringsAsFactors = FALSE)

# packages
require(neonUtilities)
require(lubridate)
require(tidyverse)



# 
# zipsByProduct(dpID = "DP4.00200.001", package = "basic",
#               site = "BLAN",
#               startdate = "2017-01", enddate = "2020-12",
#               savepath = "./data/",
#               check.size = FALSE)

flux <- stackEddy(filepath = "./data/filesToStack00200",
                  level = "dp04")

# looking at plot
timeB <- as.POSIXct(flux$BLAN$timeBgn, 
                    format="%Y-%m-%dT%H:%M:%S", 
                    tz="GMT")
flux$BLAN <- cbind(timeB, flux$BLAN)

# plotting
plot(flux$BLAN$data.fluxCo2.nsae.flux ~ timeB, 
     pch=".", xlab="Date", ylab="CO2 flux",
     xaxt="n")
axis.POSIXct(1, x=timeB, format="%Y-%m-%d")

# checking distribution
hist(flux$BLAN$data.fluxCo2.nsae.flux)

plot(flux$BLAN$data.fluxCo2.nsae.flux~timeB, 
     pch=20, xlab="Date", ylab="CO2 flux",
     xlim=c(as.POSIXct("2020-03-07", tz="GMT"),
            as.POSIXct("2020-03-09", tz="GMT")),
     ylim=c(-20,20), xaxt="n")
axis.POSIXct(1, x=timeB, format="%Y-%m-%d %H:%M:%S")

df <- data.frame(flux$BLAN)

# Sorting to daily fluxes
df %>%
  mutate(day = as.Date(timeB)) %>%
  group_by(day) %>%
  summarise(nee = sum(data.fluxCo2.nsae.flux, na.rm = TRUE),
            le = sum(data.fluxH2o.nsae.flux, na.rm = TRUE),
            h = sum(data.fluxTemp.nsae.flux, na.rm = TRUE)) -> flux.day

write.csv(flux.day, "blandy_daily_ec_fluxes.csv")












#### read in BLANDY AmeriFlux dataset

af <- read.csv("./data/blandy_af_data.csv", skip = 2)
af$day <- as.numeric(substr(af$TIMESTAMP_START, start = 0, stop = 8))
af$day <- ymd(af$da
af$day <- subsy)