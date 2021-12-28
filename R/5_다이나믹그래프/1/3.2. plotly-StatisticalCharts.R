#2. Statistical Graph
#install.packages("plotly")
library(plotly)
#install.packages("plyr")
library(plyr)


#1) Error Bars

# Data ±¸¼º
Data_mean <- ddply(ToothGrowth, c("supp", "dose"), summarise, length = mean(len))
Data_sd <- ddply(ToothGrowth, c("supp", "dose"), summarise, length = sd(len))
Data <- data.frame(Data_mean, Data_sd$length)
Data <- rename(Data, c("Data_sd.length" = "sd"))
Data$dose <- as.factor(Data$dose)

#(1-1) Bar Chart with Error Bars
plot_ly(data = Data[which(Data$supp == 'OJ'),], x = ~dose, y = ~length, type = 'bar', 
        name = 'OJ', error_y = ~list(value = sd, color = '#000000')) %>%
  add_trace(data = Data[which(Data$supp == 'VC'),], name = 'VC')

#(1-2) Scatterplot with Error Bars
plot_ly(data = Data[which(Data$supp == 'OJ'),], x = ~dose, y = ~length, type = 'scatter', 
        mode = 'markers', name = 'OJ', error_y = ~list(value = sd, color = '#000000')) %>%
  add_trace(data = Data[which(Data$supp == 'VC'),], name = 'VC')

##(1-3) Line Graph with Error Bars
plot_ly(data = Data[which(Data$supp == 'OJ'),], x = ~dose, y = ~length, type = 'scatter', 
        mode = 'lines + markers', name = 'OJ', error_y = ~list(value = sd, color = '#000000')) %>%
  add_trace(data = Data[which(Data$supp == 'VC'),], name = 'VC')



#2) Box Plots
#(2-1) Basic Boxplot
set.seed(1)
plot_ly(y = ~rnorm(50), type = "box") %>% add_trace(y = ~rnorm(50, 1))

##(2-1) Horizontal Boxplot
set.seed(1)
plot_ly(x = ~rnorm(50), type = "box") %>% add_trace(x = ~rnorm(50, 1))

##(2-3) Adding Jittered Points
set.seed(1)
plot_ly(y = ~rnorm(50), type = "box", boxpoints = "all", jitter = 0.3, pointpos = -1.8)
# boxpoints = "??""    <==    "all" | "outliers" | "suspectedoutliers" | FALSE
set.seed(1)
plot_ly(y = ~rnorm(50), type = "box", boxpoints = "outliers", jitter = 0.3, pointpos = 1.8)


#(2-4) Styling Outliers
Y1 <- c(0.75, 5.25, 5.5, 6, 6.2, 6.6, 6.80, 7.0, 7.2, 7.5, 7.5, 7.75, 8.15,
        8.15, 8.65, 8.93, 9.2, 9.5, 10, 10.25, 11.5, 12, 16, 20.90, 22.3, 23.25)
Y2 <- c(0.75, 5.25, 5.5, 6, 6.2, 6.6, 6.80, 7.0, 7.2, 7.5, 7.5, 7.75, 8.15,
        8.15, 8.65, 8.93, 9.2, 9.5, 10, 10.25, 11.5, 12, 16, 20.90, 22.3, 23.25)
Y3 <- c(0.75, 5.25, 5.5, 6, 6.2, 6.6, 6.80, 7.0, 7.2, 7.5, 7.5, 7.75, 8.15,
        8.15, 8.65, 8.93, 9.2, 9.5, 10, 10.25, 11.5, 12, 16, 20.90, 22.3, 23.25)
Y4 <- c(0.75, 5.25, 5.5, 6, 6.2, 6.6, 6.80, 7.0, 7.2, 7.5, 7.5, 7.75, 8.15,
        8.15, 8.65, 8.93, 9.2, 9.5, 10, 10.25, 11.5, 12, 16, 20.90, 22.3, 23.25)

