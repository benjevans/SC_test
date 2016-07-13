##tidyr-intro.r

## install
install.packages('tidyr')
library(tidyr)

gap_wide <- read.csv("data/gapminder_wide.csv")
head(gap_wide)


#trying to gather a wide data frame
gap_long <- gap_wide %>% 
  gather(key=)
