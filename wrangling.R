# wrangling and cleaning Pokemon to get that wild Pokemon smell off them.

library(tidyverse)
library(stringr)
library(dplyr)

# guiding pokemon into their enclosure [loading data]
data <- read_csv("Documents/Personal/projects/pokeboard/pokemon.csv")

# some diagnostics
dim(data)
str(data)
View(data)

# repetition in the Pokedex number column due to special forms.
data <- data %>%
  # introducing additional reference number to maintain order integrity.
  mutate(
    Reference = 1:800
  ) %>%
  # renaming original index col since it could be problematic
  rename(`Pokedex Entry` = `#`) %>%
  # reordering so ref variable is in front
  relocate(Reference)

# splitting the name column to separate regular Pokemon from their special
# forms and evolutions.
extractor = function(x) {
  # extracts all text that follows a lowercase and uppercase letter combination
  # using regex
  str_extract(x, "(?<=[a-z])(?=[A-Z]).*")
}

# extracting all special forms
specialForms <- sapply(data$Name, extractor)

# replacing original entry with extracted text (exclusively for special forms)
for (i in 1:800) {
  ifelse(is.na(specialForms[i]),
         data$Name[i] <- data$Name[i],
         data$Name[i] <- specialForms[i])
}