plot_ly(type = 'box') %>%
  add_boxplot(y = Y1,  jitter = 0.3, pointpos = -1.8, boxpoints = 'all',
              marker = list(color = 'rgb(7,40,89)'), line = list(color = 'rgb(7,40,89)'),
              name = "All Points") %>%
  add_boxplot(y = Y2,  name = "Only Whiskers", boxpoints = FALSE,
              marker = list(color = 'rgb(9,56,125)'), line = list(color = 'rgb(9,56,125)')) %>%
  add_boxplot(y = Y3, name = "Suspected Outlier", boxpoints = 'suspectedoutliers',
              marker = list(color = 'rgb(8,81,156)',
                            outliercolor = 'rgba(219, 64, 82, 0.6)',
                            line = list(outliercolor = 'rgba(219, 64, 82, 1.0)', outlierwidth = 2)),
              line = list(color = 'rgb(8,81,156)')) %>%
  add_boxplot(y = Y4, name = "Whiskers and Outliers", boxpoints = 'outliers',
              marker = list(color = 'rgb(107,174,214)'), line = list(color = 'rgb(107,174,214)')) %>%
  layout(title = "Box Plot Styling Outliers")


##(2-5) Several Box Plots
plot_ly(ggplot2::diamonds, y = ~price, color = ~cut, type = "box")

##(2-6) Grouped Box Plots
plot_ly(ggplot2::diamonds, type = "box", x = ~cut, y = ~price, color = ~clarity) %>%
  layout(boxmode = "group")



#3) Histograms
#(3-1) Basic Histogram
set.seed(1)
plot_ly(x = ~rnorm(50), type = "histogram")

##(3-2) Normalized Histogram
set.seed(1)
plot_ly(x = ~rnorm(50), type = "histogram", histnorm = "probability")


##(3-3) Specify Binning Function
X = c("Apples","Apples","Apples","Organges", "Bananas")
Y = c("5","10","3","10","5")
plot_ly(y = Y, x = X, histfunc ='sum', type = "histogram") %>%  layout(yaxis = list(type ='linear'))
# type = ' '      <=  'linear' |  ' log' |  'date'   . . . 
# histfunc = ' '  <=   "count" | "sum" | "avg" | "min" | "max"


##(3-4) Horizontal Histogram
set.seed(1)
plot_ly(y = ~rnorm(50), type = "histogram")


##(3-5) Overlaid Histograms
set.seed(1)
plot_ly(alpha = 0.5) %>% add_histogram(x = ~rnorm(500)) %>%
  add_histogram(x = ~rnorm(500) + 1) %>% layout(barmode = "overlay")


##(3-6) Cumulative Histogram
set.seed(1)
plot_ly(x = ~rnorm(50), type = "histogram", cumulative = list(enabled=TRUE))



#4) 2D Histograms
#(4-1) Basic 2D Histogram
set.seed(1)
S <- matrix(c(1, -.75, -.75, 1), ncol = 2)
Obs <- mvtnorm::rmvnorm(500, sigma = S)
BP <- plot_ly(x = Obs[,1], y = Obs[,2])

subplot(BP %>% add_markers(alpha = 0.2), BP %>% add_histogram2d())

##(4-2) Colorscale
BP %>% add_histogram2d(colorscale = "Greens")


##(4-3) Z Matrix
Cnt <- with(diamonds, table(cut, clarity))
plot_ly(diamonds, x = ~cut, y = ~clarity, z = ~Cnt) %>%  add_histogram2d()



#5) 2D Histogram Contour
#(5-1) Basic 2D Histogram Contour
set.seed(1)
Sigma <- matrix(c(1, -.75, -.75, 1), ncol = 2)
Obs <- mvtnorm::rmvnorm(500, sigma = Sigma)

plot_ly(x = Obs[,1], y = Obs[,2]) %>% add_trace(type='histogram2dcontour')


##(5-2) Styled 2D Histogram Contour
Count <- with(diamonds, table(cut, clarity))
Contours <- list(showlabels = T, labelfont = list(family = 'Raleway', color = 'white'))
Hoverlabel <- list(bgcolor = 'white', bordercolor = 'black',
                   font = list(family = 'Raleway', color = 'black'))
plot_ly(diamonds, x = ~cut, y = ~clarity, z = ~Count) %>%
  add_trace(type='histogram2dcontour', contours = Contours, hoverlabel = Hoverlabel)


