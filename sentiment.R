library(tidyverse)
library(ggplot2)
library(dplyr)
library(tidytext)
library(gsheet)
library(wordcloud2)
library(sentimentr)
library(lubridate)

survey <- gsheet::gsheet2tbl('https://docs.google.com/spreadsheets/d/1W9eGIihIHppys3LZe5FNbUuaIi_tfdscIq521lidRBU/edit?usp=sharing')

head( survey, 10)

survey <- survey %>%
  mutate( date_time = mdy_hms(Timestamp))

table(survey$date_time)

sentiments <- get_sentiments('bing')

head(sentiments, 10)
words <- survey %>%
  dplyr::select(first_name,
                feeling_num,
                feeling) %>%
  unnest_tokens(word, feeling)

table(words)

wordcloud2(words)

word_freq <- words %>%
  group_by(word)%>%
  tally()

wordcloud2(word_freq, size = 2)

sw <- read_csv('https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/stopwords.csv')

head( sw, 10 )
ncol(sw)
nrow(sw)

word_freq %>%
  filter( word %in% sw$word )

word_freq <- word_freq %>%
  filter( !word %in% sw$word )

wordcloud2(word_freq)

# 18. Make an object with the top 10 words used only. Name this object top10.
# 

word_freq <- word_freq %>%
  arrange(desc(n))

top_10 <- head( word_freq, 10)

# 19. Create a bar chart showing the number of times the top10 words were used.
# 
ggplot(data = top_10, aes( x = word, y = n)) + geom_col()
# 20. Run the below to join word_freq with sentiments.
# 
sentiments1 <- left_join(sentiments, word_freq,by = "word")
# 21. Now explore the data. What is going on?
#   

#   22. For the whole survey, were there more negative or positive sentiment words used?
#   

#   23. Create an object with the number of negative and positive words used for each person.
# 
sentiments2 <- sentiments1 %>% #creates new dataset
  group_by(sentiment) %>% #groups by positive or negative
  summarise(total_frequency = sum(n, na.rm = TRUE)) %>% #summarizes
  spread(key = sentiment, value = total_frequency, fill = 0) 
# 24. In that object, create a new variabled named sentimentality, which is the number of positive words minus the number of negative words.
# 
sentiments2 <- sentiments2 %>% mutate(sentimentality=positive-negative)
# 25. Make a histogram of senitmentality
# 
ggplot( data = sentiments2, aes( x = sentimentality)) + geom_histogram() 
# 26. Make a barplot of sentimentality.
# 
ggplot( data = sentiments2, aes( x = sentimentality)) + geom_bar() 
# 27. Create a wordcloud for the dream variable.
# 
sdream <- survey %>%
  select(first_name, dream) %>%
  unnest_tokens(words, dream)

sdream1 <- sdream %>% group_by(words) %>% tally()
wordcloud2(sdream, size = 0.5)
# 28. Create a barplot showing the top 16 words in our dreams.

# 
# 29. Which word showed up most in people’s description of Joe?
#   
#   30. Make a histogram of feeling_num.
# 
# 31. Make a density chart of feeling_num.
# 
# 32. Change the above plot to facet it by gender.
# 
# 33. How many people mentioned Ryan Gosling in their description of Joe?
#   
#   34. Is there a correlation between the sentimentality of people’s feeling and their feeling_num?

