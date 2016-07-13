## dplyr-intro.r
## Ben Evans

## installing packages
#install.packages("dplyr") ## do this once only to install the package on your computer.
library(dplyr) ## do this every time you restart R and need it 

#using the gapminder package as there is one specifically for this data set
#install.packages("gapminder")
library(gapminder)
str(gapminder)

## start using the filter function from the package
filter(gapminder, lifeExp <29 )
filter(gapminder, country == "Mexico")

##for two countries
filter(gapminder, country %in% c("Mexico", "Ecuador")) # %in% operation for matching
## by the way, you can use :: to signify the package, or to search for functions

## Pipe operator %>% 
gapminder %>% head(10) 

gapminder %>%
select(year, lifeExp) %>% 
head(4)

## select some for cambodia
gapminder %>%
  filter(country== 'Cambodia') %>% 
  select(country, year, pop, gdpPercap) #nice, but long, can just MINUS things

gapminder %>%
  filter(country== 'Cambodia') %>% 
  select(-continent, -lifeExp)
  
## now to mutate, which means to add a column with a function
gapminder %>% 
  mutate(gdp = pop*gdpPercap) ## here we're calculating the gdp

## example to add the gdp to the Cambodia 
gapminder %>%
  filter(country== 'Cambodia') %>% 
  select(-continent, -lifeExp) %>% 
  mutate(gdp = pop*gdpPercap) %>% 
  select()

#calculating mean gdp for Cambodia
gapminder %>%
  filter(country== 'Cambodia') %>% 
  select(-continent, -lifeExp) %>% 
  mutate(gdp = pop*gdpPercap) %>% 
  select(country, year, gdp, pop, gdpPercap) %>%
  group_by(country) %>% 
  summarise(mean_gdp= mean(gdp))

#but it just gives one line
new_variable <- gapminder %>%
  #filter(country== 'Cambodia') %>% 
  select(-continent, -lifeExp) %>% 
  mutate(gdp = pop*gdpPercap) %>% 
  select(country, year, gdp, pop, gdpPercap) %>%
  group_by(country) %>% 
  summarise(mean_gdp= mean(gdp)) %>% 
  ungroup() #remember to ungroup! Things will stay grouped otherwise

#### ---- find maximum lifeExp for countries in Asia.. what is the earliest year encoutered? ---- 
gapminder %>%
  filter(continent== 'Asia') %>% 
  group_by(country) %>% 
  filter(lifeExp == max(lifeExp)) %>% 
  arrange(desc(year)) %>% 
 tail()

### --- remember you can run chunks of the chain to explore its effects

str(gapminder)
  