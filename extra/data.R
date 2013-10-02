library(slidify)

slidify("index_io2012.Rmd")


require(ffbase)
gc() #   memory
Ndata = 2e6;  # number of observations. 20 million in this example. 
N_ids = Ndata/10 # number of unique idents. 
ident = factor( sample( 1000:(N_ids+1000), Ndata, replace = T)) # make ident as a sample from 1000 to 20 001 000
df <- ffdf( ident = ff(ident))  # create a ffdf database with a column ff( vector). This is written into disk. 
rm(ident) 
fdates <- ff(sample( 0:10000, Ndata, replace = T) + as.Date("1970-10-01"))
df$date <- fdates  # here we assign that vector to df.... if we change fdates, we will change df$date. This is diff from R. 
fdiagnose <- ff(sample( factor(letters), Ndata, replace = T )) # this is ok, factors... 
df$diagnose <- fdiagnose
fregion = ff( factor( sample( c("000","013" ,"014", "015", "020" ,"025", "030", "035" ,"040", "042", "050" ,"055" ,"060" ,"065" ,"070" ,"076", "080", "090"), Ndata, replace=T )) ) 
df$region <- fregion

str(df[1,])

fbirth <- ff(sample( 0:40000, Ndata, replace = T) + as.Date("1970-10-01"))
df$birth <- fbirth
getwd()

dir.create("./data")
ffdfsave(df, file = "./data/df")

library(LargeData)

data <- data.table(df[,], key = "date")

data[, date := ifelse(date < birth, birth + sample(0:(365*40),1), date)]

data[, cit_from := birth + sample(0:(365*20),1)]
data[, date := asDate(date)]
data[1:2]
save(data, file = "./data/data")

require(rCharts)

data[ , ymonth := substr(as.character(cit_from),0,7)]
data[ , ymonth := paste(ymonth,"-00",sep="")]
data[ , ymonth := paste(ymonth,"-00",sep="")]

save(data, file = "./data/data")

### heat map month year ### 

dir <- getwd()
dir_data<- "C:/Users/jkc261/Documents/Projects/TMPDATA/Registers2012/"
setwd(dir_data)
require(ffbase)
load("datascreening")

str(datascreening[1,])


dt <- table(data$month, data$year)
dt <- data.frame(dt)
names(dt) <- c("month", "year", "freq")
dt[1:2,]
c.scale <- scale_fill_gradient(low = "white", 
                               high = "steelblue",
                               limits=c(min(dt$freq),
                                        max(dt$freq)))

# apply the same scale to different plots
p1 <- ggplot(dt, aes(month, year)) + 
  geom_tile(aes(fill = freq), color="white") 

p2 <- p1 + c.scale

p2
#### 

data[1:2]
data[, datemill := as.integer(date)* 24*3600*1000]

tdate <- data[, .N,by=date][, ymill := as.integer(as.Date(d))*24*3600*1000]

n1 <- nPlot(
  N~datemill,
  data =tdate ,
  group = "id",  # even though only one series need to specify group
  type = "lineWithFocusChart"
)

a <- letters[1:3]
table(a, sample(a)) 

### no van los axis, no se porque?? 
n1$xAxis(
  tickFormat=
    "#!function(d) { return d3.time.format('%Y %b')(new Date( d )); }!#"
)

n1$x2Axis(
  tickFormat=
    "#!function(d) {return d3.time.format('%Y')(new Date( d ));}!#"
)

n1

# get 1e5 sampled data: 
sdata <- datascreening[sample(0:nrow(datascreening),1e5),]

sdata[1:30,]
