GWL_Read_Data = function(x)
  { 


#set WD for this operation#
setwd(paste0(getwd(),"/GWL_South_Limburg/"))

#Create names to save slope with coordinates
x_value = NULL
y_value = NULL
surface_level = NULL
filter_height_bottem = NULL
filter_height_top = NULL
name_gwl = NULL
date_piezometer_measured = NULL

#Read in all the names
for (i in x)
{
  #prevent reading in all the data with GWL levels
  head_data_x_y=read.csv(i, skip = 11, nrows = 10, header=TRUE, sep = ",")
  
  
  len = which(grepl("Bijzonderheid", head_data_x_y$Datum.maaiveld.gemeten)) 
  name_gwl = append(name_gwl, i)
  if (len > 1)
  {
    surface_level = append(surface_level,as.numeric(as.character(head_data_x_y$Maaiveld..cm.t.o.v..NAP.[len-1])))
    x_value= append(x_value,as.numeric(as.character(head_data_x_y$X.coordinaat[len-1])))
    y_value = append(y_value,as.numeric(as.character(head_data_x_y$Y.coordinaat[len-1])))
    filter_height_bottem = append(filter_height_bottem,head_data_x_y$Onderkant.filter..cm.t.o.v..NAP.[len-1])
    filter_height_top = append(filter_height_top,head_data_x_y$Bovenkant.filter..cm.t.o.v..NAP.[len-1])
    date_piezometer_measured = append(date_piezometer_measured,as.character(head_data_x_y$Datum.maaiveld.gemeten[len-1]))
  }
  else
  {
    x_value= append(x_value,as.numeric(as.character(head_data_x_y$X.coordinaat[1])))
    y_value = append(y_value,as.numeric(as.character(head_data_x_y$Y.coordinaat[1])))
    surface_level = append(surface_level,head_data_x_y$Maaiveld..cm.t.o.v..NAP.[1])
    filter_height_bottem = append(filter_height_bottem,head_data_x_y$Onderkant.filter..cm.t.o.v..NAP.[1] )
    filter_height_top = append(filter_height_top,head_data_x_y$Bovenkant.filter..cm.t.o.v..NAP.[1] )
    date_piezometer_measured = append(date_piezometer_measured,as.character(head_data_x_y$Datum.maaiveld.gemeten[1]))
  }
}

#return to proper (main) WD
setwd(unlist(strsplit(getwd(), split='/GWL', fixed=TRUE))[1])

Data_Piezometers = cbind(name_gwl,x_value, y_value, surface_level, filter_height_bottem, filter_height_top, date_piezometer_measured)
return(Data_Piezometers)


}
