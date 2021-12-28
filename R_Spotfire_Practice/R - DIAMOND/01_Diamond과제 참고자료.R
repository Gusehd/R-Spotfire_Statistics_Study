##Now let us test the power of RStudio with the diamonds set. 
##This is a good example of how powerful R can be running large sets of data.

library(GGally)
ggpairs(data = diamonds[1:10],
        title = "Iris Correlation Plot",
        upper = list(continuous = wrap("cor", size = 5)), 
        lower = list(continuous = "smooth")
)
library(car)
par(mfrow=c(3,2))
scatterplot(diamonds$carat,diamonds$price)
scatterplot(diamonds$depth,diamonds$price)
scatterplot(diamonds$table,diamonds$price)
scatterplot(diamonds$x,diamonds$price)
scatterplot(diamonds$y,diamonds$price)
scatterplot(diamonds$z,diamonds$price)

par(mfrow=c(3,2))
ggplot(iris, aes(diamonds$carat,diamonds$price))  + geom_point(aes(colour = diamonds$price))
ggplot(iris, aes(diamonds$depth,diamonds$price))  + geom_point()
ggplot(iris, aes(diamonds$table,diamonds$price))  + geom_point()
ggplot(iris, aes(diamonds$x,diamonds$price))  + geom_point()
ggplot(iris, aes(diamonds$y,diamonds$price))  + geom_point()
ggplot(iris, aes(diamonds$z,diamonds$price))  + geom_point()
library(ggplot2)

data(diamonds)
summary(diamonds)

dim(diamonds)

##We can answer how many observations (53,940), how many variables (only 10), 
##and how many of those variables are ordered factor (only 3). 
##We can also learn about the best diamond color by using the command ?diamonds.

##Let¡¯s test the power now of GGplot2 with a simple histogram of diamond prices.

ggplot(data=diamonds) + 
  geom_histogram(binwidth=500, aes(x=diamonds$price)) + 
  ggtitle("Diamond Price Distribution") + 
  xlab("Diamond Price U$") + ylab("Frequency") + theme_minimal()

g <- ggplot(data=diamonds, aes(x=clarity))
g + geom_bar()



##This is a long tail distribution, with a high concentration of observations below 
##the U$5,000 mark. We can get mean and median by running simple R commands:

mean(diamonds$price)

median(diamonds$price)

##Supposed we want to know the following:
##How many cost less than U$500?
##How many cost less than U$250?
##How many cost equal to U$15,000 or more?

sum(diamonds$price < 500)

sum(diamonds$price < 250)

sum(diamonds$price >= 15000)

##Let¡¯s get closer to that peak
##There is a very visible peak in the histogram. 
##It comes very early in the analysis #of the chart. 
##Let¡¯s get very close to observe the higher than expected frequency.

##This is a first attempt:

ggplot(data=diamonds) +
 geom_histogram(binwidth=500, aes(x=diamonds$price)) +
 ggtitle("Diamond Price Distribution") +
 xlab("Diamond Price U$ - Binwidth 500") + 
 ylab("Frequency") + theme_minimal() + xlim(0,2500)


##A little blocky? The binwidth is definitively not the best, 
##as we left it at 500 and #put a limit of value to less than U$2,500. 
##Maybe we should lower the binwidth to #see how that changes the picture:

ggplot(data=diamonds) +
 geom_histogram(binwidth=100, aes(x=diamonds$price)) +
 ggtitle("Diamond Price Distribution") +
 xlab("Diamond Price U$- Binwidth 100") +
 ylab("Frequency") + theme_minimal() + xlim(0,2500)


##Did you see what happened? 
##By changing geom_histogram(binwidth=100 the frequency dropped from 10,000 to 2,000
##in diamonds between U$500 and U$1,000. 
##This is a real change in the graph but impossible to see 
##unless you change the #bins manually. Let¡¯s kick it up one notch with bins of 50:

