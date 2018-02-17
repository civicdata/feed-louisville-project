library(tidyverse)
library(readxl)
library(magrittr)

jeff_co <- read_excel('data/Jeff County Food Source Data.xlsx', sheet = 1)

jeff_co %<>% mutate(name_no_num = str_replace_all(Store_Name, '\\d', '') %>% 
                      str_replace_all('[:punct:]', '') %>% str_to_upper())

unique_names <- tibble(names = unique(jeff_co$name_no_num))

write_csv(unique_names, 'data/Unique_Store_Names.csv')
