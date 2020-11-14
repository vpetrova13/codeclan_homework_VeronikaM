# Load libraries and read data
library(tidyverse)
library(janitor)
disasters_raw_data <- read_csv("raw_data/disasters_with_errors.csv") %>% clean_names()

#Modify row names
disasters_data <- disasters_raw_data %>% 
  mutate(disaster_type = str_to_lower(disaster_type)) %>% 
  mutate(country_name = str_remove_all(country_name, "\\d+")) %>% 
  mutate(iso = str_extract(iso, "[A-Z]{3}"))

#Check NA in each column
disasters_data %>% 
  summarise_all(funs(sum(is.na(.))))

# Find NA in iso and replace it
disasters_data %>% 
  filter(is.na(iso))

disasters_data <- disasters_data %>% 
  mutate(iso = replace_na(iso, "IND"))

#There are too many NA in other rows to replace or exclude
# Remove duplicate rows 
disasters_data <- distinct(disasters_data)

disasters_data <- disasters_data %>% 
  filter(is.na(total_deaths)|total_deaths>= 0)

write_csv(disasters_data, "clean_disaster_data.csv")