ggplot(data=diamonds) +
 geom_histogram(binwidth=50, aes(x=diamonds$price)) +
 ggtitle("Diamond Price Distribution") +
 xlab("Diamond Price U$ - Binwidth 50") +
 ylab("Frequency") + theme_minimal() + xlim(0,2500)


##Another drop in frequency, this time to no more than 1,500. 
##That is the reason Data Scientist are actual people and RStudio and 
##R haven¡¯t taken over!
##Bin selection will play a significant role in visualizations, 
##with a possible change in frequency readouts and shape of the curve or function.
##UDACITY thinks that asking for five histograms, broken down by cut, 
##was going to be a challenge. 
##Sadly for them, and luckily for aspiring Data Scientits like us, 
##this is not the case with R and ggplot2. 
##Using the facet_wrap(~cut) command is almost too easy to produce the graphs:

ggplot(data=diamonds) +
 geom_histogram(binwidth=100, aes(x=diamonds$price)) +
 ggtitle("Diamond Price Distribution by Cut") +
 xlab("Diamond Price U$") + ylab("Frequency") + theme_minimal() + facet_wrap(~cut)


##What if we want to see the cut for the highest priced diamond? 
##This one is a little tricky, but the easiest way is to subset the diamonds data 
##using as the filter the logical expression price == max(price). 
##It is unusual but it works.

subset(diamonds, price == max(price))

##And the answer is Premium cut for a diamond of 2.29 carat that sold at U$18,823! 
##Getting the cut of the lowest priced diamond is a similar task.

subset(diamonds, price == min(price))

##Looks like we have a tie between to units, both sold at U$326, 
##one of 0.23 carat and Ideal cut, and another of 0.21 carats and Premium cut.

##The last question is which cut has the lowest median price. 
##This one is VERY tricky, since it involves lots of query in the data. 
##The long and easy way is to use the which command to subset data vectors and 
##then get the median of those:

a = diamonds[which(diamonds$cut == "Fair"),]
b = diamonds[which(diamonds$cut == "Good"),]
c = diamonds[which(diamonds$cut == "Very Good"),]
d = diamonds[which(diamonds$cut == "Premium"),]
e = diamonds[which(diamonds$cut == "Ideal"),]

library(car)
scatterplot(diamonds$price,diamonds$clarity)

median(a$price)

median(b$price)

median(c$price)

median(d$price)

median(e$price)

##Going back to our grid histogram, let¡¯s get different frequency scales (the y axis)
##to accomodate for specific patterns. 
##It¡¯s harder to see patterns if all five charts use the same scale 
##for comparison and patterns become lost in the translation. 
##The command is very easy.

ggplot(data=diamonds) +
 geom_histogram(binwidth=100, aes(x=diamonds$price)) +
 ggtitle("Diamond Price Distribution by Clarity") +
 xlab("Diamond Price U$") + ylab("Frequency") +
 theme_minimal() + facet_wrap(~clarity, scales="free_y")


##You can now see how different graphs have different Y scales. 
##For example Fair cut diamonds have a Y scale maximizing at 600, 
##while Ideal diamonds have a Y scale topping at 2,500. 
##This is just the effect of using scale="free_y" in the facet_wrap layer.
##Let¡¯s work now on plotting price per carat of different cuts.

ggplot(data=diamonds) +
 geom_histogram(binwidth=50, aes(x=diamonds$price/diamonds$carat)) +
 ggtitle("Diamond Price per Carat Distribution by Cut") +
 xlab("Diamond Price per Carat U$") + ylab("Frequency") +
 theme_minimal() + facet_wrap(~cut)


##UDACITY also asks for log10 scale. 
##Let¡¯s work now on plotting price per carat of different cuts and using Log10.

ggplot(data=diamonds) +
 geom_histogram(binwidth=0.01, aes(x=diamonds$price/diamonds$carat)) +
 ggtitle("Diamond Price per Carat Distribution by Cut") +
 xlab("Diamond Price per Carat U$ - LOG 10 Scale") +
 ylab("Frequency") + theme_minimal() + facet_wrap(~cut) + scale_x_log10()


