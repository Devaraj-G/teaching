# dplyr on data frames
# 6 verbs/commands that can be used in dplyr

mean(gapminder[gapminder$continent == 'Africa', 'gdpPercap'])

mean(gapminder[gapminder$continent == 'Americas', 'gdpPercap'])

mean(gapminder[gapminder$continent == 'Asia', 'gdpPercap'])

# dplyr package
library(dplyr)

# SELECT # select a column
year_country_gdp <- select(gapminder,year,country,gdpPercap)
str(year_country_gdp)

# dplyr allows piping or pipe %>%
year_country_gdp <- gapminder %>%
  select(year,country,gdpPercap)
str(year_country_gdp)

# FILTER # ~ rows
year_country_gdp_eur <- gapminder %>%
  filter(continent == 'Europe')
str(year_country_gdp_eur)
head(year_country_gdp_eur)

# chain the pipes
year_country_gdp_eur <- gapminder %>%
  filter(continent == 'Europe') %>%
  select(year,country,gdpPercap)
head(year_country_gdp_eur)

# challenge 1
year_country_lifeExp_Africa <- gapminder %>%
  filter(continent=="Africa") %>%
  select(year,country,lifeExp)

# GROUP_BY
str(gapminder)
gapminder %>% group_by(continent) %>% str()

gapminder %>% group_by(year) %>% str()

gapminder %>% group_by(year,continent) %>% str()

# SUMMARIZE # stats
gdp_bycontinents <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))
gdp_bycontinents

# challenge 2
lifeExp_bycountry <- gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp=mean(lifeExp),
            sd_lifeExp = sd(lifeExp))
head(lifeExp_bycountry)

# MUTATE
gdp_pop_by_continents_byyear <- gapminder %>%
  mutate(gdp_billion = gdpPercap*pop/10^9)
str(gdp_pop_by_continents_byyear)


gdp_pop_by_continents_byyear <- gapminder %>%
  mutate(gdp_billion = gdpPercap*pop/10^9) %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            mean_pop = mean(pop),
            mean_gdp_billio = mean(gdp_billion))
head(gdp_pop_by_continents_byyear)

# change in grouping order
gdp_pop_by_continents_byyear <- gapminder %>%
  mutate(gdp_billion = gdpPercap*pop/10^9) %>%
  group_by(year,continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            mean_pop = mean(pop),
            mean_gdp_billio = mean(gdp_billion))
head(gdp_pop_by_continents_byyear)







