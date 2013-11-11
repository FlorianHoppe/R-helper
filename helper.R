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