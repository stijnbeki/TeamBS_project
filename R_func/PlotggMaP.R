#plot the output of the raster and the points

PlotggMap = function (Ras,Poi)
{  

#data is in RD_NEW-> reproject to Lon/lat
LL_Ras  = projectRaster(Ras, crs = "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
LL_Point = spTransform(Poi, CRS("+proj=longlat +datum=WGS84"))


map <- get_map(location=rowMeans(bbox(LL_Ras)), zoom=10)   # get Google map
ggmap(map) + 
  inset_raster(as.raster(LL_Ras), xmin = LL_Ras@extent[1], xmax = LL_Ras@extent[2],
                                               ymin = LL_Ras@extent[3], ymax = LL_Ras@extent[4])+
  geom_point(data=as.data.frame(LL_Point), aes(x_value,y_value), 
             color="darkgreen", size=1.1, shape=1) 
  
} 