library(babynames)
library(ggplot2)
library(dplyr)
bb_names <- babynames

ggplot(data = bb_names %>% filter( name == "Mary", year >= "1982"), aes( x = year)) + geom_bar()
  
ggplot(data = bb_names %>% filter( name == "Joe"), aes( x = year, y = n, color = sex)) +
  geom_line(alpha = 0.5, linewidth=2) + labs( title = "Joe's", y = "No. of Joe's'", "Year")

# 13)Create a bar chart of all female names in 2002.
# 
# 14) Make the bars transparent and filled with the color blue.
# 
women <- bb_names %>%
  filter( sex == "F", year == "2002") %>%
  top_n(10,n)

ggplot(data = women, aes( x = name, y = n))  + geom_col(alpha = 0.5, linewidth=2, fill = "blue") 

# 15) Create a new data set called the_nineties that only contains years from the 1990s.
# 
the_nineties <- bb_names %>%
  filter( year >= "1990")
# 16) Save this dataset to your repository (use write.csv()).
# 

# 17) Add, commit, and push your files to GitHub.
