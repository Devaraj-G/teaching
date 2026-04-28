# Subsetting data
# finding subsets of the data

# names
# of columns and rows

x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x)
names(x) <- c('a','b')
names(x)
names(x) <- c('a','b','c','d','e')
names(x)

# access elements
x[1]
x[4]
x[1,4] # not working
x[c(1,4)] # not sequential
x[1:4] #sequential
c(1,4)
x[c(1,1,4)]
x[8]
x[0]

# remove elements
x[-2]
x
x[c(-2,-3)]

# access by names
x
x[c('a','b')]
x[-'a']

# access using logical values TRUE or FALSE
x
x[c(FALSE, FALSE, TRUE, FALSE, TRUE)]
names(x)
names(x) == 'a'
x[names(x) == 'a']

# Data frames

gapminder <- read.csv('data/gapminder_data.csv')
class(gapminder)
gapminder
str(gapminder)

head(gapminder)
names(gapminder)
colnames(gapminder)
rownames(gapminder)

head(gapminder[3])
names(gapminder[3])

head(gapminder['pop'])
class(head(gapminder['pop']))
head(gapminder[['pop']])
class(head(gapminder[['pop']]))

gapminder[1:3,]
gapminder[3,]
gapminder[3,3]

