GWL_data = function (x)
{ 
download(x,'henk.zip', mode = "wb")
unzip("henk.zip")
unlink("henk.zip")
} 