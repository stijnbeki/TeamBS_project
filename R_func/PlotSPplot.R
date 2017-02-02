PlotSPplot = function(Muni)
{ 
  
  breaks.qt <- classIntervals(Muni$Diff_Ras_Dino, n = 30, style = "pretty", intervalClosure = "right")
  colfunc <- colorRampPalette(c("blue", "green", "yellow", "purple", "red"))(50)
  spplot(Muni, zcol = "Diff_Ras_Dino", col.regions= colfunc,  at = breaks.qt$brks, main="Error per Municipality")
  
}