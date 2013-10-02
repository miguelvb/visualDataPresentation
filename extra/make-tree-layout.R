

#sdata <- datascreening[ sample(1:nrow(datascreening),1e5),]
sdata <- datascreening[1:5e5,]
sdata[1:1,]

lev <- sapply(sdata[1,], levels)
str(lev)

lev$registry

library(rjson)
library(LargeData)
lev$screening_region2007

l.r2007  <- qn(Hovedstaden, Sjelland, Syddanmark, Midtjylland, Nordjylland)

lev$screening_region
#[1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p"

l.regions <-qn( CPH_M, FRB_M, CPH_A, FRB_A, Roskilde_A, Vestsjelland_A, Storstrom_A, Bornholm_A, Fyn_A, Sonderjylland_A, Ribe_A, Vejle_A, Ringkobing_A, Arhus_A, Viborg_A, Nordjylland_A) 

lev$diagnoseklasse

#[1] "a" "A" "c" "C" "d" "g" "O" "X" "1" "2" "3" "b" "B" "f" "F" "h" "J" "M" "N" "Q" "V" "W"

#a=HSIL or worse, A: squamous cell cancer,c=normal,C=cervical cancer NOS,  d=inadequate, g=indirect normal,  O=normal,X=missing,
#1=HPV test, no diagnosis, 2=HPV negative, 3=HPV positive, b=LSIL, B=adeconarcinoma,  f=ASCUS, F=carcinoma in situ, h=ASC-h or AGC, J=CIN3, M=CIN2, N=CIN1, Q= ??
# V=atypia , W=CIN NOS

l.diag <- qn( HSIL_or_worse, squamous_cell_cancer,normal,cervical_cancer_NOS, inadequate, indirect_normal,  normal,missing,
HPV_test_no_diagnosis,HPV_negative, HPV_positive, LSIL, adeconarcinoma,  ASCUS, carcinoma_in_situ, ASC_h_or_AGC, CIN3, CIN2, CIN1, XXXX, atypia , CIN_NOS)

soo = c( 1, 2, 9, 0) 
l.soo =  qn(cytology,histology, HPV_test, not_relevant)
treat <- c(1,2,3,4,5,7,8,10)
l.treat =  qn(hysterectomy,conization, destructive_cryotherapy, excision, other_treatment, biopsy , smear , colposcopy)

sdata$screening_region <- factor(sdata$screening_region, levels = lev$screening_region, labels = l.regions )
sdata$screening_region2007 <- factor(sdata$screening_region2007, levels = lev$screening_region2007, labels = l.r2007 )

sdata$soort <- factor(sdata$soort, levels = soo, labels = l.soo )
levels(sdata$soort)
#levels

sdata$treatment <-  factor(sdata$treatment, levels = treat, labels = l.treat )
levels(sdata$treatment)

#l.diag
sdata$diagnoseklasse <-  factor(sdata$diagnoseklasse, levels = lev$diagnoseklasse,  labels = l.diag )
levels(sdata$diagnoseklasse)
#sdata[1:20,]

prim <- qn( not_relevant, primary_test, follow_up_secondary_test ) 
sdata$primair_secundair <-  factor(sdata$primair_secundair )
sdata
sdata$primair_secundair <-  factor(sdata$primair_secundair,labels = prim )

setwd(dir)
save(sdata, file="./data/sdata")

str(sdata)

## make from it the json object: 

jdata <- fromJSON(file = "./data/flare.json")
jdata

# make Jsonssss : : 

## this will make a list of name: "..." , from a vector. Ready for Json.. 

m.l <- function(x){ 
  d <- as.list(x)
  d <- lapply(d,function(x) list(name = x, size = 10))
  d
} 




str(sdata)


diagnoses.child  <- m.l(levels(sdata$diagnoseklasse))
institut.child  <- m.l (levels(sdata$institut))
soort.child <- m.l(levels(sdata$soort))
screening_region.child <-  m.l(levels(sdata$screening_region))
screening_region2007.child <-  m.l(levels(sdata$screening_region2007))
treatment.child <- m.l(levels(sdata$treatment))
primair_secundair.child <-  m.l(levels(sdata$treatment))


ident_ID <- list( name="ident_ID", size = 10)
lpr <- list( name="lpr", size = 10)
ident <- list( name="ident", size = 10)
ssy <- list( name="ssy", size = 10)
creg <- list( name="creg", size = 10)
sgh <-list( name="sgh", size = 10)
afd<- list( name="afd", size = 10)
pattype <-  list( name="pattype", size = 10)
hpv <- list( name="hpv", size = 10)
age <-  list( name="age", size = 10)
hoogste_diagnose <-  list( name="hoogste_diagnose", size = 10)
dateofonderzoek <-  list( name="dateofonderzoek", size = 10)


dateofbirth <- list( name="dateofbirth", size = 10)
cit_from <- list( name="cit_from", size = 10)
cit_to <- list( name="cit_to", size = 10)
screening_region <- list( name="screening_region", children = screening_region.child, size = 10)
screening_region2007 <- list( name="screening_region2007", children = screening_region2007.child, size = 10)
institut <- list(name="institut", children = institut.child, size = 10)
soort <- list(name= "soort", children = soort.child, size = 10)
treatment <- list(name= "treatment", children = treatment.child, size = 10)
primair_secundair <- list(name= "primair_secundair", children =primair_secundair.child, size = 10)
diagnoseklasse  <- list(name= "diagnoseklasse", children =diagnoses.child, size = 10)
diagnoseklasse_treatment <- diagnoseklasse 

cpr.child <- list(ident_ID, ident, dateofbirth, cit_from,  cit_to, screening_region, screening_region2007)

cpr <- list(name="cpr", children = cpr.child , size = 10)

registry <-list(name="registry",children= list(lpr,ssy,creg), size = 20)




diagnoses <- list( name = "diagnoses" , children = list(ident_ID,
                  registry, 
                  dateofonderzoek, 
                  diagnoseklasse, soort,institut,treatment, sgh, 
                  afd, pattype,
                  hpv,diagnoseklasse_treatment,
                  age,primair_secundair,hoogste_diagnose
                  ) ,  size = 20)
) 


data.json <- list(name="data", children = list(cpr,diagnoses), size = 100)
data.json

save(data.json, file = "./data/datajson")

sink("./data/data_new.json")
cat(toJSON(data.json))
#close our file
sink(file=NULL)






