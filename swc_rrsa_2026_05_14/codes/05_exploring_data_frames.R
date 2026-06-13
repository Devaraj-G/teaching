gapminder <- read.csv('data/gapminder_data.csv')
View(gapminder)

head(gapminder)
tail(gapminder)

head(gapminder, n = 10)
tail(gapminder, n = 10) # do not use n <- 3 here in function argument

summary(gapminder)

typeof(gapminder$year)
class(gapminder$year)

length(gapminder)
length(gapminder$year)
nrow(gapminder)
dim(gapminder)
