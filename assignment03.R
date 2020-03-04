library(tidyverse)

IPEDS <- read_csv("IPEDS_data.csv")

glimpse(IPEDS)

IPEDS <- IPEDS %>%
  rename(enrollment_2018 = 'Grand total (EFFY2018  Undergraduate)') %>%
  rename(enrollment_2017 = 'Grand total (EFFY2017  Undergraduate)') %>%
  rename(enrollment_2016 = 'Grand total (EFFY2016  Undergraduate)') %>%
  rename(enrollment_2015 = 'Grand total (EFFY2015  Undergraduate)') %>%
  rename(enrollment_2014 = 'Grand total (EFFY2014  Undergraduate)') %>%
  rename(enrollment_2013 = 'Grand total (EFFY2013  Undergraduate)') %>%
  rename(enrollment_2012 = 'Grand total (EFFY2012  Undergraduate)') %>%
  rename(enrollment_2011 = 'Grand total (EFFY2011  Undergraduate)') %>%
  rename(enrollment_2010 = 'Grand total (EFFY2010  Undergraduate)') %>%
  rename(enrollment_2009 = 'Grand total (EFFY2009  Undergraduate)') %>%
  rename(state_abbrev = 'State abbreviation (HD2017)') %>%
  rename(state_tuition_2017 = 'Total price for in-state students living on campus 2017-18 (DRVIC2017)') %>%
  rename(applicants_2017 = 'Applicants total (ADM2017)') %>%
  rename(admissions_2017 = 'Admissions total (ADM2017)') %>%
  rename(SAT_math_2017 = 'SAT Math 75th percentile score (ADM2017)')

IPEDS <- IPEDS %>%
  mutate(admit_rate_2017 = admissions_2017/applicants_2017)

colours()

IPEDS %>%
  ggplot(mapping = aes(x = SAT_math_2017, y = admit_rate_2017)) + geom_point(color = "royal blue") +
  scale_y_continuous(lim = c(0, 1), breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1))

year <- c(2009:2018)
enrollment <- c(sum(IPEDS$enrollment_2009, na.rm = TRUE), 
                sum(IPEDS$enrollment_2010, na.rm = TRUE),
                sum(IPEDS$enrollment_2011, na.rm = TRUE), 
                sum(IPEDS$enrollment_2012, na.rm = TRUE),
                sum(IPEDS$enrollment_2013, na.rm = TRUE),
                sum(IPEDS$enrollment_2014, na.rm = TRUE),
                sum(IPEDS$enrollment_2015, na.rm = TRUE),
                sum(IPEDS$enrollment_2016, na.rm = TRUE),
                sum(IPEDS$enrollment_2017, na.rm = TRUE),
                sum(IPEDS$enrollment_2018, na.rm = TRUE))
                 
Annual_enrollment <- data.frame(year, enrollment)

Annual_enrollment %>%
  ggplot(mapping = aes(x = year, y = enrollment)) + geom_line(color = "forestgreen")

State_count <- IPEDS %>%
  count(state_abbrev) %>%
  arrange(desc(n))

State_count %>%
  ggplot(mapping = aes(x = reorder(state_abbrev, desc(n)), y = n)) + geom_col()

# Does the same thing as above set of code, but using geom_bar
IPEDS %>%
  ggplot(mapping = aes(x = reorder(state_abbrev, state_abbrev, function(x) -length(x)))) + 
           geom_bar()

IPEDS %>%
  add_column(y = 0) %>%
  ggplot(mapping = aes(x = state_tuition_2017, y = y, size = enrollment_2018)) + 
  geom_point(color = "maroon") + theme(legend.position = 'none') +
  scale_size_continuous(range = c(0.001, 5)) +
  scale_x_continuous(breaks = c(10000, 15000, 20000, 25000, 30000, 35000, 40000))


IPEDS %>%
  add_column(y = 0) %>%
  ggplot(mapping = aes(x = state_tuition_2017, y = y, size = enrollment_2018)) + 
  geom_point(color = "maroon") +
  scale_size_continuous(range = c(0.001, 5)) +
  scale_x_continuous(breaks = c(10000, 15000, 20000, 25000, 30000, 35000, 40000))




