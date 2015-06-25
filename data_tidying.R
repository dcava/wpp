#Init data and cleanup
raw <- read_excel("../../../Research/colorectal mets/Raw data/Lap vs Open - final data set.xlsx")

new <- raw %>% arrange(id_patients, opdate) %>% group_by(id_patients)

#Remove those with no survival values - there were no ontable deaths
new <- new %>% filter(os_value!=0.0)

#Let the primary data extend through all with multiple ops
new <- new %>% group_by(id_patients) %>% mutate(
  primaryresectiondate=first(primaryresectiondate),
  primarydiagnosisdate=first(primarydiagnosisdate),
  primaryT=first(primaryT),
  primaryN=first(primaryN),
  primaryM=first(primaryM),
  primarysite=first(primarysite),
  primaryprocedure=first(primaryprocedure),
  primarysynchronousliverdisease=first(primarysynchronousliverdisease),
  primarytreatment=first(primarytreatment),
  primarydiagnosisdate=first(primarydiagnosisdate),
  primarytumourgrade=first(primarytumourgrade))

#Fix some NA-zero issues, the NA surgery are all open - checked with surgeon
new$isnonanatomic <- NAToUnknown(new$isnonanatomic, 0)
new$surgicalapproach <- NAToUnknown(new$surgicalapproach, "")
new[new$surgicalapproach=="","surgicalapproach"] = "open"
new[new$surgicalapproach=="1", "surgicalapproach"] = "open"
new[is.na(new$isconversion), "islaparoscopicintent"] = 0
new[is.na(new$isconversion), "isconversion"] = 0

#fix the Card "non-operation"
new <- new %>% mutate(index=1:n())
new %<>% filter(!(surname=="Card"&index==2))

# Selected columns
new %<>% select(firstname,surname,liverprocs,opdate,surgicalapproach,surgeon,age,bloodloss,bpipre_total,bpipost_total,CEA,clinicalscenario,CRS_total,hlos,id_patients,isanatomic,isbilateral,isconversion,isextended,islaparoscopicintent,ismajor,lesioncount,lesionmaxdiameter,lesionseg1,lesionseg2,lesionseg3,lesionseg4,lesionseg5,lesionseg6,lesionseg7,lesionseg8,lesionstotalvolume,margin,oo,optime,os_outcome,os_value,pdfs_outcome,pdfs_value,previousliverresection,primarydiagnosisdate,primaryresectiondate,primaryT,primaryN,primaryM,primarysite,primaryprocedure,primarysynchronousliverdisease,primarytreatment,primarytumourgrade,extrahepaticdiseasesites,sex)


# Clarify status
new$status[new$oo=="no residual disease"] <- "nrd"
new$status[new$oo=="no evidence of disease"] <- "nrd"
new$status[new$oo=="evidence of disease"] <- "resdis"
new$status[new$oo=="resectable residual disease"] <- "resdis"
new$status[new$oo=="residual disease"] <- "resdis"
new$status[new$oo=="unresectable residual disease"] <- "unresect"
new$status[new$oo==""] <- NA
new$status <- as.factor(new$status)

#New variables
new %<>% mutate(rec_gap = pdfs_value)
new %<>% mutate(diff_ops = c(0, diff(opdate)))
new <- new %>% do(mutate(., rec_gap = ifelse(rec_gap > lead(diff_ops, 1, 0), lead(diff_ops), rec_gap)))
new <- new %>% do(mutate(., rec_gap = ifelse(is.na(rec_gap), pdfs_value, rec_gap)))
new <- new %>% mutate(cens_time = first(os_value))
new <- new %>% do(mutate(., rec_gap = ifelse(is.na(rec_gap), cens_time, rec_gap)))

new <- new %>% mutate(index=1:n())
new <- new %>% mutate(time = cumsum(diff_ops))
new <- new %>% mutate(rtime = time+rec_gap)
new <- new %>% mutate(lap = islaparoscopicintent)
new <- new %>% mutate(cens = os_outcome, rec = pdfs_outcome)
#new <- new %>% mutate(bins = ifelse(rank(index)<max(rank(index)),1,2))

new <- ungroup(new) %>% mutate(rec = ifelse(pdfs_value==os_value,0,rec))
new <- new %>% mutate(rec = ifelse(status=="resdis"|status=="unresect", 0, rec))

#new <- new %>% group_by(id_patients) %>% mutate(ctime = ifelse(index<max(index),rtime,cens_time))

#new %<>% mutate(cens_month = round(cens_time/365.25*12, digits = 1), pdfs_month = round(pdfs_value/365.25*12, digits = 1))


#fix sex
new$sex <- as.factor(new$sex)

