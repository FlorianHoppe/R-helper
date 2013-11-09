####
#### basics.R
####
#### (c) Florian Hoppe 2013

### working with the console and basics I/O

getwd()
setwd("/some/dir")
dir()
list.files("some/dir")

download.file("https://example.com/remote.csv",destfile="local.csv",method="curl")
d <- read.table("test.csv")
d <- read.table("test.csv",sep=",",header=TRUE)
head(d) # shows first few lines/rows
d <- read.csv(file.choose()) # pick file manually

library(xlsx)
d <- read.xlsx2("test.xlsx",sheetIndex=1)

connection <- file("test.csv","r")
connection <- url("http://example.com/test.csv","r")
d <- read.csv(connection)
d <- readLines(connection)
close(connection)

### Matrices, lists and dataframes:

> m <- matrix(1:6,2,3)
> m
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
> m[1,2]
[1] 3
> m[1,2,drop=FALSE]  # keeps result being a matrix rather an array
     [,1]
[1,]    3
> x <- list(element1 = 1:4, element2 = 5.)
> x
$element1
[1] 1 2 3 4

$element2
[1] 5

> x[1]
$element1
[1] 1 2 3 4

> x$element1
[1] 1 2 3 4
> x[[1]]
[1] 1 2 3 4
> x[["element1"]]
[1] 1 2 3 4

> x[c(2,1)]
$element2
[1] 5

$element1
[1] 1 2 3 4

# access values using an index stored in a variable:
> idx <- "element1"
> x[[idx]]
[1] 1 2 3 4

## I/O

data <- read.csv("test.csv")

### handling NA values:
> x <- c(1,2,NA,4)
> bad <- is.na(x)
> x[!bad]
[1] 1 2 4
> tabel <- data.frame(A=c(1,2,NA),B=c(1,NA,3))
> table <- data.frame(A=c(1,2,NA),B=c(1,NA,3))
> table
   A  B
1  1  1
2  2 NA
3 NA  3
> good <- complete.cases(table)
> good
[1]  TRUE FALSE FALSE
> table[good,]
  A B
1 1 1




d2 <- read.csv("ss06pid.csv")
dim(dataq3)
names(dataq3)

cleanq3 <- dataq3[!is.na(dataq3$RMS) & !is.na(dataq3$BDS),]
cleanq3 <- dataq3[!is.na(dataq3$AGS) & !is.na(dataq3$ACR),c('AGS','ACR')]

dim(cleanq3[cleanq3$BDS==2 & cleanq3$RMS==5,])

which(dataq3$AGS==6 & dataq3$ACR==3)
table(is.na(cleanq3$MRGX))
