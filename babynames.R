library(babynames)
library(ggplot2)
library(dplyr)
library(tidyverse)
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
the_ninties <- bb_names %>%
  filter( year >= "1990")
# 16) Save this dataset to your repository (use write.csv()).
# 
write_csv(the_ninties, "the_ninties.csv")
# 17) Add, commit, and push your files to GitHub.

# 18) In RStudio pull from GitHub. Is it already up to date?
#   
#   19) Now that everything is up to date, make a visualisation of you and your team member’s names for a year of your choice.
# 
team_names <- bb_names %>% filter( name %in% c("Mason", "Lucy", "Cheyenne", "Ruth") & year == '2004')

ggplot(data = team_names, aes( x = name, y = n))+
  geom_col() +
  facet_wrap(~sex)
# 20) Make a visual that looks at your name over time. What happens if you color by sex?
#   
#   21) Don’t forget to stage/add, commit, and push your hardwork to GitHub!
