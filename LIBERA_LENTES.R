library(tidyverse)
library(lubridate)
library(DBI)
con2 <- dbConnect(odbc::odbc(), "reproreplica", timeout = 10)
con3 <- dbConnect(odbc::odbc(), "repro_prod", timeout = 10)


dbGetQuery(con2,"SELECT FIRST 1 * FROM TPLENTE WHERE TPLCODIGO= 4565") %>% View()

query12 <- paste("UPDATE TPLENTE SET TPLOBRIGATRATAMENTO='S' WHERE TPLCODIGO=4565 ")
dbSendQuery(con3,query12)




suglinhap <- dbGetQuery(con2,"SELECT * FROM SUGLINHAP") 

View(suglinhap)

suglinhaf <- dbGetQuery(con3,"SELECT * FROM SUGLINHAF") 

View(suglinhaf)

sugproser <- dbGetQuery(con2,"SELECT * FROM SUGPROSER") 

View(sugproser)

sugpro <- dbGetQuery(con2,"SELECT * FROM SUGPRO") 

View(sugpro)




dbGetQuery(con2,"SELECT * FROM SUGSER") %>% View()

