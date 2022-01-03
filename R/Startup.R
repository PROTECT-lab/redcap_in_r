### CHANGE `boxdir` to your path
### CHANGE TO YOUR TOKEN FROM REDCAP
startup<-function(mode="boxsync",boxdir="C:/Users/dellme/Box/PROTECT Box/data",load=F,protocol.s="protect", loadbsrc=T) {
  require("devtools") 
  devtools::install_github("PROTECT-lab/redcap_in_r",force = T)
  library(bsrc)
  input.uri<<-'https://www.ctsiredcap.pitt.edu/redcap/api/'
  rdpaths<<-list(masterdemo=file.path(boxdir,"RedCap Data","MasterDemo","Redcap.masterdemo.rdata"),
                 protect=file.path(boxdir,"RedCap Data","Protect","Redcap.protect.rdata"))
  ptc<-list(
    masterdemo=list(name="masterdemo",
                    redcap_uri=input.uri,
                    token='C4EA6928F644AD7D9FBF734B15EA77E6',
                    rdpath=rdpaths$masterdemo,
                    forcenewsubinsync=TRUE,
                    regiformname="record_registration"),
    protect=list(name="protect",
                 redcap_uri=input.uri,
                 token='DC78B49AB274E82FE0CD264D93B26C56',
                 rdpath=rdpaths$protect,
                 forcenewsubinsync=TRUE,
                 regiformname="record_registration")
  )
  message("Loading switcher profile...")
  ptcs<<-lapply(ptc,function(x) {do.call(bsrc.switcher,x)})
  protocol.cur<<-do.call(bsrc.switcher,ptc[[protocol.s]])
  message("DONE")
}

library("tidyverse")
startup()
md <- bsrc.checkdatabase2(ptcs$masterdemo, batch_size = 500L, online = T)
# select three different types of ID we need
idmap <- md$data %>% select(masterdemoid = registration_redcapid, wpicid = registration_wpicid, soloffid = registration_soloffid)
# pull Protect 3 data 
pt <- bsrc.checkdatabase2(ptcs$protect, batch_size = 500L, online = T)


