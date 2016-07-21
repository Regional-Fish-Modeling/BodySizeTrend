#### Model year effect of adult BKT size with month-level random intercept ####
setwd("I:/projects/BKTREG/Analysis/TLOverTime")

setwd("...")
require(lme4)
require(sjPlot)

d <- read.csv("REGBKT_MASTER_23Mar15.csv")

d$TotalLength_mm <- as.numeric(d$TotalLength_mm)
d$Year <- as.numeric(d$Year)
d$Date <- as.POSIXlt(as.character(d$Date), format= "%m/%d/%Y")
d$Month <- as.numeric(format(d$Date, "%m"))
d <- subset(d, Species == "BKT") # only BKT
d <- subset(d, TotalLength_mm >=100) # only adults
d$TotalLength_mm <- scale(d$TotalLength_mm) # z-scores for length data

# Random-effects model for adult size ~ year
mod1 <- lmer(TotalLength_mm ~ (1|Year), d, REML=T)
# plot standardized random effects
sjp.lmer(mod1)
ranef(mod1)