PlotLeafLet = function(Poi, Muni)
  
{
  #set to long/lat
  Points_LL = spTransform(Poi, CRS("+proj=longlat +datum=WGS84"))
  Polygon_LL = spTransform(Muni, CRS("+init=epsg:4326"))
  
  #leaflet function
m =  leaflet()
m =    addMarkers(m,data = Points_LL,
               popup = ~as.character(round(Points_LL$Diff_Ras_Dino, digits =2)))
    #addPolygons(data=Polygon_LL, stroke = TRUE,  fill = TRUE) %>%
m =    addTiles(m)

#this works if the file= "path" is not set to the M directory. (so for instance D drive)  
#saveWidget(m, file="data/Points.html")
  
return(m)
}