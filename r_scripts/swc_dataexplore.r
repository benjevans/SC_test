## Initial data exploration script 
# Ben Evans

## Read gapminder csv ----
gapminder <- read.csv("data/gapminder.csv")

## explore dataset ---- 
head(gapminder) ## gives first 6 rows
tail(gapminder) ## gives last 6 rows
tail(gapminder, 12) ## gives last 12 rows

str(gapminder) ## gives structure of the data frame
names(gapminder) ## column names
dim(gapminder) ## dimensions rows X columns
ncol(gapminder) ## number of columns
nrow(gapminder) ## number of rows
c(nrow(gapminder), ncol(gapminder)) ## combines values into a single vector
summary(gapminder) ## statistically explore the values in the data set

### explore variables within a dataframe ---- 
# here we use $ to exact or replace parts of an object
head(gapminder$lifeExp)
str(gapminder$lifeExp)

### subsetting using the base notation ----

gapminder[gapminder$lifeExp < 28, ]
gapminder[gapminder$country == "Uruguay", ]

## subsetting observations with lifeExp below 32 for specific columns
gapminder[gapminder$lifeExp < 32, c("country", "year", "lifeExp") ]

## BETTER to use subset function
subset(gapminder, country == "mexico")

## plotting for mexico subset
mexico <- subset(gapminder, country == "Mexico", select = c(country, year, lifeExp, pop))
plot(mexico$year, mexico$pop)
dev.print(pdf, "mexico_pop.year")

## again for panama BUT CAREFUL WITH FIND REPLACE - EASY FOR TYPOS TO SLIP IN
panama <- subset(gapminder, country == "Panama", select = c(country, year, lifeExp, pop))
plot(Panama$year, Panama$pop)
dev.print(pdf, "panama_pop.year")

### for loop structure ----
# for (iterator in set of values){do a thing}

##step one  (commented all using shift, command and C) pseudo code to show what we are doing
## make sure we've created all the necessary objects - in this case country list. 

## creating an object we want to do the loop on (look at second line down there)
country_list <-c("Ecuador", "Guatemala")

for(i in country_list) {  ## for every thing 'i' in the object
  country_subset <-subset(gapminder, country == country_selected) ## subset that i
  plot(country_subset$year, country_subset$pop) ## plot that i
  dev.print(pdf, paste0(country_selected, "_pop.pdf")) ## save the plot of i
}

## now make figures for ALL countries in the list, not just the two in 'country_list' above
country.subset <- unique(gapminder$country)
## creating a folder to store the images
dir.create('figures')

## create an empty data frame with <- data.frame()
pop_mean_result <- data.frame()

for(i in country_list) {  ## for every thing 'i' in the object
  country_subset <-subset(gapminder, country == i) ## subset that i
  #plot(country_subset$year, country_subset$pop, main = paste0(i,"Population Growth", sep= "  ")) ## plot that i
  #dev.print(pdf, paste0("figures/", i, "_pop.pdf")) ## save the plot of i


## now to calculate means
pop_mean <- mean(country_subset$pop)
pop_mean_result <- rbind(pop_mean_result, data.frame(i, pop_mean))

## now to make a string of text with the means
print(paste0('the mean population for ', i , ' is ', pop_mean))
}

## rename the columns
names(pop_mean_result) <- c('country', 'mean_pop')