#Factor tumour grade
new$primarytumourgrade <- as.factor(new$primarytumourgrade)

#Fix bpi's - if CEA, primarytumourgrade, primaryN is missing, not reliable

new$bpi <- new$bpipre_total
new$bpi[is.na(new$primaryN)] <- NA
new$bpi[is.na(new$primarytumourgrade)] <- NA
new$bpi[is.na(new$CEA)] <- NA

#correct the few data entry errors
new[new$id_patients==339,"status"] <- "nrd"
new[new$id_patients==339,"rec"] <- 0
new[new$id_patients==350,][2,"status"] <- "nrd"
new[new$id_patients==350,][2,"rec"] <- 0
new[new$id_patients==398,"status"] <- "nrd"
new[new$id_patients==398,"rec"] <- 0
new[new$id_patients==434,][1,"status"] <- "resdis"
new[new$id_patients==560,"status"] <- "nrd"
new[new$id_patients==560,"rec"] <- 0
new[new$id_patients==599,"status"] <- "nrd"
new[new$id_patients==599,"rec"] <- 0
new[new$id_patients==606,"status"] <- "nrd"
new[new$id_patients==606,"rec"] <- 0
new[new$id_patients==395,"rec"] <- 0
new[new$id_patients==434,"rec"] <- 1


# Filter out two stage resections
id_twostage = c(7,38, 41, 350, 415, 425, 517)
new %<>% filter(!(id_patients %in% id_twostage))


#fix missing pdfs values
new %<>% mutate(rtime = ifelse(rtime > cens_time, cens_time, rtime))
new %<>% mutate(rtime = ifelse((id_patients %in% c(7,29,452) & index==1), lead(time),rtime))

#primary survival - not used, but "years from primary" used
new$days_primary <- round(here() - new$primaryresectiondate)
new$primary_to_op <- difftime(new$opdate, new$primaryresectiondate, units="days")
new$primary_to_op <- as.numeric(new$primary_to_op)

#Clean up Primary tumour stuff
#Years from primary
new$year_primary <- car::Recode(new$primary_to_op, "-5000:0='0'; 0:365='1'; 366:730='2'; 731:1095='3'; 1096:1460='4'; 1461:4500='5'", as.factor.result=T)

#Recode primaryT into 3 levels only - insufficient T1's to be useful
new$primaryT <- car::Recode(new$primaryT, "1:2='2'", as.factor.result=TRUE)
new$primaryN <- as.factor(new$primaryN)
new$primaryM <- as.factor(new$primaryM)
new$primarytreatment <- as.factor(new$primarytreatment)

#Split into just chemo/no chemo - not important otherwise?
new %>% mutate(ptr = ifelse(grepl("chemo", primarytreatment),"yes","no")) -> new
new$ptr[is.na(new$primarytreatment)] <- NA
new$primarytreatment <- new$ptr
new$primarytreatment <- as.factor(new$primarytreatment)

#add difloc
new[grepl("lesionseg", names(new))] <- lapply(new[grepl("lesionseg", names(new))], as.factor)
dif_segs <- c("lesionseg1", "lesionseg8", "lesionseg7")
new %<>% mutate(difsum = (as.numeric(lesionseg1)-1) + (as.numeric(lesionseg7)-1) + (as.numeric(lesionseg8)-1), difloc = ifelse(difsum>0,1,0))
new$difloc[grepl("tumorectomy 4a", new$liverprocs)] <- 1

#add ehd
new %<>% mutate(ehd = !is.na(extrahepaticdiseasesites))
new$ehd <- as.factor(new$ehd)

#add lap strata
new %<>% group_by(id_patients) %>% 
  mutate(lap1 = ifelse(index==1&lap==1,1,0), 
         lap2 = ifelse(index==2&lap==1,1,0), 
         lap3 = ifelse(index==3&lap==1,1,0), 
         lap4 = ifelse(index==4&lap==1,1,0), 
         numlap = sum(lap))

#posmarg
new %<>% ungroup() %>% mutate(posmarg = ifelse(!is.na(new$margin),ifelse(new$margin<1,1,0),NA))
new %<>% mutate(tstage = ifelse(primaryT %in% c(1,2),2,ifelse(primaryT==3,3,ifelse(primaryT==4,4,NA))))

#Era
new %>% mutate(era = ifelse(year(opdate)<2004,0,1)) -> new


#$Subsetting
subnew <- new %>% select(age,bloodloss,CEA,hlos,id_patients,isanatomic,isbilateral,isconversion,isextended,ismajor,lesioncount,lesionmaxdiameter, margin,primaryT,primaryN,primaryM,primarytumourgrade,primarytreatment, year_primary,sex, lap, cens_time, cens, index, difloc,time,rtime,rec,optime, era)

