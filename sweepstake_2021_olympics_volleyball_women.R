# As advertised in advance by WhatsApp
set.seed(956)

# In the order listed at https://en.wikipedia.org/wiki/Volleyball_at_the_2020_Summer_Olympics
teams <- c("Japan", "Serbia", "Brazil", "South Korea", "Dominican Republic", "Kenya",
           "China", "US", "Russia", "Italy", "Argentina", "Turkey")

# In the order Chris messaged
people <- c("Hannah", "Laia", "Linus", "Luis", "Moritz", "Rory", "Sam",
            "Stefan", "Suzie", "Peter", "Giulio", "Chris")

num_teams <- length(teams)
num_people <- length(people)
stopifnot(num_teams >= num_people)
max_teams_per_person <- ceiling(num_teams / num_people)

library(purrr)
# Make a vector in which each person appears the same number of times (equal
# to max_teams_per_person), of length equal to at least the number of teams,
# with the overflow containing each person at most once (so that there is at
# most a difference of 1 in the number of teams each person has).
shuffled_people <- unlist(map(1:max_teams_per_person, function(i) sample(people)))

# Truncate the overflow
shuffled_people <- shuffled_people[1:num_teams]

# Assign teams to the shuffled people
names(shuffled_people) <- teams

sort(shuffled_people)
# Russia        South Korea Dominican Republic          Argentina             Brazil              Italy              Japan              Kenya             Turkey             Serbia              China                 US 
# "Chris"           "Giulio"           "Hannah"             "Laia"            "Linus"             "Luis"           "Moritz"            "Peter"             "Rory"              "Sam"           "Stefan"            "Suzie" 