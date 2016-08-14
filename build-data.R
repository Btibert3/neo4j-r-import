options(stringsAsFactors = FALSE)

## load the packages
library(wakefield)
library(readr)
library(dplyr)

## create a dataset with wakefield
dat = r_data_frame(n = 1000, 
                   id,
                   race, 
                   sex,
                   internet_browser,
                   employment,
                   income)

## split out the person nodes
person = select(dat, ID, Race, Sex)
colnames(person) =  tolower(colnames(person))
person$race = as.character(person$race)
person$sex = as.character(person$sex)
colnames(person) = c("person_id:ID(Person)", "race", "sex")
write.table(person, file="data/person.csv", sep=",", row.names=F, na = "", col.names = FALSE)
person_header =  person[0,]
write.table(person_header, file="data/person_header.csv", sep=",", row.names=F, na = "", col.names = TRUE)

## split out browser node
browser = dat %>% group_by(Browser) %>% summarise(tot = n())
browser$tot = NULL
browser$id = 1:nrow(browser)
browser =  browser %>% select(id, Browser)
colnames(browser) = c("browser_id:ID(Browser)", "name")
browser$name = as.character(browser$name)
write.table(browser, file="data/browser.csv", sep=",", row.names=F, na="", col.names = FALSE)
browser_header =  browser[0,]
write.table(browser_header, file="data/browser_header.csv", sep=",", row.names=F, na = "", col.names = TRUE)

## the employment nodes
job = dat %>% group_by(Employment) %>% summarise(tot = n())
job$tot = NULL
job$id = 1:nrow(job)
job =  job %>% select(id, Employment)
colnames(job) = c("job_id:ID(Employment)", "name")
job$name = as.character(job$name)
write.table(job, file="data/job.csv", sep=",", row.names=F, na="", col.names = FALSE)
job_header =  job[0,]
write.table(job_header, file="data/job_header.csv", sep=",", row.names=F, na = "", col.names = TRUE)

## the employment relationships 
## we will specify the relationship type as the same for all, and properties on the relationship
rel_browser = select(dat, ID, Employment, Income)
rel_browser$Employment = as.character(rel_browser$Employment)
job_temp = job
colnames(job_temp)[1] = "job_id"
rel_browser = left_join(rel_browser, job_temp, by = c("Employment" = "name"))
rel_browser = select(rel_browser, ID, Income, job_id)
colnames(rel_browser) = c(":START_ID(Person)", "income",":END_ID(Employment)")
write.table(rel_browser, file="data/rel_browser.csv", sep=",", row.names=F, na="", col.names = TRUE)

## ^^ in the import.sh file, the relationships parameter gets applied to all records
## database defined with the into parameter must not exist
system("bash import.sh")



