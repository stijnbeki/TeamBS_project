### Download the polygons ###

DownPolyNL = function (x)
{ 

nlMunicipality <- getData('GADM',country='NLD', level=2)
nlProvince <- getData('GADM',country='NLD', level=1)

nl_SL_LL <- subset(nlMunicipality, nlMunicipality$NAME_1 == x)
nl_SL_LL

return(nl_SL_LL)

}

##Plot downloaded data
# plot(nl_SL, lwd=10, border="skyblue")
# 
# plot(nl_SL, col="green4", add=T)
# grid()
# box()
# invisible(text(getSpPPolygonsLabptSlots(mar), labels=as.character(mar$NAME_2), cex=1.1, col="white", font=2))
# mtext(side=3, line=1, "Provincial Map of Marinduque", cex=2)
# mtext(side=1, "Longitude", line=2.5, cex=1.1)
# mtext(side=2, "Latitude", line=2.5, cex=1.1) 
# text(122.08,13.22, "Projection: Geographic\nCoordinate System: WGS 1984\nData Source: GADM.org\nCreated by: ARSsalvacion", adj=c(0,0), cex=0.7, col="grey20")
