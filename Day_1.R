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

taf.boot()#copy data to other data folder


