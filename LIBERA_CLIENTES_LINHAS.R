library(DBI)
library(tidyverse)
library(lubridate)
library(DBI)
con3 <- dbConnect(odbc::odbc(), "repro_prod", timeout = 10)




dbGetQuery(con2,"SELECT * FROM TPLCLI WHERE CLICODIGO=3372") %>% View()

query2 <- paste("DELETE FROM TPLCLI WHERE CLICODIGO=3372")
dbSendQuery(con3,query2)




linha <- dbGetQuery(con2,"SELECT PROCODIGO,PRODESCRICAO,TPLCODIGO FROM PRODU WHERE MARCODIGO=189
                           AND TPLCODIGO IS NOT NULL") %>% 
  mutate(PROCODIGO=trimws(PROCODIGO))

tpcli <- cbind(linha %>% select(TPLCODIGO),CLICODIGO=3372) %>% distinct(TPLCODIGO,CLICODIGO) 


x <- data.frame(TPLCODIGO=NA,CLICODIGO=NA)


for (i in 1:nrow(tpcli)) {
  x[i,] <- tpcli[i,]
  query1 <- paste("INSERT INTO TPLCLI (TPLCODIGO,CLICODIGO) VALUES (",x[i,"TPLCODIGO"],",",x[i,"CLICODIGO"],");", sep = "")
  dbSendQuery(con3,query1)
}

