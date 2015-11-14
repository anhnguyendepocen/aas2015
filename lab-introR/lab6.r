# R script to lab session 6, "Introduction to R".
# Available at https://github.com/erikgahner/aas2015

# As you can se, "#" in R is equivalent to "*" / "//" in Stata

# We can calculate stuff 
## Highlight the line and press CTRL+R (Windows) or CMD+R (Mac)
2+2             # Like "display 2+2" in Stata
50*149
3**2
2**3
sqrt(81)

# R work with objects. We can save everything in objects.
## The arrow is identical to using "=", but please stick to "<-"
x <- 2  ## You can also type 2 -> x

# Logical operations
x == 2
x == 3
x != 2
x < 1
x > 1
x <= 2
x >= 2.01

# What class is x?
class(x)

# By the way, R is case sensitive
class(X)  # x != X
Class(X)  # Class() != class()

# We can use our object for whatever we feel like
x
x + 2

x*x*x

y <- x + 2    # We can create a new object 
y

# List numbers 1 to 10
1:10

1:10 + 2

# We can also combine numbers into vectors and lists
c(2, 2)

# Let us save a numeric vector
x <- c(14, 6, 23, 2)
x * 2

# Is it a numeric vector?
is.numeric(x)
is.character(x)   # We will get to characters in a moment

# What is the second number?
x[2]

# Can we remove the second number? Yes.
x[-2]

length(x)
min(x)
max(x)
median(x)
sum(x)
mean(x)
var(x)

sd(x)

sqrt(var(x)) == sd(x) ## True dat.

x <- c(x, 5)
x

mean(x)

# Missing values: In R "NA" is equivalent to "." in Stata

x <- c(x, NA)

mean(x)

mean(x, na.rm=TRUE)

mean(x, na.rm=T)

?mean ### two marks question for online search: ??mean

# What about text?
z <- c("Venstre", "Socialdemokraterne") # note the quotation marks

z

class(z)

# We can add some more parties
party <- c(z, "Enhedslisten", "SF", "Radikale", "Konservative", "Dansk Folkeparti", "Liberal Alliance", "Alternativet")

rw <- c(1, 0, 0, 0, 0, 1, 1, 1, 0)

party

vote <- c(19.5, 26.3, 7.8, 4.2, 4.6, 3.4, 21.1, 7.5, 4.8)

seat <- c(34, 47, 14, 7, 8, 6, 37, 13, 9)

# Create a data frame
pol <- data.frame(party, vote, seat, rw)

# Show the data frame
pol 

# The class should be a data frame
class(pol)

# Show votes in data frame. Note the dollar sign.
pol$vote

max(pol$vote)

pol$party[1]

pol$party[pol$vote == max(pol$vote)]

pol$party[pol$vote == min(pol$vote)]

# What is the correlation between votes and seats? 
cor(pol$vote, pol$seat) # Almost 1
with(pol, cor(vote, seat))

# We can even plot stuff
plot(pol$vote, pol$seat)

# Let's make a better plot

# R has a lot of packages. We will intall the ggplot2 package
install.packages("ggplot2")

# Load the ggplot2 package
library("ggplot2")

# Your first plot. Notice the "+".
ggplot(pol, aes(x=vote, y=seat)) +  # ggplot(DATA.FRAME, aes( )) +
  geom_point(size=4)

# Use the minimal theme
ggplot(pol, aes(x=vote, y=seat)) +
  geom_point(size=4) +
  theme_minimal() 

# Create a variable with colours 
pol$rw.c <- ifelse(pol$rw==1, "blue", "red")

# Add colours
ggplot(pol, aes(x=vote, y=seat)) +
  geom_point(col=pol$rw.c, alpha=0.6, size=4) +
  theme_minimal() 

# Change x- and y-axis titles
ggplot(pol, aes(x=vote, y=seat)) +
  geom_point(col=pol$rw.c, alpha=0.6, size=4) +
  theme_minimal() +
  ylab("Seats") +
  xlab("Votes (%)")

# Add a label for the Social Democrats
ggplot(pol, aes(x=vote, y=seat)) +
  geom_point(col=pol$rw.c, alpha=0.6, size=4) +
  theme_minimal() +
  ylab("Seats") +
  xlab("Votes (%)") +
  geom_text(aes(label=ifelse(party == "Socialdemokraterne", "Social Democrats",''), hjust=1.1, vjust=0.5))


# Let's "open" some data, i.e. load data into a data frame
# The data is simulated data from LaCour & Green (2014)
lacour <- read.csv("lacoursciencedata.csv")

# We can view the data, similar to "browse" in Stata
View(lacour)

# We subset the data to the observations used in Simulation 1
lacour <- subset(lacour, STUDY == "Study 1")

# Before we go any further: Remember, if this was in Stata, our old data set would be gone.
# However, in R, we can have data frames in different objects at the same time
pol   # See, still there.

# Our data should be
class(lacour)

summary(lacour)

# Does feelings toward gays affect support for same sex marriage?
regression <- lm(SSM_Level ~ Therm_Level, data=lacour)  # In Stata: reg SSM_level Therm_Level
summary(regression)

# Let's see if people interviewed in Wave 2 are more likely to have positive feelings toward gays
regression <- lm(Therm_Change ~ Treatment_Assignment, data=lacour[lacour$wave==2 & lacour$Contact!="Secondary",])
summary(regression)

# Last, we can see all we have
ls()

# Do you want to remove something?
rm(x)

ls()

# Do you want to remove EVERYTHING!?
rm(list = ls())

ls()