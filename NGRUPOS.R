library(DBI)
library(tidyverse)
library(lubridate)
library(googlesheets4)
library(xlsx)
con2 <- dbConnect(odbc::odbc(), "reproreplica")


ngrupos <- dbGetQuery(con2,"SELECT  N.PROCODIGO,GRCODIGO FROM NGRUPOS N
            INNER JOIN (SELECT PROCODIGO,PRODESCRICAO FROM PRODU)A ON A.PROCODIGO=N.PROCODIGO")

dbGetQuery(con2,"SELECT * FROM GRUPOROTULOS") %>% View()


NGRUPOS_MARCA_CLIENTE %>% rename(PROCODIGO=PRODUTO_CODIGO)

NGRUPOS_MARCA_CLIENTE2 <- anti_join(NGRUPOS_MARCA_CLIENTE %>% rename(PROCODIGO=PRODUTO_CODIGO) %>% 
            mutate(PROCODIGO=trimws(PROCODIGO)),ngrupos %>% filter(GRCODIGO==162) %>% 
            mutate(PROCODIGO=trimws(PROCODIGO)),by="PROCODIGO")

ngrupos %>% filter(GRCODIGO==162) %>% 
  mutate(PROCODIGO=trimws(PROCODIGO)) %>% nrow()

write.xlsx2(NGRUPOS_MARCA_CLIENTE2,file = "C:/Users/Repro/Documents/R/ADM/PRODUTOS/BASES/NGRUPOS_MARCA_CLIENTE2.xlsx")

