gapminder <- read.csv('data/gapminder_data.csv')
library(ggplot2)

ggplot(data = gapminder)

ggplot(data = gapminder,
       mapping = aes(x = gdpPercap, y = lifeExp))
ggplot(data = gapminder,
       mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp)) +
  geom_point()
ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp)) +
  geom_line()

ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp, color = continent)) +
  geom_line()
ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp, color = continent, group = country)) +
  geom_line()
ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp, color = continent, group = country)) +
  geom_line() +
  geom_point()

ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp, color = continent, group = country)) +
  geom_point()

ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp, color = continent, group = country)) +
  geom_line() +
  geom_point(color = 'black')
  
ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp, group = country)) +
  geom_line(mapping = aes(color = continent)) +
  scale_colour_discrete(palette = scales::pal_brewer(palette = "Dark2"))+
  geom_point()
 
ggplot(data = gapminder,
       mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) +
  scale_x_log10()

ggplot(data = gapminder,
       mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) +  scale_x_log10() +
  geom_smooth() 

# subset data
americas <- gapminder[gapminder$continent == 'Americas',]

ggplot(data = americas,
       mapping = aes(x = year, lifeExp)) +
  geom_line() +
  facet_wrap(~ country)

fig <- ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = lifeExp,
                     group = country,
                     color = continent)) +
  scale_color_manual(
    values = c(Africa = 'red', Americas='green')) +
  geom_line() +
  geom_hline(yintercept = 60, color = 'black')

ggsave(filename = 'outputs/fig.pdf')

ggsave(filename = 'outputs/fig.png', width = 6, height = 10, dpi = 100, units = 'cm')