##It¡¯s easier to see how price per carat raises with cut quality. 
##Notice how I change the bin size to make sense on Log10 scale (else it look terrible¡¦)

##A loook into boxplots
##The next assignmen is about investigating the price of diamonds using box plots,
##numerical summaries, and one of the following categorical variables: 
##cut, clarity, or color.

ggplot(diamonds, aes(factor(cut), price, fill=cut)) +
 geom_boxplot() + ggtitle("Diamond Price according Cut") + 
 xlab("Type of Cut") + ylab("Diamond Price U$") + coord_cartesian(ylim=c(0,20000))


##It¡¯s hard to draw conclusions; 
##it seems that cut of all types carry prices of all types, 
##not really a way to determine how good or expensive a diamond is. 
##I suspect people never take a magnifying glass and really look at 
##the cut when they choose a diamond unless they are true proffesionals. 
##Let¡¯s see the same chart using clarity

ggplot(diamonds, aes(factor(color), price, fill=color)) +
 geom_boxplot() + ggtitle("Diamond Price according Color") +
 xlab("Color") + ylab("Diamond Price U$") + coord_cartesian(ylim=c(0,20000))


##OK! This is more meaningful, we even get a few outliers 
##(I limited the number of outliers by using xlim=c(0,7500)) or no more than 
##U$7,500 dollars. So clarity is a meaningful variable where cut is not. 
##We can conclude people see and appreciate more shiny things?

##The next part is answering four questions about color and price range inside 
##a IQR range. These are the following.

##What is the price range for the middle 50% of diamonds with color D (best color)?
##What is the price range for the middle 50% of diamonds with color J (worst color)?
##What is the IQR for diamonds with the best color (color D)?
##What is the IQR for diamonds with the worst color (color J)?
##To use some instructor notes,we can use the function IQR() to find 
##the interquartile range. Pass it a subset of the diamonds data frame. 
##For example IQR(subset(diamonds, price <1000)$price) subset returns 
##a data frame (so we need to use $price on the end to access that variable.)

##However for some reason this method did not work for me, 
##so I decided to simply create a subset and take it from there.

d = subset(diamonds, diamonds$color == 'D')
j = subset(diamonds, diamonds$color == 'J')

summary(d)

IQR(d$price)

summary(j)

IQR(j$price)


##This is very strange (the results are fine), 
##people actually pay more on average for a J color diamonds (worst color) than
##for a D color diamond (best color)!

##How about we investigate the price per carat of diamonds across 
##the different colors of diamonds using boxplots? 
##This sounds like a big effort but it¡¯s actually just a little change of code.

ggplot(diamonds, aes(factor(color), (price/carat), fill=color)) +
 geom_boxplot() + ggtitle("Diamond Price per Carat according Color") +
 xlab("Color") + ylab("Diamond Price per Carat U$")


##**Now that is a big quantity of outliers for color D. 
##I can see where people spend their money, not on the under U$7,500 range, 
##but rather on the most unique rocks. 
##We can limit the price range to under U$7,500 and see a smaller picture.

ggplot(diamonds, aes(factor(color), (price/carat), fill=color)) +
 geom_boxplot() + ggtitle("Diamond Price per Carat according Color")+ 
 xlab("Color") + ylab("Diamond Price per Carat U$") +
 coord_cartesian(ylim=c(0,7500))


##How strange, under the U$7,500 range the price per carat of diamonds is 
##actually more expensive on color G (medium quality on the scale) than 
##any other color.

##The more I study these charts, the more I see that people know very little
##about diamonds, and pay way more for medium-quality rocks 
##because cut, color and clarity are still very hard to define and detect 
##for the untrained eye.

##For the next question, we will investigate carat weight using 
##a frequency polygon chart. 
##I have not used many of this type of chart, so let¡¯s see what we get.

ggplot(data=diamonds, aes(x=carat)) + geom_freqpoly() +
 ggtitle("Diamond Frequency by Carat") + xlab("Carat Size") + ylab("Count")

## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.

##RStudio complains about binwidth not being accurate. 
##Let¡¯s adjust (quick Google of where to change binwidth, I keep forgetting¡¦)

