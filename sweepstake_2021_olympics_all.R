library(tidyverse)

# Part 1 of 2: assign countries to participants --------------------------------

# Names of participants.
people <- c("Alice", "Bob", "Carol", "David")

# All countries competing. I found this list with some unknown number after each
# country; we'll remove that in a moment.
countries <- c(
  "Afghanistan (5)",
  "Albania (9)",
  "Algeria (44)",
  "American Samoa (6)",
  "Andorra (2)",
  "Angola (20)",
  "Antigua and Barbuda (6)",
  "Argentina (174)",
  "Armenia (17)",
  "Aruba (3)",
  "Australia (474)",
  "Austria (60)",
  "Azerbaijan (44)",
  "Bahamas (16)",
  "Bahrain (32)",
  "Bangladesh (6)",
  "Barbados (8)",
  "Belarus (101)",
  "Belgium (121)",
  "Belize (3)",
  "Benin (7)",
  "Bermuda (2)",
  "Bhutan (4)",
  "Bolivia (5)",
  "Bosnia and Herzegovina (7)",
  "Botswana (13)",
  "Brazil (302)",
  "British Virgin Islands (3)",
  "Brunei (2)",
  "Bulgaria (42)",
  "Burkina Faso (7)",
  "Burundi (6)",
  "Cambodia (3)",
  "Cameroon (12)",
  "Canada (370)",
  "Cape Verde (6)",
  "Cayman Islands (5)",
  "Central African Republic (2)",
  "Chad (3)",
  "Chile (57)",
  "China (406)",
  "Colombia (71)",
  "Comoros (3)",
  "Cook Islands (6)",
  "Costa Rica (12)",
  "Croatia (59)",
  "Cuba (68)",
  "Cyprus (13)",
  "Czech Republic (117)",
  "Democratic Republic of the Congo (7)",
  "Denmark (105)",
  "Djibouti (4)",
  "Dominica (2)",
  "Dominican Republic (60)",
  "East Timor (3)",
  "Ecuador (41)",
  "Egypt (133)",
  "El Salvador (5)",
  "Equatorial Guinea (3)",
  "Eritrea (13)",
  "Estonia (33)",
  "Eswatini (4)",
  "Ethiopia (36)",
  "Federated States of Micronesia (3)",
  "Fiji (29)",
  "Finland (30)",
  "France (398)",
  "Gabon (5)",
  "The Gambia (4)",
  "Georgia (30)",
  "Germany (425)",
  "Ghana (14)",
  "Great Britain (376)",
  "Greece (83)",
  "Grenada (6)",
  "Guam (5)",
  "Guatemala (23)",
  "Guinea (5)",
  "Guinea-Bissau (4)",
  "Guyana (7)",
  "Haiti (6)",
  "Honduras (21)",
  "Hong Kong (42)",
  "Hungary (166)",
  "Iceland (4)",
  "India (120)",
  "Indonesia (28)",
  "Iran (66)",
  "Iraq (4)",
  "Ireland (116)",
  "Israel (90)",
  "Italy (372)",
  "Ivory Coast (28)",
  "Jamaica (50)",
  "Japan (552)",
  "Jordan (14)",
  "Kazakhstan (93)",
  "Kenya (85)",
  "Kiribati (3)",
  "Kosovo (11)",
  "Kuwait (11)",
  "Kyrgyzstan (16)",
  "Laos (4)",
  "Latvia (33)",
  "Lebanon (8)",
  "Lesotho (2)",
  "Liberia (3)",
  "Libya (4)",
  "Liechtenstein (5)",
  "Lithuania (41)",
  "Luxembourg (12)",
  "Madagascar (6)",
  "Malawi (5)",
  "Malaysia (30)",
  "Maldives (4)",
  "Mali (4)",
  "Malta (6)",
  "Marshall Islands (2)",
  "Mauritania (2)",
  "Mauritius (8)",
  "Mexico (163)",
  "Moldova (19)",
  "Monaco (6)",
  "Mongolia (43)",
  "Montenegro (34)",
  "Morocco (50)",
  "Mozambique (10)",
  "Myanmar (3)",
  "Namibia (11)",
  "Nauru (2)",
  "Nepal (5)",
  "Netherlands (274)",
  "New Zealand (223)",
  "Nicaragua (8)",
  "Niger (7)",
  "Nigeria (52)",
  "North Macedonia (8)",
  "Norway (75)",
  "Oman (4)",
  "Pakistan (10)",
  "Palau (3)",
  "Palestine (5)",
  "Panama (10)",
  "Papua New Guinea (8)",
  "Paraguay (8)",
  "Peru (34)",
  "Philippines (19)",
  "Poland (210)",
  "Portugal (92)",
  "Puerto Rico (37)",
  "Qatar (16)",
  "Refugee Olympic Team (29)",
  "Republic of the Congo (3)",
  "ROC (329)",
  "Romania (101)",
  "Rwanda (6)",
  "Saint Kitts and Nevis (3)",
  "Saint Lucia (5)",
  "Saint Vincent and the Grenadines (3)",
  "Samoa (8)",
  "San Marino (5)",
  "São Tomé and Príncipe (3)",
  "Saudi Arabia (29)",
  "Senegal (9)",
  "Serbia (86)",
  "Seychelles (5)",
  "Sierra Leone (4)",
  "Singapore (22)",
  "Slovakia (41)",
  "Slovenia (53)",
  "Solomon Islands (2)",
  "Somalia (2)",
  "South Africa (177)",
  "South Korea (236)",
  "South Sudan (2)",
  "Spain (320)",
  "Sri Lanka (9)",
  "Sudan (5)",
  "Suriname (3)",
  "Sweden (134)",
  "Switzerland (106)",
  "Syria (6)",
  "Chinese Taipei (59)",
  "Tajikistan (11)",
  "Tanzania (3)",
  "Thailand (42)",
  "Togo (4)",
  "Tonga (6)",
  "Trinidad and Tobago (22)",
  "Tunisia (63)",
  "Turkey (108)",
  "Turkmenistan (9)",
  "Tuvalu (2)",
  "Uganda (21)",
  "Ukraine (155)",
  "United Arab Emirates (5)",
  "United States (613)",
  "Uruguay (11)",
  "Uzbekistan (63)",
  "Vanuatu (3)",
  "Venezuela (44)",
  "Vietnam (18)",
  "Virgin Islands (4)",
  "Yemen (5)",
  "Zambia (24)",
  "Zimbabwe (5)"
) 

