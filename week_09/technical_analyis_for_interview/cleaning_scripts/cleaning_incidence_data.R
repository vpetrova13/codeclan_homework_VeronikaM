#Load libraries 
library(tidyverse)
library(janitor)
library(here)

incidence_raw <- read_csv(here("raw_data/Incidence_by_Health_Board.csv")) %>% 
  clean_names()

#Familiarise with data
dim(incidence_raw)
names(incidence_raw)
glimpse(incidence_raw)

#I want to remove all columns with qualifier information as it is not necessary 
#for further analysis and icd10code

#Removed world age standard. 
incidence_clean <- incidence_raw %>% 
  select(-easr_lower95pc_confidence_interval_qf, -easr_upper95pc_confidence_interval_qf,
         -wasr_lower95pc_confidence_interval_qf, -wasr_upper95pc_confidence_interval_qf,
         -cancer_site_icd10code, -sex_qf, -wasr, -wasr_lower95pc_confidence_interval,
         -wasr_upper95pc_confidence_interval)

unique(incidence_clean$cancer_site)
#Check NAs
(sum(is.na(incidence_clean)))

#Write csv

write_csv(incidence_clean, "cancer_incidence_clean.csv")

