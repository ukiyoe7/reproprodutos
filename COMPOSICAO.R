


## COMPOSIÇÃO
## SANDRO JAKOSKA

library(DBI)
library(tidyverse)

con2 <- dbConnect(odbc::odbc(), "reproreplica")



tb <- read.table(text = read_clip(), header = TRUE, sep = "\t") %>% mutate(PROCODIGO=str_trim(PROCODIGO))


compo <- dbGetQuery(con2,"SELECT * FROM 
                           COMPO
                    ") %>% View()


left_join(tb,compo %>%  mutate(PROCODIGO=str_trim(PROCODIGO)),by="PROCODIGO") %>% mutate(PROCODIGO=str_trim(PROCODIGO)) %>% View()


tplente <- dbGetQuery(con2,"SELECT * FROM 
                           TPLENTE
                    ") %>% View()