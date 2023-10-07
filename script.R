library(tidyverse)


# Problem 2

galaxy_data <- read_lines("data.txt") # read in data

# calculate index for separator line
seperator_index <-
  galaxy_data %>% 
  startsWith("-") %>% 
  which()

# omit unwanted lines
galaxy_data <- galaxy_data[-c((1:(seperator_index-2)), seperator_index)]

# write new "clean" file
file <- file("output.txt")
writeLines(galaxy_data, file)
close(file)

# read in new file overwriting initial data
galaxy_data <- read_delim("output.txt", delim = "|", trim_ws = TRUE)