ggplot(data=diamonds, aes(x=carat)) + geom_freqpoly(binwidth = 0.025) +
 ggtitle("Diamond Frequency by Carat") + xlab("Carat Size") +
 ylab("Count") + scale_x_continuous(minor_breaks = seq(0, 5.5, 0.1))


##Mind you, this is counting occurrences and not price per carat. 
##I tried that and got a very criptice message Error : 
## Mapping a variable to y and also using stat=¡°bin¡±. With stat=¡°bin¡±, 
##it will attempt to set the y value to the count of cases in each group. 
##This can result in unexpected behavior and will not be allowed in a future version
##of ggplot2. If you want y to represent counts of cases, 
##use stat=¡°bin¡± and don¡¯t map a variable to y. 
##If you want y to represent values in the data, use stat=¡°identity¡±. 
##See ?geom_bar for examples. (Defunct; last used in version 0.9.2)
##But as you can see, bigger rocks are hard to come by.
##Well, this has been probably my biggest work to-date with R Markdown. 
##What can I say? I love it!
library(GGally)
ggpairs(data = diamonds[1:4],
        title = "Iris Correlation Plot",
        upper = list(continuous = wrap("cor", size = 5)), 
        lower = list(continuous = "smooth")
)


####################################################################
####################################################################


##1. Let¡¯s consider the price of a diamond and it¡¯s carat weight.
##   Create a scatterplot of price (y) vs carat weight (x), 
##   and limit the x-axis and y-axis to omit the top 1% of values.

ggplot(diamonds,aes(x=carat,y=price))+
  geom_point(color='blue',fill='blue')+
  xlim(0,quantile(diamonds$carat,0.99))+
  ylim(0,quantile(diamonds$price,0.99))+
  ggtitle('Diamond price vs. carat')

## Notice it looks like the price increases kind of exponentially against carat, 
##        but it gets diverse when the carat increases.

## 2. Let¡¯s sample 10,000 from diamonds data set and then use 
##    ggpairs to generate the pair-wise variables relationship

#install.packages("GGally")
library(GGally)
set.seed(20022012)
diamonds_samp <- diamonds[sample(1:length(diamonds$price),10000),]
ggpairs(diamonds_samp)

##ggpairs(diamonds_samp, params = c(shape=I('.'),outlier.shape=I('.')))


## We notice the followings:
## - diamond price is almost linearly correlated with x, y, z and carat; 
##    These are the critical factors driving price
## - diamond price seems related to cut/color/clarity 
##     but is not very clear from this plot
## - diamond price seems not directly related to depth and table


## 3. Create two histograms of the price variable, one is of price and 
##    the 2nd is log10 transformation of price, and place them side by side 
##    on one output image.

library(gridExtra)
plot1 <- ggplot(diamonds,aes(x=price))+
  geom_histogram(color='blue',fill = 'blue',binwidth=100)+
  scale_x_continuous(breaks=seq(300,19000,1000),limit=c(300,19000))+
  ggtitle('Price')
plot2 <- ggplot(diamonds,aes(x=price))+
  geom_histogram(color='red',fill='red',binwidth=0.01)+
  scale_x_log10(breaks=seq(300,19000,1000),limit=c(300,19000))+
  ggtitle('Price(log10)')
grid.arrange(plot1,plot2,ncol=2)

##  It¡¯s obviously that the price histogram is skewed to the left side 
##  while the log10(price) tends to bell curve distributed. 
##  Also, the two peaks in the log10(price) plot coincides 
##  with the 1st and 3rd quantile of price.

## 4. Create scatter plot by log10 transforming price on y axis 
##    and cuberoot transforming carat on x axis

### Create a new function to transform the carat variable

library(scales)
cuberoot_trans = function() trans_new('cuberoot',
                                      transform = function(x) x^(1/3),
                                      inverse = function(x) x^3)

