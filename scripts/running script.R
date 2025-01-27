
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

plot <- ggplot(df1) +
  geom_line(aes(x = year, y = avg_gdpPercap, color = continent))


# November 22, 2024

#install.packages(c("tidyverse", "gapminder"))
library(tidyverse)
library(gapminder)

plot_facet <- plot +
  facet_wrap(facets = df1$continent)


ggplot(df) +
  geom_point(aes(y = lifeExp, x = country)) +
  facet_wrap(facets = df$year)


# December 6, 2024
# Reading a .xlsx file

# intalling packages
install.packages("readxl")
install.packages("writexl")
install.packages("here")

# another option for installing packages
install.packages(c("readxl", "writexl", "here"))

library(tidyverse)
library(readxl)
library(writexl)
library(here)

# Read in an excel file
df <- read_xlsx(here::here("C:/Users/Brian Calhoon/Documents/Humans Learning/data/testdata2.xlsx"))

#create a new column that takes data from 
# the column v2, and based on whether or not it
# is greater than or equal to 3, inserts a 1 or a 0

df1 <- df |> 
  mutate(new_col = ifelse(v2 >= 3, 1, 0)) 

#write this new file to Excel
write_xlsx(df1, path = "./data/testdata2.xlsx")
  
# December 12, 2024
# data manipulation: pivot_longer() vs. unite()
#both part of the tidyverse suite of packages

# sample data frame

library(tidyverse)
library(readxl)

df <- read_xlsx(here::here("./data/colors.xlsx")) 

df <- janitor::clean_names(df)

#Using pivot longer
df1 <- df |> 
  pivot_longer(cols = 2:6
             , names_to = "What_is_your_favorite_color"
             , values_drop_na = TRUE) |> 
  select(resp, "What_is_your_favorite_color")

#Using pivot wider
df2 <- df |>
  unite("fav_color", 2:6
        , sep = ", "
        , na.rm = TRUE)


# December 27, 2024
# using the summary function
# and the summarytools package

library(tidyverse)
library(summarytools)
library(readxl)
library(here)

df <- read_xlsx(here::here("C:/Users/Brian Calhoon/Documents/Humans Learning/data/testdata2.xlsx"))

#view the file
# glimpse is from the dplyr package
glimpse(df)

str(df)

head(df)

#A quick summary of the data
# in the object
summary(df) 

#Using summarytools we can do a little
# more
df |> 
  select(-respondentid) |> 
  dfSummary(
    graph.col = TRUE,
    style = "grid",
    graph.magnif = .75) |> 
  stview()

# just the descriptive stats
# ignores non-numeric data
df |> 
  select(-respondentid) |> 
  descr() |> 
  stview()

# View categorical data
df |> 
  select(-respondentid, -v2, -lat, -long) |> 
  freq() |> 
  stview()

# January 3, 2025
# playing with filter, group_by, summarize functions
# install.packages(c("tidyverse", "gapminder"))

library(tidyverse)
library(gapminder)

#set your object as the gapminder dataset 
df <- gapminder

glimpse(df)

#americas only 
df_americas <- df |>
  filter(continent == "Americas") 

glimpse(df_americas)

# Group by and summarize
df_americas <- df |> 
  filter(continent == "Americas") |> 
  group_by(country) |> 
  summarize(avg_lifeExp = mean(lifeExp)
            , med_lifeExp = median(lifeExp))

df_summary <- df |> 
  group_by(country) |> 
  summarize(avg_lifeExp = mean(lifeExp)
            , med_lifeExp = median(lifeExp))


#1/24/25
#ggiraph

library(tidyverse)
library(gapminder)
library(ggiraph)

#Build off the skills we've been learning

#set your object as the gapminder dataset 
df <- gapminder

glimpse(df)

#americas only 
df_americas <- df |>
  filter(continent == "Americas") 

glimpse(df_americas)


# Group by and summarize
df_americas <- df |> 
  filter(continent == "Americas") |> 
  group_by(country, year) |> 
  summarize(avg_lifeExp = mean(lifeExp)
            , med_lifeExp = median(lifeExp))

#df_summary <- df |> 
 # group_by(country) |> 
  #summarize(avg_lifeExp = mean(lifeExp)
   #         , med_lifeExp = median(lifeExp))

#make a line plot
ggplot(df_americas
             , aes(x = year, y = avg_lifeExp, group = country
                   , color = country)) +
  geom_line()

#A simple tweak to make it interactive
gg <- ggplot(df_americas
             , aes(x = year, y = avg_lifeExp, group = country
                   , color = country)) +
  geom_line_interactive(aes(tooltip = country, data_id = country)) +
  labs(title = "Interactive line plot")

gg
#now use the gg object created above
plot <- girafe(ggobj = gg, width_svg = 8, height = 6
               , options = list(
                 opts_hover_inv(css = "opacity:0.1;"),
                 opts_hover(css = "stroke-width:1;")
               ))            
              
plot 

