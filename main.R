#################################
### team BS                   ###
### Final Project             ###
### jan/Feb 2017              ###
### title: "comparing AHN     ###
### vs groundwaterlevel data" ###
#################################

#the WD should be the folder where main.R is situated.

### ##  ##  ##  ##  ##  ##
#
# objective of this script:
# Compare the AHN (5m) resolution data with the elevation levels that are measured for the Groundwater-well data. 
# This should result in a map that shows that the Groundwater-well data has errors in it, which is in real-life bad for calculating groundwater flows (e.g. for Waterboards)
#
### ##  ##  ##  ##  ##  ##



### ##  ##  ##  ##  ##  ##
#
# Explanation of steps taken in this script:
# 1. The first step is to download all the necessary packages, load these packages and install all Functions(situated in "R_func/"). This is marked with "Prep".
# 2. The second step is to download the data and preprocess the data. This is marked with "Data".
# 3. The third step is to make the point data spatial and correct. This is in the end also plotted, we use a shapefile of the municipalies in NL.  we see all data maches.
# 4. The fourth step is to calculate the difference between the 2 data-sources
# 5. The fifth step is to calculate the mean error per municipality in South limburg, is the souther(more hilly part) worse than the northern part?
#
### ##  ##  ##  ##  ##  ##



##########
# 1.Prep #
##########


#clean workspace
rm(list=ls())


#install packages
install.packages("raster")
install.packages("rgdal")
install.packages("downloader")
install.packages("readr")
install.packages("sp")
install.packages("ggmap")
install.packages("rgeos")
install.packages("RColorBrewer")
install.packages("leaflet")
install.packages("classInt")
install.packages("htmlwidgets")
#...

#import libraries#
library(raster)
library(rgdal)
library(downloader)
library(readr)
library(sp)
library(ggmap)    # loads ggplot2 as well
library(rgeos)
library(RColorBrewer)
library(leaflet)
library(classInt)
library(htmlwidgets)
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
source("R_func/ExtraVal.R")
source("R_func/DiffMuni.R")
source("R_func/PlotSPplot.R")
source("R_func/PlotLeafLet.R")
#...



### START OF CALCULATION #########################################################################################################################################################



##########
# 2.Data #
##########

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



###############
#  3.Spatial  #
###############

#Tospatialpoints data frame (Fin_GWL_Data)
#input is = (data, column of x coordinate, column of y coordinate)
Fin_GWL_Data = ToSpatialPDF(Fin_GWL_Data,2,3)

#define projection of the SpatialPoints
projection(Fin_GWL_Data) = CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +units=m +no_defs") 

#download the polygon of the municipalities in Limburg,
#variable = Province name
PolygonLim = DownPolyNL('Limburg') # this is in Lat/lon
#Boundaries to RD
nl_SL_RD = spTransform(PolygonLim, CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +units=m +no_defs"))

#Set the bounary to RD and aggregate the Polygon so only outher boundary is shown.
nl_SL_RD_agg = aggregate(spTransform(PolygonLim, CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +units=m +no_defs")))

### do the clips to the polygon boundary ### so only points that are in the Zuid-limburg boundary.
#clip for the points
PointsClip = Clipfunc(nl_SL_RD_agg, Fin_GWL_Data)

##quick plot of the raster and point data (in RD)
plot(Fin_SouLi_ras)
plot(PointsClip, add=T, pch= 19, cex=0.3)
plot(nl_SL_RD_agg, add=TRUE, fill=FALSE)




################
#  4.CalcDiff  #
################

#Extract values and add as column
#Variables: The Raster file, the points file.
PointsClip_diff = ExtraVal(Fin_SouLi_ras,PointsClip)

    ##done in LATLON
#GGplot requires lat/Lon coordinate system: therefore transform the coordinate systems of the Raster and Points
#data is in RD_NEW-> reproject to Lon/lat, ##THIS PROJECTION TAKES A LONG TIME##
LL_Ras  = projectRaster(Fin_SouLi_ras, crs = "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
LL_Point = spTransform(PointsClip_diff, CRS("+proj=longlat +datum=WGS84"))

#use this as input for the GGPLOT
PlotggMap(LL_Ras,LL_Point)
    ##


################
#  5.ErrorMun  #
################
###
# Now all points contain a column that says how big the difference is.
# This function calculates the mean per municipality for this and plots this.
# variables: Points,muniBoundery
###
nl_Sl_RD_Muni_diff = DiffMuni(PointsClip_diff,nl_SL_RD)



##########
# 6.PLOT #
##########

###
#this function plots the error per municipality (calculated in section 5)
###

PlotSPplot(nl_Sl_RD_Muni_diff)


###
#this plot contains all final information, in an interactive environment
###
source("R_func/PlotLeafLet.R")
PlotLeafLet(PointsClip_diff, nl_Sl_RD_Muni_diff)

#####THE END#####
###TEAM BS (c)###