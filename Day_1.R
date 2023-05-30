library(icesTAF)
library(stockassessment)
library(cat3advice)
library(tidyverse)

#day_1
#https://github.com/ices-taf/doc/wiki/Example-datasets-1
taf.skeleton()

icesTAF::dir.tree() #to see what is going on in the folder

data("trees")#example data from R
trees

draft.data( #used to document data. needs to be documented for TAF
  data.files = "trees.csv",
  data.scripts = NULL,
  originator = "Ryan, T. A., Joiner, B. L. and Ryan, B. F. (1976) The Minitab Student Handbook. Duxbury Press.",
  title = "Diameter, Height and Volume for Black Cherry Trees",
  file = TRUE,
  append = FALSE # create a new DATA.bib
) #created DATA.bib  in the boot folder

taf.bootstrap() #run my through my data.bib and get all the data in there
# created an empty data folder in boot folder

write.taf(trees, dir = "boot/initial/data") #helper function
taf.bootstrap() #copy data into boot/data folder 
#both boot/initial/data and boot/data are needed, because Data.bib needs them to be documented


#add a local collection of data files
data(trees)
data(cars)

# make the directory we want to write to
mkdir("boot/initial/data/my-collection")
# save files there
write.taf(trees, dir = "boot/initial/data/my-collection")
write.taf(cars, dir = "boot/initial/data/my-collection")  #boot/intial/data --> created "my collection" folder

#draft.data(file  = TRUE)
#draft.data(originator = c("ICES", "WGEF"))

draft.data(
  data.files = "my-collection",
  data.scripts = NULL,
  originator = "R datasets package",
  title = "Collection of R data",
  source = "folder",
  file = TRUE,
  append = TRUE # add on to existing DATA.bib
)

taf.boot() #copy data to other data folder


#add file from URL
draft.data(
  data.files = "HadSST.4.0.1.0_median.nc",
  data.scripts = NULL,
  originator = "UK MET office",
  title = "Met Office Hadley Centre observations datasets",
  year = 2022,
  source = "https://www.metoffice.gov.uk/hadobs/hadsst4/data/netcdf/HadSST.4.0.1.0_median.nc",
  file = TRUE,
  append = TRUE
)

taf.boot() #copy data to other data folder

#-------- von Helene

# This is needed in case the data downloaded is not directly ready for saving it in data (e.g. ZIP files)
# ```{r}
cat('library(icesTAF)
library(sf)

download(
  "https://gis.ices.dk/shapefiles/OSPAR_Subregions.zip"
)

unzip("OSPAR_Subregions.zip")
unlink("OSPAR_Subregions.zip")

areas <- st_read("OSPAR_subregions_20160418_3857.shp")

# write as csv
st_write(
  areas, "ospar-areas.csv",
  layer_options = "GEOMETRY=AS_WKT"
)

unlink(dir(pattern = "OSPAR_subregions_20160418_3857"))
',
file = "boot/ospar-areas.R"
)
#```

#This creates a new script in the boot folder, whithin this script it is specified where to download the data and how to handle it. 
#The last part of the download link is assumed to be the file name of the data. 

# ```{r}
# load it into the DATA.bib file
draft.data(
  data.files = NULL,
  data.scripts = "ospar-areas.R",
  originator = "OSPAR",
  title = "OSPAR areas",
  file = TRUE,
  append = TRUE
)
taf.boot()
#```

# To check if everything is correctly in place run `r taf.boot(taf = TRUE)`. Now we see also a bigger difference between boot/data and boot/initial/data. 
# 
# Bib files can also be used in Markdowns as reference files. 
# 
# Another example with a package that downloads data:
  #```{r}
# save this into a R script named sd.R
# library(icesSD)
# 
# sd <- getSD(year = 2022)
# write.taf(sd, quote = TRUE)

#manually add entry to DATA.bib with : 
# @Misc{sd,
#   originator = {},
#   year       = {2023},
#   title      = {},
#   period     = {},
#   access     = {Public},
#   source     = {script},
# }

taf.boot()





