#X The polygon that defines Limburg
#Y The raster data or points data that need to be clipped

#coordinate system: all variables in RD_NEW

Clipfunc = function (x,y)
{ 

#do the clip 
Clipped_points = y[x,]

return(Clipped_points)

}
