#X The polygon that defines Limburg
#Y The raster data or points data that need to be clipped

#all variables in RD_NEW

Clipfunc = function (x,y)
{ 

# nl_SL_RD <- spTransform(x, CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +units=m +no_defs"))
# nl_SL_RD_agg <- aggregate(nl_SL_RD)

#do the clip 
Clipped_points = y[x,]

return(Clipped_points)

}
