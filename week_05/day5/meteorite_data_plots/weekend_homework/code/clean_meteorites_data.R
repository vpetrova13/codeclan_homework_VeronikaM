#Load libraries
library(tidyverse)
library(janitor)
library(assertr)

#Read data and explore
meteorites <- read_csv("data/meteorite_landings.csv") %>%  clean_names()
head(meteorites)
names(meteorites)
dim(meteorites)

stopifnot(
  names(meteorites) == c("id", "name", "mass_g", "fall", "year", "geo_location")
)
#Change names of variables to follow naming standards
meteorites <- meteorites %>% 
  mutate(name = (str_to_lower(name))) %>% 
  mutate(fall = (str_to_lower(fall)))
meteorites <- meteorites %>% 
  mutate(name = str_replace_all(name, "[:space:]", "_"))

#Splitting the column
meteorites <- meteorites %>% 
  separate(col = geo_location, into = c("latitude", "longitude")
           , sep = "\\,") 

meteorites <- meteorites %>% 
  mutate(latitude = (str_remove(latitude, "\\("))) %>% 
  mutate(longitude= (str_remove(longitude, "\\)")))

#Replace missing values with zero
meteorites <- meteorites %>% 
  mutate(latitude = coalesce(latitude, "0")) %>% 
  mutate(longitude = coalesce(longitude, "0")) 

#Remove small meteorites and order data by year
meteorites <- meteorites %>% 
  filter(mass_g > 1000) %>% 
  arrange(year)

meteorites$latitude <- as.numeric(as.character(meteorites$latitude),  length = 10)
meteorites$longitude <- as.numeric(as.character(meteorites$longitude), length = 10)

#Assertive programming
meteorites %>%
  verify(latitude > -90 & latitude < 90) %>% 
  verify(longitude > -180 & longitude < 180)


meteorites

write_csv(meteorites, "data/clean_meteorites.csv")






meteorites <-
  meteorites %>% 
  rename(
    mass = "mass (g)",
    lat_lng = "GeoLocation"
  ) %>% 
  mutate(
    lat_lng = str_remove(lat_lng, fixed("(")),
    lat_lng = str_remove(lat_lng, fixed(")"))
  ) %>% 
  separate(lat_lng, c("lat", "lng"), sep = ", ") %>% 
  mutate(
    lat = as.numeric(lat),
    lng = as.numeric(lng),
    lat = coalesce(lat, 0),
    lng = coalesce(lng, 0)
  ) %>% 
  filter(
    mass >= 1000
  ) %>% 
  arrange(year)