library(DBI)
library(tidyverse)
library(lubridate)
library(DBI)
con3 <- dbConnect(odbc::odbc(), "repro_prod", timeout = 10)
con2 <- dbConnect(odbc::odbc(), "reproreplica")




prod <- dbGetQuery(con2,"SELECT PROCODIGO,PRODESCRICAO,PROCODIGO2,PROTIPO,MARCODIGO FROM PRODU WHERE PROSITUACAO='A'") 

View(prod)




prod <- dbGetQuery(con2,"SELECT PROCODIGO,PRODESCRICAO,PROTRVVENDA,PROINTERNET,TPLCODIGO FROM PRODU WHERE MARCODIGO=189") 

View(prod)


tplente <- dbGetQuery(con2,"
WITH PROD AS (SELECT PROCODIGO,PRODESCRICAO,TPLCODIGO FROM PRODU WHERE MARCODIGO=189)


SELECT PROCODIGO,PRODESCRICAO,TPLINTERNET,TPLTRVVENDA FROM 
                   TPLENTE T
                      INNER JOIN PROD P ON T.TPLCODIGO=P.TPLCODIGO
                      ") 

View(tplente)




dbGetQuery(con2,"select rdb$relation_name,rdb$field_name from rdb$relation_fields where rdb$field_name='PROCOMPLE'") %>% View()

write_sheet(data =
dbGetQuery(con2,"SELECT PROCODIGO,PROCOMPLE,TRVVENDA FROM PRODU WHERE PROSITUACAO='A' AND PROCOMPLE IS NOT NULL") 
,"1Q1spUSP_gouvQQAJygCK-wV5itvHOiWmgrYj-6RcU0w",sheet = "DADOS")