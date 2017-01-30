###download the AHN data
### 5m resoltion

#getwd()
#the x is now the code of the tile to download, (now for instance 68gz2, which is somewhere in south limburg)
AHN = function (x)
{ 

#linkVariable
Geodata="https://geodata.nationaalgeoregister.nl/ahn2/extract/ahn2_5m/ahn2_5_"
  #need list with abbreviations of the different zip

#create dir to save the tiffs to   
dir.create("data_tiff")

### download and unzip
for (i in 1:length(x))
      { 
          download.file(paste0(Geodata,paste0(x[i],".tif.zip")), destfile = paste0("data/",x[i]), method = "auto")
          unzip(paste0("data/",x[i]), exdir="data_tiff")
          file.remove(paste0("data/",x[i]))
      } 


} 



