# exeçoes de produtos

library(DBI)
library(tidyverse)
library(lubridate)
library(googlesheets4)
con2 <- dbConnect(odbc::odbc(), "reproreplica",encoding = "latin1")

linhas_ativas <-
dbGetQuery(con2,"SELECT PROCODIGO,PRODESCRICAO,
           TPLCODIGO FROM PRODU WHERE
           GR1CODIGO<>17 AND PROSITUACAO='A'
                 AND PRODESCRICAO LIKE '%XR%'") %>% 
  mutate(PROCODIGO=str_trim(PROCODIGO))
  
  
col_ativos2 <-
  dbGetQuery(con2,"SELECT PROCODIGO,PRODESCRICAO,
           TPLCODIGO FROM PRODU WHERE
           GR1CODIGO<>17 AND PROSITUACAO='A'
                 AND PRODESCRICAO LIKE '%COLOR%' AND PROTIPO IN ('C','X')") %>%
  mutate(PROCODIGO=str_trim(PROCODIGO))


crossjoin <-
merge(linhas_ativas,col_ativos2,by=NULL) 
  
  
  write.csv2(crossjoin,row.names=FALSE,na="",file ="C:\\Users\\Repro\\Documents\\PRODUTOS\\2023\\AGO\\col2.csv")

  

tplpro <- 
dbGetQuery(con2,"
  WITH PROD AS (SELECT PROCODIGO PROCODIGO_LINHA,PRODESCRICAO,TPLCODIGO FROM PRODU WHERE PROSITUACAO='A' AND PRODESCRICAO LIKE '%XR%'),
  
  PROD2 AS (SELECT PROCODIGO ,PRODESCRICAO PRODESCRICAO_SERV FROM PRODU WHERE PROSITUACAO='A')
  
  SELECT T.PROCODIGO,PRODESCRICAO_SERV,PROCODIGO_LINHA,PRODESCRICAO,T.TPLCODIGO FROM TPLPRO T
             INNER JOIN PROD P ON P.TPLCODIGO=T.TPLCODIGO
             LEFT JOIN PROD2 P2 ON P2.PROCODIGO=T.PROCODIGO
           ") %>% mutate(PROCODIGO=str_trim(PROCODIGO)) %>% mutate(PROCODIGO_LINHA=str_trim(PROCODIGO_LINHA))
  View(tplpro )


write.csv2(tplpro,row.names=FALSE,na="",file ="C:\\Users\\Repro\\Documents\\PRODUTOS\\2023\\SET\\tplpro.csv")


dbGetQuery(con2,"SELECT PROCODIGO,TPLCODIGO FROM PRODU WHERE PROCODIGO='LP0182' ") %>% View()



dbGetQuery(con2,"SELECT PROCODIGO,TPLCODIGO FROM PRODU WHERE PROCODIGO LIKE '%100%' ") %>% View()

tlppro_xr <-
inner_join(tplpro,linhas_ativas,by="TPLCODIGO") %>% filter(str_detect(PROCODIGO.x,"100")) %>% select(TPLCODIGO,PROCODIGO.x) %>% rename(PROCODIGO=2)

anti_join(linhas_ativas,
inner_join(tplpro %>% filter(str_detect(PROCODIGO,"COLEXT ")),linhas_ativas,by=c("TPLCODIGO")),by="TPLCODIGO") %>% View()




@#CHARACTER#PRODUTOS@

excecao <- dbGetQuery(con2,"
           SELECT DISTINCT T.TPLCODIGO LINHA,T.PROCODIGO,PRODESCRICAO FROM TPLPRO T
          INNER JOIN (SELECT PROCODIGO,PRODESCRICAO,TPLCODIGO FROM PRODU
          
          ) A ON T.PROCODIGO=A.PROCODIGO") 


range_write("1zNDds9P36i3PMUSCQ6BNyhT06mXfZ48NMnkfsf6iKJQ",data=excecao,sheet = "DADOS",
            range = "A1",reformat = FALSE) 

dbGetQuery(con2,"SELECT * FROM TPLCLI WHERE CLICODIGO=151 ") %>% View()






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


excecao <- dbGetQuery(con2,"SELECT * FROM TPLPRO WHERE PROCODIGO='MOEST'") 

View(excecao)

left_join(produto,excecao,by="TPLCODIGO") %>% View()

insert_excecao <- left_join(produto %>% filter(!str_detect(PROCODIGO,'MF')),excecao,by="TPLCODIGO") %>%  
  filter(is.na(PROCODIGO.y)) %>%  select(TPLCODIGO) %>% mutate(PROCODIGO='COLEXT')


e <- data.frame(TPLCODIGO=NA,PROCODIGO=NA)


for (i in 1:nrow(insert_excecao)) {
  e[i,] <- insert_excecao[i,]
  query7 <- paste("INSERT INTO TPLPRO (TPLCODIGO,PROCODIGO) VALUES (",e[i,"TPLCODIGO"],",'",e[i,"PROCODIGO"],"');", sep = "")
  dbSendQuery(con3,query7)
  
}


query1 <- paste("DELETE FROM TPLPRO WHERE TPLCODIGO=2377 AND PROCODIGO='CODC2UVT'")
dbSendQuery(con3,query1)




query8 <- paste("DELETE FROM PRODUEXCPRODU WHERE PROCODIGO='COCAM' AND PROCODIGOEXC='TRFAS'")
dbSendQuery(con3,query8)



