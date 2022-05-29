library(DBI)
library(tidyverse)
library(lubridate)
library(googlesheets4)
con2 <- dbConnect(odbc::odbc(), "reproreplica")


tpdbGetQuery(con2,"SELECT TPLCODIGO LINHAS FROM TPLPRO WHERE PROCODIGO='TRHCT2'") 

dbGetQuery(con2,"SELECT * FROM TPLENTE") %>% View()

dbGetQuery(con2,"SELECT PROCODIGO,TPLCODIGO FROM PRODU WHERE ") %>% View()
