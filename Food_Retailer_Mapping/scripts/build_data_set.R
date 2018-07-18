library(tidyverse)


naics_code <- tribble(~row_num, ~code, ~definition,
                      1, '445110', 'Grocery',
                      2, '452910', 'Super Center and Club Store',
                      3, '445120', 'Convenience Store',
                      4, '447110', 'Food Mart',
                      5, '445200', 'Specialized Lines of Food',
                      6, '6', "Farmer's Market")

rk <- read_csv('data/store_names_rk.csv') %>% 
  mutate(code = as.character(code)) %>% 
  left_join(naics_code)

dm <- read_csv('data/store_names_dm.csv') %>% 
  mutate(row_num = str_replace_all(row_num, '\\D','')) %>% 
  select(-naics) %>% 
  mutate(row_num = as.numeric(row_num)) %>% 
  left_join(naics_code)

ah <- read_csv('data/second.csv') %>%
  mutate(code = as.character(code)) %>% 
  left_join(naics_code)

ak <- read_csv('data/Unique_Store_Names_KANIK.csv') %>% 
  select(-notes) %>%
  mutate(row_num = as.numeric(row_num)) %>% 
  left_join(naics_code)

bm <- read_csv('data/Brandon.csv') %>%
  rename(names = name) %>% 
  mutate(row_num = as.numeric(row_num)) %>% 
  left_join(naics_code)

coded_data <- bind_rows(ah, ak, bm, dm, rk) %>% 
  distinct() %>% 
  mutate(names = str_trim(names))

jeff_co <- read_excel('data/Jeff County Food Source Data.xlsx', sheet = 1)

jeff_co %<>% 
  mutate(name_no_num = str_replace_all(Store_Name, '\\d', '') %>%
           str_replace_all('[:punct:]', '') %>% 
           str_to_upper() %>% 
           str_trim()) %>% 
  left_join(coded_data, by = c('name_no_num' = 'names'))

write_csv(jeff_co, 'data/jeff_co_food_data_source_naics.csv')
