# IS 360 Week 1 - Assignment
# 8/31/2014
# Re-submission
# Michael Hayes

# What version of R do you have installed?
version
# major 3
# minor 1.1

# What version of R-Studio do you have installed?
# Help -> About R-Studio
# Version 0.98.1028

# What version of PostgreSQL do you have installed?
# C:\Program Files\Postgresql\9.3\bin\pg_config
# Version = PostgreSQL 9.3.5

# Install and load the R package DMwR. Load the data set sales and determine the number of observations contained in the data set.
install.packages("DMwR")
require("DMwR")
data(sales)
View(sales)
# 401146 Observations
