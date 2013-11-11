####
#### basics.R
####
#### (c) Florian Hoppe 2013

### working with the console and basics I/O

getwd()
setwd("/some/dir")
dir()
list.files("some/dir")

source("script.R") # loads R script

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
d <- fromJSON(connection)   # needs: library(RJSONIO)
close(connection)

write.table(d,file="out.csv",sep=",")
save(objA,objB,file="objs.bin")
save.image(file="all.bin") # saves everythings
load("all.bin")

ls() # show all variables
rm(objA) # remove variable
rm(list=ls()) # remove everything

install.packages("PackageName", repos = "http://cran.at.r-project.org")

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

## DataFrame manipulations

d$newCol <- c(1,2,3) # adds new column
names(d) <- c("COL1","COL2") # new names
as.data.frame(d,byrow=TRUE,nrow=3) # reshapes a data frame

merge(d1,d2,by="col") # inner join
merge(d1,d2,by="col",all=TRUE) # outer join
merge(d1,d2,by.x="c1",by.y="c2")

> sort(c("b","a","c",NA),na.last=TRUE,decreasing=TRUE) # returns array in a certain order
[1] "c" "b" "a" NA 
> order(c("b","a","c"))  # returns indices of elements in a certain order
[1] 2 1 3
sortedD <- d[order(d$col1,d$col2),] # orders data frame

# access values using an index stored in a variable:
> idx <- "element1"
> x[[idx]]
[1] 1 2 3 4

### Basic data checking

d <- read.csv("somedata.csv")
dim(d)
names(d)
nrow(d) # ==dim(d)[1]
ncol(d) # ==dim(d)[2]

> quantile(d$col)
    0% 25%   50%   75%   100%
-61.30 35.56 38.77 52.58 67.66

summary(d)
sapply(d[1,],class) # lists types of all columns of d
unique(d$col)
> d
  A    B
1 a    b
2 b    c
3 b <NA>
4 a    b
> table(d$A,useNA="always")  # kind of histogram for categorical columns
   a    b <NA> 
   2    2    0
> table(d$A,d$B)  # cross matrix
    b c
  a 2 0
  b 0 1


## Check for certain values
any(d$col>min) 
all(!is.na(d$col)) 

## Select certain rows and columns
d[!is.na(d$col1) & !is.na(d$col2),] # all columns where col1 and col2 are not NA
d[!is.na(d$col1) & !is.na(d$col2),c("col3","col4")] # only some columns

> d
  A    B
1 a    b
2 b    c
3 b <NA>
4 a    b
> which(d$A=="b")  # returns indices of requested elements 
[1] 2 3
> d[which(d$A=="b"),]  # selects those rows and columns
  A    B
2 b    c
3 b <NA>

## Simple calculations

> table
   A  B
1  1  1
2  2 NA
3 NA  3
> colSums(table)
 A  B 
NA NA 
> colSums(table,na.rm=TRUE)
A B 
3 4 

colMean(table)
rowSums(table)
rowMean(table)

cut(d$col,seq(0,100,25)) # assigns original values to bins defined by the given sequence
# cut2(d$col,g=6) # automatically creates 6 bins (needs library(Hmisc) but this does not work for me)

## Handling NA values:
> x <- c(1,2,NA,4)
> bad <- is.na(x)
> x[!bad]
[1] 1 2 4
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
> sum(is.na(table$A))  # how many NAs?
[1] 1
> table(is.na(table$A)) # the fancy way
FALSE  TRUE 
    2     1 

### String manipulations
> strsplit("a,b,c",",")
[[1]]
[1] "a" "b" "c"
> tolower("aBc")
[1] "abc"
> sub(";",",","a;b;c",ignore.case=TRUE)
[1] "a;b,c"
> gsub(";",",","a;b;c",ignore.case=TRUE)
[1] "a,b,c"


#### Statistics 

## to create samples of a certain distribution use the rDISTRIBUTION functions

# 10 samples of a normal distribution:
rnorm(10)  # == rnorm(10,mean=0,sd=1)  
# 10 samples of a binomial distribution:
rbinom(10,size=10,prob=0.5)

## to calculate the propability of a certain event of a certain distribution use the dDENSITY functions

dnorm(c(-.25,0,.25),mean=0,sd=1)
dbinom(0:5,prob=.5,size=5)

## to get always the same random values fixed the seet before calling functions that create "random" values:
set.seed(12345)

## resample a set of data

# returns 10 values randomly drawn from the given data set using unifore distribution
sample(data,size=10,replace=TRUE)

# or using a certain distribution
sample(1:5,size=10,replace=TRUE,prob=c(.5,.1,.1,.2,.1))

# creating a smooth density function from some data
density(rnorm(100,0,1))

#### Plotting

# basic functions
plot
abline(c(0,1)) # for a diagonal line
lines
points

# some sample data: 
d <- data.frame(A=rnorm(100,50,15),B=rnorm(100,75,30),C=sample(c(1,2),size=100,replace=TRUE,prob=c(.2,.8)))

# a box plot is good for understanding the distribution of a variable
boxplot(d$A)

# box plot to compare value distribution of column A differentiated by column C
# the width of the boxes correspondes to the number ClassA or ClassB occured in the data
boxplot(d$A ~ d$C,col=c("Blue","orange"),varwidth=TRUE)

# barplot and table() of a categorical variable yields a histogram
barplot(table(d$C))

# histrograms
hist(d$A,breaks=25,main="Title")

# density() helps to compare histograms data
plot(density(d$A))
lines(density(d$B))

# scatter plot with closed circles as markers, color code for categorical variable and size fairly small
plot(d$A,d$B,pch=19,col=d$C,cex=.5)

# if data points are too dense to understand, sampling helps:
x <- rnorm(1e5)
y <- rnorm(1e5)
sample.idx <- sample(1:1e5,1000)
plot(x[sample.idx],y[sample.idx])

# or a smooth scatter:
smoothScatter(x,y)

# or a hex bin plot:
library(hexbin)
plot(hexbin(x,y))

# to compare two distributions plot the quantiles of two data sets
# if the distributions match the shown points should lay on the diagonal axis
qqplot(d$A,d$B)
abline(c(0,1))

# to plot the data of a matrix columnwise i.e. each column will be one line in the plot:
X <- matrix(c(5*1:50,2*1:50),ncol=2)
matplot(X,type="b")

