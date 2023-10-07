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


# plot sample distribution of linear diameter (a_26)
galaxy_data %>% 
  ggplot(aes(x = a_26)) +
  geom_histogram()

# This distribution is clearly skewed to the right.
# If we think that size is symmetrically distributed,
# then this could be an indication for a selection bias.

# calculate empirical skewness (> 0)
moments::skewness(galaxy_data$a_26, na.rm = TRUE)

# Theoretical argument: Size and brightness should be correlated. The fact that
# brighter galaxies might be easier to detect, could be a reason for this bias.

# bigger galaxies are brighter (the smaller m_b, the brighter)
galaxy_data %>% 
  ggplot(aes(x = a_26, y = m_b)) +
  geom_point() +
  geom_smooth()



