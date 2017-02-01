#extract values

ExtraVal = function (Ras,Points)
  
{ 
  
  datatest <- data.frame(coordinates(Points),
                         as.numeric(as.character(Points$surface_level))/100,
                         extract(Ras, Points))
  names(datatest) <- c("x_value", "y_value", "Surface_level_Dino", "Ras_value")
  
  datatest["Diff_Ras_Dino"] = datatest["Ras_value"] - datatest["Surface_level_Dino"]
  
  #define as spatialPdf again
  coordinates(datatest) = 1:2
  projection(datatest) = projection(Points)
  return(datatest)
  
}

