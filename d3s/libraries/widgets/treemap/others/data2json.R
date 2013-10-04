
library(rjson)


flare <- fromJSON(file="./libraries/widgets/tree_map/flare.json")
flare
str(flare)
print(flare)

## canada data :: ####
CanadaPC <- list(
  name = "Canada",  
       children = list(
         
        list(name = "Newfoundland", 
                children = 
                  list(list(name = "St. John's"))
                ),
           
        list(name = "PEI",
                children = list(list(name = "Charlottetown"))
              ),
        list(name = "Nova Scotia",
                children = list(list(name = "Halifax"))
              ),
        list(name = "New Brunswick",
                children = list(list(name = "Fredericton"))
              ),
        list(name = "Quebec",
                 children = list(
                   list(name = "Montreal"),
                   list(name = "Quebec City"))
             ),
        list(name = "Ontario", 
                  children = list(
                    list(name = "Toronto"), 
                    list(name = "Ottawa"))
             ),
        list(name = "Manitoba",
                   children = list(list(name = "Winnipeg"))
             ),
     list(name = "Saskatchewan",
   children = list(list(name = "Regina"))),
     list(name = "Nunavuet",
   children = list(list(name = "Iqaluit"))),
     list(name = "NWT",
   children = list(list(name = "Yellowknife"))),
     list(name = "Alberta",
   children = list(list(name = "Edmonton"))),
     list(name = "British Columbia",
   children = list(list(name = "Victoria"),
    list(name = "Vancouver"))),
     list(name = "Yukon",
   children = list(list(name = "Whitehorse")))
    ))

str(CanadaPC)
###### 
fla <- readLines("./libraries/widgets/tree_map/flare.json")
fla

cat(file="flare.json")
file <- "flare.json"
cat0 <- function(file, ...) cat(..., sep="", file=file)
cat0a <- function(file, ...) cat(..., sep="", file=file, append=TRUE)

cat0(file, "{\n")
cat0a(file, "\"m\" : \n", toJSON(m), ",\n\n")
cat0a(file, "\"p\" : \n", toJSON(p), ",\n\n")
cat0a(file, "\"nll\" : \n", toJSON(nll), ",\n\n")
cat0a(file, "\"kll\" : \n", toJSON(kll), "\n\n")
cat0a(file, "}\n")