##(5-3) 2D Histogram Contour Subplot
set.seed(1);    X <- rnorm(1000) ;    Y <- rnorm(1000)
P1 <- plot_ly(x = X, color = I("blue"), type = 'histogram')
P2 <- plotly_empty(type="scatter", mode="markers")
P3 <- plot_ly(x = X, y = Y, type = 'histogram2dcontour', showscale = F) 
P4 <- plot_ly(y = Y, color = I("black"), type = 'histogram')
BP <- subplot(P1, P2, P3, P4, nrows = 2, heights = c(0.2, 0.8), widths = c(0.8, 0.2), 
              shareX = TRUE, shareY = TRUE, titleX = FALSE, titleY = FALSE)
layout(BP, showlegend = FALSE)



#6) Violin Plots 
#(6-1) Basic Violin Plot
#Df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/violin_data.csv")
#write.table(Df, file = "violin_data.csv", sep = ",")
Df <- read.csv("violin_data.csv")

Df %>% plot_ly(y = ~total_bill, type = 'violin', box = list(visible = T),
               meanline = list(visible = T), x0 = 'Total Bill') %>% 
       layout(yaxis = list(title = "", zeroline = F))


Df %>% plot_ly(y = ~total_bill, type = 'violin', box = list(visible = F),
               meanline = list(visible = T), x0 = 'Total Bill') %>% 
  layout(yaxis = list(title = "", zeroline = F))

#(6-2) Multiple Trace
Df %>% plot_ly(x = ~day, y = ~total_bill, split = ~day, type = 'violin', box = list(visible = T),
               meanline = list(visible = T)) %>% 
       layout(xaxis = list(title = "Day"), yaxis = list(title = "Total Bill", zeroline = F))

#(6-3) Grouped Violin Plot
Df %>% 
  plot_ly(type = 'violin') %>%
  add_trace(x = ~day[Df$sex == 'Male'], y = ~total_bill[Df$sex == 'Male'],
            legendgroup = 'Male', scalegroup = 'Male', name = 'Male', box = list(visible = T ), 
            meanline = list(visible = T ), line = list(color = 'blue') ) %>%
  add_trace(x = ~day[Df$sex == 'Female'], y = ~total_bill[Df$sex == 'Female'],
            legendgroup = 'Female', scalegroup = 'Female', name = 'Female', box = list(visible = T),
            meanline = list(visible = T), line = list(color = 'pink')) %>% 
  layout(yaxis = list(zeroline = F), violinmode = 'group')



#7) Splom of the Iris data set
#Df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/iris-data.csv')
#write.table(Df, file = "iris-data.csv", sep = ",")

Df <- read.csv("iris-data.csv")
Colorscale = list(c(0.0, '#19d3f3'), c(0.333, '#19d3f3'), c(0.333, '#e763fa'),
                  c(0.666, '#e763fa'), c(0.666, '#636efa'), c(1, '#636efa'))
Axis = list(showline = FALSE, zeroline = FALSE, gridcolor = '#ffff', ticklen=4)
Dimensions = list(list(label = 'sepal length', values = ~sepal.length),
                  list(label = 'sepal width', values = ~sepal.width),
                  list(label = 'petal length', values = ~petal.length),
                  list(label = 'petal width', values = ~petal.width))
Marker = list(color = as.integer(Df$class), colorscale = Colorscale, size = 7, 
              line = list( width = 1, color = 'rgb(230,230,230)'))
Xaxis = list(domain = NULL, showline =F, zeroline =F, gridcolor = '#ffff', ticklen = 4)
Yaxis = list(domain = NULL, showline =F, zeroline =F, gridcolor = '#ffff', ticklen = 4)
Plot_bgcolor = 'rgba(240,240,240, 0.95)'
Df %>% 
  plot_ly() %>%
  add_trace(type = 'splom', dimensions = Dimensions, text = ~class, marker = Marker) %>%
  layout(title = 'Iris Data set', hovermode ='closest', dragmode = 'select',
         plot_bgcolor = Plot_bgcolor, xaxis = Xaxis, yaxis = Yaxis,
         xaxis2 = Axis, xaxis3 = Axis, xaxis4 = Axis,
         yaxis2 = Axis, yaxis3 = Axis, yaxis4 = Axis)