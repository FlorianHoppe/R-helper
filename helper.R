####
#### helper.R
####
#### (c) Florian Hoppe 2013

# source('/Users/florianhoppe/Documents/SkyDrive/Coding/R/helper/helper.R')

plotHeatMap <- function(data,rows="all",cols="all") {
	# Shows a heat map of the data for a given selection of rows and columns
	#
	# Args:
	#   data: a data frame
	#   rows: a vector of rows to show (e.g. 50:100) or "all" to take all of the data frame
	#   cols: a vector of columns to show or "all" to take all of the data frame
	#	
	# Returns:
	#   Nothing
	
	if (!rows) {
		rows <- 1:nrow(data)
	}
	if (!cols) {
		cols <- 1:ncol(data)
	}
	mat <- as.matrix(data[rows,cols])
	mat <- t(mat)[,nrow(mat):1]
	image(cols,rows,mat)
}

describeDataFrame <- function(data) {
	data.frame(idx=1:length(names(data)),type=sapply(data[1,],function(x)class(x)))
}

countNAinDataframe <- function(data) {
	sapply(data, function(x)sum(is.na(x)))
}

myplclust <- function( hclust, lab=hclust$labels, lab.col=rep(1,length(hclust$labels)), hang=0.1,...) {
	## modifiction of plclust for plotting hclust objects *in colour*!
	## Copyright Eva KF Chan 2009
	
	## Arguments:
	## hclust:
	## lab: hclust object
	## lab.col: a character vector of labels of the leaves of the tree colour for the labels; NA=default device foreground colour
	## hang: as in hclust & plclust
	## Side effect:
	## A display of hierarchical cluster with coloured leaf labels.
	
	y <- rep(hclust$height,2); x <- as.numeric(hclust$merge)



	y <- y[which(x<0)]; x <- x[which(x<0)]; x <- abs(x)
	y <- y[order(x)]; x <- x[order(x)]
	plot( hclust, labels=FALSE, hang=hang, ... )
	text( x=x, y=y[hclust$order]-(max(hclust$height)*hang),
		labels=lab[hclust$order], col=lab.col[hclust$order],
		srt=90, adj=c(1,0.5), xpd=NA, ... )
}