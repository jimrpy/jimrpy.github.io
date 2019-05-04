## 3D plot R code
## Code author: LI Jinming

## preparation
getwd()                      ## check work directory
setwd("~/Downloads/")        ## set work directory to the data source

## attach packages
library(tidyverse)
library(reshape2)
library(plot3D)
load(df2mat.R)

## load raw data
file <- file("SH.csv")       ## given raw data name
tmp <- read_csv(file)        ## read raw data

## check the data
tmp %>% head()               ## the first 6 lines
tmp %>% summary()            ## data summary
names(tmp) <- tolower(names(tmp))      ## set the variable names to lower

df <- tmp %>% dplyr::select(-treatment) %>%      ## rm unused variable
  group_by(year) %>%                             ## group by year
  nest() %>%                                     ## nest data as list
  mutate(mat = map(data, ~df2max(df = ., var.row = density, var.col = ninput, var.value = yield))) 


## plot all 3d graphs as png files

for (i in seq_along(df$year)) {                                      ## one plot for each year
png(paste0("Year", df$year[i], ".png"))                              ## save the result as png file
  
persp3D(x = unique(df$data[[i]]$density),                            ## x - density
        xlab = "\nDensity",
        y = unique(df$data[[i]]$ninput),                             ## y - ninput
        ylab = "\nNinput", 
        z = df$mat[[i]],                                             ## z - yield
        zlab = "\n\nYield",
        xlim = range(df$data[[i]]$density),                          ## xaxis
        ylim = range(df$data[[i]]$ninput),                           ## yaxis
        ticktype = "detailed",                                       ## axis ticks
        border = "white",                                            ## cut line color
        col.grid = "gray60",                                         ## grid color
        bty = "u",                                                   ## box type
        clab = "Yield",                                              ## legend title
        theta = 45, phi = 20,                                        ## view direction
        main = paste("Year", df$year[i])
        )         
dev.off()
}
