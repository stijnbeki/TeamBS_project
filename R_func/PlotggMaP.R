#plot the output of the raster and the points

PlotggMap = function (Ras,Poi)
{  

  #LL_Point_Sub = subset(Poi, Diff_Ras_Dino <2 & Diff_Ras_Dino >-2)
  
  #make the palette for the plot
  cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
  
  
  map <- get_map(location=rowMeans(bbox(Ras)), zoom=9)   # get Google map
  p = ggmap(map) + 
    inset_raster(as.raster(Ras), xmin = Ras@extent[1], xmax = Ras@extent[2],
                 ymin = Ras@extent[3], ymax = Ras@extent[4]) +
    
    geom_point(data=as.data.frame(Poi), aes(x_value,y_value,col=Diff_Ras_Dino),
               size=1.1, shape=16) +
    scale_colour_gradientn(colours=rainbow(6),limits=c(-2,2),
                           breaks = c(-2, -1, 0, 1, 2))+
    geom_polygon(data=aggregate(PolygonLim), aes(long,lat), col="black", fill = NA, size = 1.2)
  
  p2= p + ggtitle("Piezometers Limburg compared to DEM 5m resolution") + 
    theme(plot.title = element_text(lineheight=.8, face="bold", hjust = .5)) +
    labs(col = "DEM minus \nDinoloket (m)")
  
  p2
  
} 

