library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

## First calculates mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

## Look at the following code and answer the following questions. 
## What do you think the scale_x_log10() line of code is achieving? 
## Answer: According to help files it "overrides the default linear mapping by using a transformation". 

## What about the geom_smooth() line of code? 
## Answer: According to help files it, "aids the eye in seeing patterns in the presence of overplotting".

## Modify the above code to size the points in proportion to the population of the country. 
## Hint: Are you translating data to a visual feature of the plot? 

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'blue', linetype = 'dashed') +
  theme_bw()


gapminder %>%
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot()+
  geom_point(aes(x = year, y = mean_lifeExp, color = continent)) + 
  geom_line(aes(x = year, y = mean_lifeExp, color = continent))

## Q - why can't you amend the x and y type? Are these defined terms within R? 

## Challenge Problem

## Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and the United States, with the data points in the backgroud using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”



countries <- c("Brazil", "China", "El Salvador", "Niger", "United States") 
#create a vector with just the countries we are interested in

## Q- Is this how you create "values"?

## making gg box plot

gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(x = country, y = lifeExp))+
  geom_boxplot() +
  geom_jitter(alpha = 0.3, color = "blue")+
  theme_minimal() +
  ggtitle("Life Expectancy of Five Countries") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  xlab("Country") + ylab("Life Expectancy") 

## Q- why do the dots move when I play about with the alpha numbers??