## Use the cuberoot_trans function
library(ggplot2)
ggplot(aes(carat, price), data = diamonds) + 
  geom_point(color='blue',fill='blue',alpha=1/2,size=1,position = 'jitter') + 
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 3),
                     breaks = c(0.2, 0.5, 1, 2, 3)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 15000),
                     breaks = c(350, 1000, 5000, 10000, 15000)) +
  ggtitle('Price (log10) by Cube-Root of Carat')


## Now the log10(price) is almost linear with cuberoot of carat 
## - we can move on to the modeling.

## 5. Let¡¯s see if other factors have some impact on price. Clarity first.

ggplot(aes(x = carat, y = price), data = diamonds) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter',aes(color=clarity)) +
  scale_color_brewer(type = 'div',
                     guide = guide_legend(title = 'Clarity', reverse = T,
                                          override.aes = list(alpha = 1, size = 2))) +                         
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 3),
                     breaks = c(0.2, 0.5, 1, 2, 3)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 15000),
                     breaks = c(350, 1000, 5000, 10000, 15000)) +
  ggtitle('Price (log10) by Cube-Root of Carat and Clarity')


## It¡¯s clear that Clarity factors into the diamond price 
## - a better clarity almost always has higher price than lower end clarity.

## 6. Now let¡¯s see if cut has similar impact on diamond price

ggplot(aes(x = carat, y = price), data = diamonds) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter',aes(color=cut)) +
  scale_color_brewer(type = 'div',
                     guide = guide_legend(title = 'Cut', reverse = T,
                                          override.aes = list(alpha = 1, size = 2))) +                         
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 3),
                     breaks = c(0.2, 0.5, 1, 2, 3)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 15000),
                     breaks = c(350, 1000, 5000, 10000, 15000)) +
  ggtitle('Price (log10) by Cube-Root of Carat and Cut')


## While cut plot does not show as obvious pattern as Clarity, 
## it¡¯s still clear that with the smae carat the diamonds with 
## the best cut are priced higher. Hence, I think cut should be also included 
## in the price prediction algorithm.

## 7. Now let¡¯s see if color accounts for any variance of diamond price
ggplot(aes(x = carat, y = price), data = diamonds) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter',aes(color=color)) +
  scale_color_brewer(type = 'div',
                     guide = guide_legend(title = 'Color', reverse = F,
                                          override.aes = list(alpha = 1, size = 2))) +                         
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 3),
                     breaks = c(0.2, 0.5, 1, 2, 3)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 15000),
                     breaks = c(350, 1000, 5000, 10000, 15000)) +
  ggtitle('Price (log10) by Cube-Root of Carat and Color')


## This looks similar with previous Clarity plot and Color should be also 
## considered as an factor for price.

## 8. it¡¯s time to build out the price prediction model!
m1 <- lm(I(log10(price)) ~ I(carat^(1/3)), data = diamonds)
m1
m2 <- update(m1,~ . +carat)
m2
m3 <- update(m2,~ . +cut)
m3
m4 <- update(m3,~ . +color)
m4
m5 <- update(m4,~ . +clarity)
m5
##mtable(m1,m2,m3,m4,m5)




## the linear model for the diamond price is:
## Log(price)=
##  0.18+3.97carat1/3???0.474carat+pc5???cutcoef+pc7???colorcoef+pc8???claritycoef
## where pc5, pc7 and pc8 are polynomial contrast with n=5, 7, 8, respectively. 
## You can check the detail by applying contr.poly(n).

## 9. Pick a diamond and predict the price by using our new model.
##   I randomly take this diamond in this example:

##       carat       cut color clarity depth table price    x    y    z
## 13696     1 Very Good     G     VS2  61.8    59  5600 6.29 6.37 3.91

## Here is the code to get the predicted (fitted) price of this diamond 
## by using the linear model:

thisDiamond <- data.frame(carat=1, cut='Very Good',
                          color='G',clarity='VS2')
modelEstimate <- predict(m5,newdata = thisDiamond,
                         interval = "prediction",level = .95)
10^modelEstimate

## The predicted price is $5,232.11 vs. actual price $5,600.