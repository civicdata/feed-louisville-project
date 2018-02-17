library(tidyverse)
library(magrittr)

dtc <- read_csv('data/dare_to_care.csv')

dtc %<>% 
  select(Store_Name = title, 
         Longitude = longitude, 
         Latitude = latitude, 
         Address = address,
         Zip5 = zip) %>%
  mutate(City = 'Louisville', 
         State = 'KY',
         County = 'Jefferson', 
         code = 7, 
         definition = 'Dare To Care Distribution Point') %>% 
  filter(Store_Name != 'Oak Park Christian Ministries') # No geo data :(

stores <- read_csv('data/jeff_co_food_data_source_naics.csv')

stores_dtc <- bind_rows(stores, dtc)

write_csv(stores_dtc, 'data/jeff_co_food_data_source_naics_dtc.csv')
