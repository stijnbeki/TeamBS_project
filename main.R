###team BS###
###Final Exercise###
###january 2017###

#setwd("//wurnet.nl/homes/beern001/My Documents/GeoScripting/FinalProjectTeamBS")
#getwd()
#setwd("//wurnet.nl/homes/beern001/My Documents/GeoScripting/FinalProjectTeamBS")

#clean workspace
rm(list=ls())


#install packages
install.packages("raster")
install.packages("rgdal")
install.packages("downloader")
install.packages("readr")
install.packages("sp")
install.packages("ggmap")
...

#import libraries#
library(raster)
library(rgdal)
library(downloader)
library(readr)
library(sp)
library(ggmap)    # loads ggplot2 as well
...


#import functions
source("R_func/AHN.R")
source("R_func/Combine_ras.R")
source("R_func/GWL_data.R")
source("R_func/GWL_Read_Data.R")
source("R_func/ToSpatialPDF.R")
source("R_func/PlotggMap.R")

#do calc
SouthLimburg = read.table("data/SouthLim_codes.txt",sep=",",header=FALSE,stringsAsFactors = FALSE)

tiffDownload = AHN(SouthLimburg)

 
#cal function that combines the raster files.
#--> as ##Variable##, enter the folder that needs to be combined/merged.
Fin_SouLi_ras = Combine_ras("/data_tiff")
#plot
plot(Fin_SouLi_ras)  


#define the download link
SouthLimDown <- read_file("data/SouthLim_GWL_download.txt")
#download the files
GWL_data(SouthLimDown[1])



#process the raw Piezometer data and put in one file.
GWL_list = list.files(path="GWL_South_Limburg/", pattern="*_1.csv")
Fin_GWL_Data = GWL_Read_Data(GWL_list)

#Tospatialpoints data frame (Fin_GWL_Data)
#input is = (data, column of x coordinate, column of y coordinate)
Fin_GWL_Data = ToSpatialPDF(Fin_GWL_Data,2,3)
#define projection
projection(Fin_GWL_Data) = CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +units=m +no_defs") 


plot(Fin_SouLi_ras)
plot(Fin_GWL_Data, add=T, pch= 19, cex=0.3)



#plotLonLat with function   INPUT = (Ras obj, Point obj)
PlotggMap(Fin_SouLi_ras,Fin_GWL_Data)