# Remove that annoying number after each country's name
countries <- word(countries, 1, -2)

num_countries <- length(countries)
num_people <- length(people)
stopifnot(num_countries >= num_people)
max_countries_per_person <- ceiling(num_countries / num_people)

# For testing if desired, run the algorithm lots of times:
#N <- 100
#biggest_loss <- rep(NA_real_, N)
#biggest_win <- rep(NA_real_, N)
#for (seed in 1:N) {
  
# Control the randomness of the procedure  
seed <- 12345 # Delete this if testing by running lots of times
  set.seed(seed)
  
# Make a vector in which each person appears the same number of times (equal
# to max_countries_per_person), of length equal to at least the number of countries,
# with the overflow containing each person at most once (so that there is at
# most a difference of 1 in the number of countries each person has).
shuffled_people <- unlist(map(1:max_countries_per_person, function(i) sample(people)))

# Truncate the overflow
shuffled_people <- shuffled_people[1:num_countries]

# Assign countries to the shuffled people
names(shuffled_people) <- countries

for (person in people) {
  cat(person, ":", paste(names(shuffled_people[shuffled_people == person]),
                         collapse = ", "),
      "\n\n")
}

# Part 2 of 2: calculate how much each person has won or lost ------------------

# 2016 winners from https://en.wikipedia.org/wiki/2016_Summer_Olympics_medal_table
# as an example for testing
df_winners <- read_csv("sweepstake_2021_olympics_2016_results_as_example.csv") %>%
  select(country, Gold) 

# For the sake of the example, remove previous winners who are not competing this year
df_winners <- df_winners %>%
  filter(country %in% countries)

# Add zero golds for countries missing from winners
df_winners <- df_winners %>%
  bind_rows(tibble(country = countries[! countries %in% df_winners$country], Gold = 0))

stopifnot(identical(sort(df_winners$country),
                    sort(countries)))

df_winners$person <- map_chr(df_winners$country,
                             function(country) shuffled_people[[country]])
df_winners <- df_winners %>% group_by(person) %>%
  summarise(total_golds = sum(Gold)) %>%
  mutate(winnings = total_golds - mean(total_golds)) 
df_winners

# Now calculate who should give whom how much to match those winnings that sum
# to zero, e.g. by using www.shortreckonings.com


# For testing if desired, running the algorithm lots of times:
#biggest_loss[[seed]] <- min(df_winners$winnings)
#biggest_win[[seed]] <- max(df_winners$winnings)
#}
#mean(biggest_win)
#mean(biggest_win)
