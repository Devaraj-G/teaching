library(dplyr)
mean(gapminder$gdpPercap)
mean(gapminder$gdpPercap[gapminder$continent == 'Africa'])
mean(gapminder$gdpPercap[gapminder$continent == 'Asia'])
cont = c('Africa','Americas','Europe','Oceania','Asia')
for (con in cont){
  x <- mean(gapminder$gdpPercap[gapminder$continent == con])
  print(paste(con, x))
}

# SELECT
year_country_gdp <- select(gapminder, year, country, gdpPercap)

smaller_gapminder_data <- select(gapminder, -continent)

year_country_gdp <- gapminder %>% 
  select(year, country, gdpPercap)

year_country_gdp_euro <- gapminder %>%
  filter(continent == 'Europe') %>% 
  select(year, country, gdpPercap)

gdp_bycontinent <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdp = mean(gdpPercap))
