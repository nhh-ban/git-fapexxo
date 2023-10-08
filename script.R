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


# Problem 3

# Idea: Brighter galaxies are more likely to be detected which are bigger
# --> Bias towards smaller galaxies

# plot sample distribution of linear diameter (a_26) with opposite sign for
# interpretation. In the plot higher -m_b means higher brightness.
galaxy_data %>% 
  ggplot(aes(x = -m_b)) +
  geom_histogram()

# calculate empirical skewness (< 0)
moments::skewness(-galaxy_data$m_b, na.rm = TRUE)

# This distribution is slightly skewed to the left.
# Size and brightness should be correlated

# bigger galaxies are brighter
galaxy_data %>% 
  ggplot(aes(x = a_26, y = -m_b)) +
  geom_point() +
  geom_smooth()



