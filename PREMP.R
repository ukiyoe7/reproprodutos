## TABELA DE PREÇOS 
## SANDRO JAKOSKA

library(DBI)
library(tidyverse)
library(lubridate)
library(googlesheets4)
con2 <- dbConnect(odbc::odbc(), "reproreplica")


dbGetQuery(con2,"
SELECT PROCODIGO, PREPCOVENFUT,PREPCOVENFUT2,PREPCOVENDA,PREPCOVENDA2 FROM PREMP WHERE EMPCODIGO=1
 AND PREPCOVENFUT2 IS NOT NULL

           ") %>% View()
