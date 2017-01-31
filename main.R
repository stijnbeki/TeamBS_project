###team BS###
###Final Exercise###
###january 2017###

setwd("//wurnet.nl/homes/beern001/My Documents/GeoScripting/FinalProjectTeamBS")
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
#...

#import libraries#
library(raster)
library(rgdal)
library(downloader)
library(readr)
library(sp)
library(ggmap)    # loads ggplot2 as well
#...


#import functions
source("R_func/AHN.R")
source("R_func/Combine_ras.R")
source("R_func/GWL_data.R")
source("R_func/GWL_Read_Data.R")
source("R_func/ToSpatialPDF.R")
source("R_func/PlotggMap.R")
source("R_func/DownPolyNL.R")
source("R_func/Clipfunc.R")
#...

### START OF CALCULATION ###

#read in the codes that act as download variable for the Raster (from the AHN)
SouthLimburg = read.table("data/SouthLim_codes.txt",sep=",",header=FALSE,stringsAsFactors = FALSE)
tiffDownload = AHN(SouthLimburg)

 
#cal function that combines the raster files in a certain folder.
#variable = enter the folder that needs to be combined/merged.
Fin_SouLi_ras = Combine_ras("/data_tiff")


#define the download link
SouthLimDown <- read_file("data/SouthLim_GWL_download.txt")
#download the files
GWL_data(SouthLimDown[1])


#process the raw Piezometer data and put in one file.
GWL_list = list.files(path="GWL_South_Limburg/", pattern="*_1.csv")
Fin_GWL_Data = GWL_Read_Data(GWL_list)

##omit Na's found in x and y coordinates
Fin_GWL_Data = Fin_GWL_Data[complete.cases(Fin_GWL_Data[,2:3]),]

#Tospatialpoints data frame (Fin_GWL_Data)
#input is = (data, column of x coordinate, column of y coordinate)
Fin_GWL_Data = ToSpatialPDF(Fin_GWL_Data,2,3)

#define projection of the SpatialPoints
projection(Fin_GWL_Data) = CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +units=m +no_defs") 


##quick plot of the raster and point data
plot(Fin_SouLi_ras)
plot(Fin_GWL_Data, add=T, pch= 19, cex=0.3)
##

#download the polygon of the municipalities in Limburg,
#variable = Province name
PolygonLim = DownPolyNL('Limburg')
plot(PolygonLim, col = "red")

#plotLonLat with function INPUT = (Ras obj, Point obj)                                          ##TAKES A LONG TIME TO RUN##
#in this function botht the Raster and the Points are converted to LongLat and then plotted
#PlotggMap(Fin_SouLi_ras,Fin_GWL_Data) #<--

### do the clips to the polygon boundary ### so only points that are in the Zuid-limburg boundary.
#clip for the points
PointsClip = Clipfunc(PolygonLim, Fin_GWL_Data)

#do simple plot that shows the different layers of data
plot(Fin_SouLi_ras)
#create RD_new projected boundary polygon, which is alos already used in one function
nl_SL_RD_agg <- aggregate(spTransform(PolygonLim, CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +units=m +no_defs")))

plot(nl_SL_RD_agg, add=TRUE)
plot(PointsClip, add=TRUE, pch=19, cex=0.3)
