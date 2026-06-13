# R as a calculator
1+1
3+5*3
#source('02_intro.R')
2/10000 # 2 * 10^-4

# functions (in-built)
getwd()
sin(1)
sin(pi)

# logical operations (comparing things)
1 == 1 # equal?
1 < 2 # less?
1 > 2 # greater?

1 >= 1
1 != 1 # not equal

# assignment (put a value in an object/variable)
x <- 1/40
y = 1/40
x <- 3

x <- x + 2

# Challenge
min_height <- 0
max.height <- 0
#_age <- 0 # do not put _ at the start
.mass <- 0
MaxLength <- 0
min-length <- 0 # do not use - in the variable name
# 2widths <- 0
celsius2kelvin <- 0

# Vectorization/Vectors
1:5
2^(1:5) # 2^2 = 4
2*(1:5)

x <- 1:5
2^x

# Environment
ls() # use function ls
ls # see contents of R function ls

rm(x)

rm(list = ls())

# Challenge
mass <- 47.5
age <- 122
mass <- mass * 2.3
age <- age - 20

print(age)

mass > age

rm(age)

# Packages
# install packages: ggplot2 plyr gapminder
install.packages('ggplot2')
install.packages(c('plyr','gapminder')) # use c()
# load packages
library(ggplot2)

# Seeking help
?ls # exact search
??ls # fuzzy approximate search
?`<-` # help on operators

# Challenge 
# What does c() do?
x <- c(1, 2, 3)
y <- c('d', 'e', 'f')
z <- c(1, 2, 'f')
a <- c(1,2,1.1)
b <- c(1,2,TRUE)
# type coercion (in a vector)

# Paste
paste('a','b')
paste('a','b', sep = '')
paste(c('a','c'),'b')
paste(c('a','c'),'b', sep = '')
paste(c('a','c'),'b', sep = '', collapse = '|')