ToSpatialPDF = function(x)
{ 
}



cords = as.data.frame(Fin_GWL_Data[,c("x_value", "y_value")])
attributes = as.data.frame(Fin_GWL_Data[,1:6])

###Not working yet... Kut
SpatialPointsGWL = SpatialPointsDataFrame(cords, attributes)
