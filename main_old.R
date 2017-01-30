###team BS###
###Final Exercise###
###january 2017###

#setwd("//wurnet.nl/homes/beern001/My Documents/GeoScripting/FinalProjectTeamBS")
getwd()
setwd("//wurnet.nl/homes/beern001/My Documents/GeoScripting/FinalProjectTeamBS")
#clean workspace
rm(list=ls())


#install packages
install.packages("raster")
install.packages("rgdal")
install.packages("downloader")
install.packages("readr")
...

#import libraries#
library(raster)
library(rgdal)
library(downloader)
library(readr)
...


#import functions
source("R_func/AHN.R")
source("R_func/Combine_ras.R")
source("R_func/GWL_data.R")
#do calc
SouthLimburg = read.table("data/SouthLim_codes.txt",sep=",",header=FALSE,stringsAsFactors = FALSE)

tiffDownload = AHN(SouthLimburg)

 
#cal function that combines the raster files.
#--> as ##Variable##, enter the folder that needs to be combined/merged.
SouLi_ras = Combine_ras("/data_tiff")
#plot
plot(SouLi_ras)  


#define the download link
SouthLimDown <- read_file("data/SouthLim_GWL_download.txt")
#download the files
GWL_data(SouthLimDown[1])


