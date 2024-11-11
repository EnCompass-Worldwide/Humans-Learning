
# November 11, 2024

library(tidyverse)
library(gapminder)


df <- gapminder

head(df)

tail(df)

#I grouped data by continent and year
# and I calculated the avg gdp per cap
df1 <- df |> 
  group_by(continent, year) |> 
  summarize(avg_gdpPercap = mean(gdpPercap))

head(df1)

tail(df1)

ggplot(df1) +
  geom_line(aes(x = year, y = avg_gdpPercap, color = continent))




