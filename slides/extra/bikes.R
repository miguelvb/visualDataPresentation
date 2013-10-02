library('devtools')
dev_mode()
library(ggplot2)
library(proto)
#if your map data is a shapefile use maptools
library(maptools)
gpclibPermit()
#create GeomSegment2 function

GeomSegment2 <- proto(ggplot2:::GeomSegment, {
  objname <- "geom_segment2"
  
  
  draw <- function(., data, scales, coordinates, arrow=NULL, ...) {
    if (is.linear(coordinates)) {
      return(with(coord_transform(coordinates, data, scales),
                  
                  segmentsGrob(x, y, xend, yend, default.units="native",
                               gp = gpar(col=alpha(colour, alpha), lwd=size * .pt,
                                         lty=linetype, lineend = "round"),
                               arrow = arrow)
      ))
    }
  }})

geom_segment2 <- function(mapping = NULL, data = NULL, stat =
                            "identity", position = "identity", arrow = NULL, ...)  {
  GeomSegment2$new(mapping = mapping, data = data, stat = stat,
                   position = position, arrow = arrow, ...)
}



#load data stlat/stlong are the start points elat/elong are the end points of the lines
#lon
names(lon)<-c('stlat', 'stlon'', 'elat'', 'elong', 'count')
#load spatial data. You need to fortify if loaded as a shapefile
#water built
#This step removes the axes labels etc when called in the plot. #xquiet 
yquiet<-scale_y_continuous("", breaks=NA)
quiet<-list(xquiet, yquiet)
#create base plot plon1
#ready the plot layers
pbuilt<-c(geom_polygon(data=built, aes(x=long, y=lat, group=group), colour= '#4B4B4B', fill='#4F4F4F', lwd=0.2))
            pwater<-c(geom_polygon(data=water, aes(x=long, y=lat, group=group), colour= '#708090', fill='#708090'))
#create plot
plon2
plon2