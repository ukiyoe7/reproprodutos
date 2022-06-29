# exeçoes de produtos

library(DBI)
library(tidyverse)
library(lubridate)
library(googlesheets4)
con2 <- dbConnect(odbc::odbc(), "reproreplica")


tpdbGetQuery(con2,"SELECT * FROM TPLPRO WHERE PROCODIGO='TRHCT2'") 

dbGetQuery(con2,"SELECT * FROM TPLPRO WHERE TPLCODIGO=4418") %>% View()

dbGetQuery(con2,"SELECT PROCODIGO,TPLCODIGO FROM PRODU WHERE  ") %>% View()


## VERIFICA LINHAS COM EXCEÇOES


produto <- dbGetQuery(con2,"
           
           SELECT PD.PROCODIGO,
                       PRODESCRICAO,
                         GR1CODIGO,
                          TPLCODIGO,
                           PROTIPO
           FROM PRODU PD
           WHERE GR1CODIGO<>17 AND PROSITUACAO='A'
           AND PRODESCRICAO LIKE '%ESPACE%'
           AND PROCODIGO2 IS NULL
           ") 

View(produto)


excecao <- dbGetQuery(con2,"SELECT * FROM TPLPRO WHERE PROCODIGO='COLEXT'") 

left_join(produto,excecao,by="TPLCODIGO") %>% View()

insert_excecao <- left_join(produto %>% filter(!str_detect(PROCODIGO,'MF')),excecao,by="TPLCODIGO") %>%  
  filter(is.na(PROCODIGO.y)) %>%  select(TPLCODIGO) %>% mutate(PROCODIGO='COLEXT')


e <- data.frame(TPLCODIGO=NA,PROCODIGO=NA)


for (i in 1:nrow(insert_excecao)) {
  e[i,] <- insert_excecao[i,]
  query7 <- paste("INSERT INTO TPLPRO (TPLCODIGO,PROCODIGO) VALUES (",e[i,"TPLCODIGO"],",'",e[i,"PROCODIGO"],"');", sep = "")
  dbSendQuery(con3,query7)
  
}


query1 <- paste("DELETE FROM TPLPRO WHERE TPLCODIGO=3724 AND PROCODIGO='TRHCT'")
dbSendQuery(con3,query1)

