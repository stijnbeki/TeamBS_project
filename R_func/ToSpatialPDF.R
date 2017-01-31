ToSpatialPDF = function(d,x,y)
{ 

d = as.data.frame(d)
d[,x] = as.numeric(as.character(d[,x]))
d[,y] = as.numeric(as.character(d[,y]))

coordinates(d) = x:y

return(d)
} 