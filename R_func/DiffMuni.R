DiffMuni = function(Poi,Muni)

#################################################

{ 
Pointsclip_sl = Poi["Diff_Ras_Dino"]

Pointsclip_sl = as.data.frame(Pointsclip_sl)
Pointsclip_sl = Pointsclip_sl[complete.cases(Pointsclip_sl[[1]]),]
Pointsclip_sl$Diff_Ras_Dino = as.numeric(as.character(Pointsclip_sl$Diff_Ras_Dino))
coordinates(Pointsclip_sl) = 2:3
projection(Pointsclip_sl) = CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +units=m +no_defs")

#do the overlay --> the point data is averaged (fn=mean) and added to the polygons.
Muni_Dif_fill = over(Muni,Pointsclip_sl, fn=mean)
Muni@data$Diff_Ras_Dino = Muni_Dif_fill$Diff_Ras_Dino

return(Muni)
 
} 