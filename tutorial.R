rm(list=ls()) #reset
graphics.off()
ls() #check

#import and name data
pollution <- read.csv("C:/Users/camer/Downloads/Data_practical_Red_List/pollution/assessments.csv")
landuse <- read.csv("C:/Users/camer/Downloads/Data_practical_Red_List/landuse/assessments.csv")
overexploitation <- read.csv("C:/Users/camer/Downloads/Data_practical_Red_List/overexploitation/assessments.csv")
invasion <- read.csv("C:/Users/camer/Downloads/Data_practical_Red_List/invasion/assessments.csv")
climate <- read.csv("C:/Users/camer/Downloads/Data_practical_Red_List/climate/assessments.csv")

#check variable class
unlist(lapply(pollution, class))
str(pollution)

#check if duplicates
climate$scientificName
nrow(landuse)
length(unique(landuse$scientificName))

#remove duplicates
if(nrow(landuse) != length(unique(landuse$scientificName))){
  landuse <- landuse [-
  which(duplicated(landuse$scientificName)),]
}
if(nrow(pollution) != length(unique(pollution$scientificName))){
  pollution <- pollution [-
                        which(duplicated(pollution$scientificName)),]
}
if(nrow(invasion) != length(unique(invasion$scientificName))){
  invasion <- invasion [-
                        which(duplicated(invasion$scientificName)),]
}
if(nrow(overexploitation) != length(unique(overexploitation$scientificName))){
  overexploitation <- overexploitation [-
                        which(duplicated(overexploitation$scientificName)),]
}
if(nrow(climate) != length(unique(climate$scientificName))){
  climate <- climate [-
                        which(duplicated(climate$scientificName)),]
}

#indicate threat category
climate$climate <- 1
climate$invasion <- 0
climate$landuse <- 0
climate$overexploitation <- 0
climate$pollution <- 0

invasion$climate <- 0
invasion$invasion <- 1
invasion$landuse <- 0
invasion$overexploitation <- 0
invasion$pollution <- 0

landuse$climate <- 0
landuse$invasion <- 0
landuse$landuse <- 1
landuse$overexploitation <- 0
landuse$pollution <- 0

overexploitation$climate <- 0
overexploitation$invasion <- 0
overexploitation$landuse <- 0
overexploitation$overexploitation <- 1
overexploitation$pollution <- 0

pollution$climate <- 0
pollution$invasion <- 0
pollution$landuse <- 0
pollution$overexploitation <- 0
pollution$pollution <- 1

#make one data fram
threats.dat <- rbind(landuse, overexploitation, invasion, pollution, climate)

#check duplicates
length(unique(threats.dat$scientificName))
dim(threats.dat)

#merge duplicates
threats.dup <- which(duplicated(threats.dat$scientificName))
#check subset
threats.dat[threats.dup, 1:23]

library(dplyr)
#get unique rows
threats.redundant <- distinct(threats.dat[threats.dup, 1:23])

#use for loop to merge duplicate rows


#select rows that correspond w i in threats.redundant within this loop

#checks which rows/animals in threat.dat are the same as (==) threats.redundant

for(i in 1:nrow(threats.redundant)){
  row.number <-
  which(threats.dat$scientificName==threats.redundant$scientificName[i])
row.selected <- threats.dat[row.number,]
new.row <- 
  data.frame(c(row.selected[1, 1:23], colSums(row.selected[,24:28]))) 
threats.dat <- threats.dat[-row.number,]
threats.dat <- rbind(threats.dat,new.row) 
}
#colsums sums values in each columns
#summing columns 24-28, combines all rows
#check how it changes with each line of code
row.selected
new.row
threats.dat
dim(threats.dat)

if (!require(devtools)) install.packages("devtools")
devtools::install_github ("gaospecial/ggVennDiagram")
library("ggVennDiagram")

colSums(threats.dat[,24:28])
barplot(colSums(threats.dat[,24:28])) #zoom to see overexploitation


