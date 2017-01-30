Combine_ras = function (x)
{ 
  
  
  #setwd to data_tiff
  setwd(paste0(getwd(),x))
  
  #combine the tifs into one file
  tiflist = list.files()
  inputRas <- lapply(tiflist, FUN = raster)
  
  combinedRas <- do.call("merge",inputRas)
 
  #return to normal WD
  setwd(unlist(strsplit(getwd(), split='/data', fixed=TRUE))[1])

  return(combinedRas)
} 
  
  


