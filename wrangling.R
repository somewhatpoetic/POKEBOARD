# wrangling and cleaning Pokemon to get that wild Pokemon smell off them.

library(tidyverse)
library(stringr)
library(dplyr)

# guiding Pokemon into their enclosure [loading data]
data <- read_csv("Documents/Personal/projects/pokeboard/pokemon.csv")

# some diagnostics
# dim(data)
# str(data)
# View(data)

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
extractorF = function(x) {
  # extracts all text that follows a lowercase and uppercase letter combination
  # using regex
  str_extract(x, "(?<=[a-z])(?=[A-Z]).*")
}

extractorB = function(x) {
  # extracts all text that preceeds a lowercase and uppercase letter combination
  # using regex
  str_extract(x, ".*(?<=[a-z])(?=[A-Z])")
}

# extracting all special forms
specialForms <- sapply(data$Name, extractorF)

data <- data %>%
  # creating new column for special formes
  mutate(
    Forme = as.vector(specialForms)
  ) %>%
  # relocating for intuitive understanding
  relocate(Forme, .after = Name)
  
# replacing original entry with extracted text omitted (exclusively for special forms)
for (i in 1:800) {
  ifelse(is.na(specialForms[i]),
         {
           data$Name[i] <- data$Name[i]
           data$Forme[i] <- "Base"
         },
         data$Name[i] <- extractorB(data$Name[i]))
}

# updating accurate pokedex entry notation
spf = 2
for (i in 2:800) {
  if (data$Name[i] == data$Name[i-1]) {
    if (as.numeric(data$`Pokedex Entry`[i]) < 10 ){
      data$`Pokedex Entry`[i] <- paste0("00", data$`Pokedex Entry`[i], "_f", spf)
    } else if (as.numeric(data$`Pokedex Entry`[i]) >= 10 & as.numeric(data$`Pokedex Entry`[i]) < 100) {
      data$`Pokedex Entry`[i] <- paste0("0", data$`Pokedex Entry`[i], "_f", spf)
    } else {
      data$`Pokedex Entry`[i] <- paste0(data$`Pokedex Entry`[i], "_f", spf)
    }
    spf <- spf + 1
  } else {
    spf = 2
  }
}

for ( i in 1:800) {
  if(data$Forme[i] == "Base" & as.numeric(data$`Pokedex Entry`[i]) < 10) {
    data$`Pokedex Entry`[i] <- paste0("00", data$`Pokedex Entry`[i])
  } else if (data$Forme[i] == "Base" & as.numeric(data$`Pokedex Entry`[i]) > 9 & as.numeric(data$`Pokedex Entry`[i]) < 100) {
    data$`Pokedex Entry`[i] <- paste0("0", data$`Pokedex Entry`[i])
  }
}
