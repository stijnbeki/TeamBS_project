###team BS###
###Final Exercise###
###january 2017###

getwd()
setwd("//wurnet.nl/homes/beern001/My Documents/GeoScripting/FinalProjectTeamBS")
#clean workspace
rm(list=ls())


#install packages
install.packages("raster")
install.packages("rgdal")
install.packages("readr")
...

#import libraries#
library(raster)
library(rgdal)
library(readr)
...


#import functions
source("R_func/AHN.R")


#do calc
XList = read.table("data/SouthLim_codes.txt",sep=",",header=FALSE,stringsAsFactors = FALSE)

tiffDownload = AHN(XList)


plot(raster(tiffDownload))

