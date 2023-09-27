

PRFPROD <- dbGetQuery(con2,"SELECT * FROM PRFPROD")


PRFPROD_wd <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PRODUTOS\\BASES\\PRFPROD","_",format(Sys.Date(),"%d_%m_%y"),".csv")

write.csv2(PRFPROD, file = PRFPROD_wd, row.names=FALSE)


PRODEMPPZENT <- dbGetQuery(con2,"SELECT * FROM PRODEMPPZENT")


PRODEMPPZENT_wd <-  paste0("G:\\Meu Drive\\BACKUPS\\PRODEMPPZENT","_",format(Sys.Date(),"%d_%m_%y"),".csv")

write.csv2(PRODEMPPZENT, file = PRODEMPPZENT_wd, row.names=FALSE)