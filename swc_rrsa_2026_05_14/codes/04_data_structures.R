# Data frame
cats <- data.frame(
  coats = c('calico', 'black', 'tabby'),
  weight = c(2.1, 5.0, 3.2),
  likes_catnip = c(1,0,1)
)

str(cats)
View(cats)

# write csv
write.csv(x = cats,
          file = 'data/feline-data.csv',
          row.names = FALSE
          )
# read csv
cats <- read.csv(file = 'data/feline-data.csv')

cats
cats$coats

# Data frame column is a vector (all entries of same data type)
# Data frame row is a list (entries can be of different kinds)
# Data frame is a list of lists

cats$weight <- cats$weight + 2

paste('my cat is ', cats$coats)
# my cat is calico black tabby

cats$weight + cats$coats

# type
typeof(cats)
typeof(cats$weight)
typeof(cats$coats)

typeof(3) # 3.0
typeof(3L) # 3
typeof(TRUE)
typeof(1.3)
typeof(1+1i) # i = sqrt(-1)
typeof('banana')

# add a row (another cat)

additional_cat <- data.frame(
  coats = 'tabby',
  weight = '2.3 or 4.3',
  likes_catnip = 1
)

cat2 <- rbind(cats, additional_cat)

names(cats)
colnames(cats)

# R coerces, you can too
character_vector_example <- c('0','2','4')
character_coerced_into_double <- as.double(character_vector_example)
character_coerced_into_logical <- as.logical(character_coerced_into_double)

cats$weight
cats2 <- cat2

# Challenge
# 1. Print the data
cats2
print(cats2)

# 2. Show an overview of the table with all data types
str(cats2)

# 3. The "weight" column has the incorrect data type chr.
#    The correct data type is: double.

# 4. Correct the 4th weight data point with the mean of the two given values
cats2$weight[4] <- 2.35
#    print the data again to see the effect
str(cats2)

# 5. Convert the weight to the right data type
cats2$weight <- as.double(cats2$weight)
str(cats2)
#    Calculate the mean to test yourself
mean(cats2$weight)

# If you see the correct mean value (and not NA), you did the exercise
# correctly!
