#참고 :   https://plot.ly/r/

#1. 기본 그래프(Basic Charts)

#(1-1) 첫 걸음

#install.packages("plotly")
#packageVersion('plotly')
library(plotly)
packageVersion('plotly')

str(midwest)
plot_ly(midwest, x = ~percollege, color = ~state, type = "box")

#  plotly's type 유형들
#(A) 기본형(Simple) : Scatter, Scatter GL, Bar, Pie, Heatmap, Contour, Table
#(B) 분포(Distributions) : Box, Violin, Histogram, Histogram 2D, Histogram 2D Contour
#(C) 금융(Finance) : OHLC, Candlestick, Waterfall, Funnel, Funnel Area
#(D) 3차원(3D) : Scatter 3D, Surface, Mesh, Cone, Streamtube, Volume, Isosurface
#(E) 지도(Maps) : Scatter Geo, Choropleth, Scatter Mapbox, Choropleth Mapbox, Density Mapbox
#(F) 기타(Specialized) : Scatter Polar, Scatter Polar GL, Bar Polar, Scatter Ternary, 
#                        Sunburst, Sankey, SPLOM,Parallel Coordinates, Parallel Categories,
#                        Carpet, Scatter Carpet, Contour Carpet


str(economics)
plot_ly(economics, type="histogram", x = ~pop)
plot_ly(economics, type='scatter', mode='lines', x = ~date, y = ~pop)


str(volcano)
plot_ly(z = ~volcano, type = "heatmap")
plot_ly(z = ~volcano, type = "surface")


add_lines(plot_ly(economics, x = ~date, y = ~unemploy/pop))
# pipe ("%>%")를 사용한 같은 예
economics %>% plot_ly(x = ~date, y = ~unemploy/pop) %>% add_lines()

plot_ly(economics, x = ~date, color = I("black")) %>%
   add_lines(y = ~uempmed) %>%
   add_lines(y = ~psavert, color = I("red"))


BP <- plot_ly(iris, x = ~Sepal.Width, y = ~Sepal.Length) 
add_markers(BP, symbol = ~Species)

add_paths(BP, linetype = ~Species)

apropos("^add_")


#(1-2) Scatter plot
#(1-2-1) Basic Scatter Plot
plot_ly(data = iris, type='scatter', mode='markers', x = ~Sepal.Length, y = ~Petal.Length)


#(1-2-2) Styled Scatter Plot
plot_ly(data = iris, type='scatter', mode='markers',x = ~Sepal.Length, y = ~Petal.Length,
               marker = list(size = 10, color = 'rgba(255, 182, 193, .9)',
               line = list(color = 'rgba(152, 0, 0, .8)', width = 2))) %>%
  layout(title = 'Styled Scatter', yaxis = list(zeroline = FALSE), xaxis = list(zeroline = FALSE))


#(1-2-3) Qualitative Colorscales
plot_ly(data = iris, type='scatter', mode = 'markers', 
        x = ~Sepal.Length, y = ~Petal.Length, color = ~Species)


#(1-2-4) ColorBrewer Palette Names
plot_ly(data = iris, type='scatter', mode = 'markers', 
        x = ~Sepal.Length, y = ~Petal.Length, color = ~Species, colors = "Set1")


#(1-2-5) Custom Color Scales
Pal <- c("red", "blue", "green")
plot_ly(data = iris, type='scatter', mode = 'markers', 
        x = ~Sepal.Length, y = ~Petal.Length, color = ~Species, colors = Pal)

Pal <- c("red", "blue", "green")
Pal <- setNames(Pal, c("virginica", "setosa", "versicolor"))
plot_ly(data = iris, type='scatter', mode = 'markers', 
             x = ~Sepal.Length, y = ~Petal.Length, color = ~Species, colors = Pal)


#(1-2-6) Mapping Data to Symbols
plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length, type = 'scatter',
        mode = 'markers', symbol = ~Species, symbols = c('circle','x','o'),
        color = I('black'), marker = list(size = 10))


#(1-2-7) Adding Color
set.seed(1)
Data <- diamonds[sample(nrow(diamonds), 1000), ]
plot_ly(Data, x = ~carat, y = ~price, type = 'scatter', mode = 'markers', color = ~price )

#(1-2-8) Data Labels on Hover
plot_ly(Data, x = ~carat, y = ~price, type = 'scatter', mode = 'markers',
        text = ~paste("가격: ", price, '$<br>Cut:', cut), color = ~carat)



#(1-3) Line Plot
#(1-3-1) Basic Line Plot
set.seed(1)
X <- c(1:100)
Rand_y <- rnorm(100, mean = 0)
Data <- data.frame(X, Rand_y)

plot_ly(Data, x = ~X, y = ~Rand_y, type = 'scatter', mode = 'lines')



#(1-3-2) Plotting Markers and Lines
set.seed(1)
Tr0 <- rnorm(100, mean = 5);  Tr1 <- rnorm(100, mean = 0)
Tr2 <- rnorm(100, mean = -5); X <- c(1:100)
Data <- data.frame(X, Tr0, Tr1, Tr2)

plot_ly(Data, x = ~X) %>%
   add_trace(y = ~Tr0, name = 'Tr0', type='scatter', mode = 'lines') %>%
   add_trace(y = ~Tr1, name = 'Tr1', type='scatter', mode = 'lines+markers') %>%
   add_trace(y = ~Tr2, name = 'Tr2', type='scatter', mode = 'markers')

## Same Result
plot_ly(Data, x = ~X, y = ~Tr0, name = 'tr0', type = 'scatter', mode = 'lines') %>%
   add_trace(y = ~Tr1, name = 'tr1', mode = 'lines+markers') %>%
   add_trace(y = ~Tr2, name = 'tr2', mode = 'markers')



#(1-3-3) Style Line Plots
Month <- c('January', 'February', 'March', 'April', 'May', 'June', 'July',
           'August', 'September', 'October', 'November', 'December')
High_2000 <- c(32.5, 37.6, 49.9, 53.0, 69.1, 75.4, 76.5, 76.6, 70.7, 60.6, 45.1, 29.3)
Low_2000 <- c(13.8, 22.3, 32.5, 37.2, 49.9, 56.1, 57.7, 58.3, 51.2, 42.8, 31.6, 15.9)
High_2007 <- c(36.5, 26.6, 43.6, 52.3, 71.5, 81.4, 80.5, 82.2, 76.0, 67.3, 46.1, 35.0)
Low_2007 <- c(23.6, 14.0, 27.0, 36.8, 47.6, 57.7, 58.9, 61.2, 53.3, 48.5, 31.0, 23.6)
High_2014 <- c(28.8, 28.5, 37.0, 56.8, 69.7, 79.7, 78.5, 77.8, 74.1, 62.6, 45.3, 39.9)
Low_2014 <- c(12.7, 14.3, 18.6, 35.5, 49.9, 58.0, 60.0, 58.6, 51.7, 45.2, 32.2, 29.1)

Data <- data.frame(Month, High_2000, Low_2000, High_2007, Low_2007, High_2014, Low_2014)

##The default order will be alphabetized unless specified as below:
Data$Month <- factor(Data$Month, levels = Data[["Month"]])

plot_ly(Data, x = ~Month, y = ~High_2014, name = 'High 2014', type = 'scatter', mode = 'lines',
             line = list(color = 'rgb(205, 12, 24)', width = 4)) %>%
   add_trace(y = ~Low_2014, name = 'Low 2014', line = list(color = 'rgb(22, 96, 167)', width = 4)) %>%
   add_trace(y = ~High_2007, name = 'High 2007', line = list(color = 'rgb(205, 12, 24)', width = 4, dash = 'dash')) %>%
   add_trace(y = ~Low_2007, name = 'Low 2007', line = list(color = 'rgb(22, 96, 167)', width = 4, dash = 'dash')) %>%
   add_trace(y = ~High_2000, name = 'High 2000', line = list(color = 'rgb(205, 12, 24)', width = 4, dash = 'dot')) %>%
   add_trace(y = ~Low_2000, name = 'Low 2000', line = list(color = 'rgb(22, 96, 167)', width = 4, dash = 'dot')) %>%
   layout(title = "뉴욕의 최고/최저 평균 기온",
          xaxis = list(title = "Months"), yaxis = list (title = "Temperature (degrees F)"))


#(1-3-4) Mapping data to linetype
library(plyr)
TG <- ddply(ToothGrowth, c("supp", "dose"), summarise, Length=mean(len))
plot_ly(TG, x = ~dose, y = ~Llength, type = 'scatter', mode = 'lines', linetype = ~supp, color = I('black')) %>%
   layout(title = '보충제 종류에 따른 기니피그의 치아 성장에 대한 비타민 C의 효과',
          xaxis = list(title = '복용량(mg/day)'), yaxis = list (title = '치아 길이'))


#(1-3-5) Connect Data Gaps
X <- c(1:15);  Y <- c(10, 20, NA, 15, 10, 5, 15, NA, 20, 10, 10, 15, 25, 20, 10)
Data <- data.frame(X, Y)
plot_ly(Data, x = ~X, y = ~Y, name = "Gaps", type = 'scatter', mode = 'lines') %>%
   add_trace(y = ~Y-5, name = "<b>No</b> Gaps", connectgaps = TRUE)


#(1-3-6) Line Interpolation Options
X <- c(1:5);     Y <- c(1, 3, 2, 3, 1)
plot_ly(x = ~X) %>%
   add_lines(y = ~Y, name = "linear", line = list(shape = "linear")) %>%
   add_lines(y = Y + 5, name = "spline", line = list(shape = "spline")) %>%
   add_lines(y = Y + 10, name = "vhv", line = list(shape = "vhv")) %>%
   add_lines(y = Y + 15, name = "hvh", line = list(shape = "hvh")) %>%
   add_lines(y = Y + 20, name = "vh", line = list(shape = "vh")) %>%
   add_lines(y = Y + 25, name = "hv", line = list(shape = "hv"))


#(1-3-7) Label Lines with Annotations
X <- c(2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2013)
Y_television <- c(74, 82, 80, 74, 73, 72, 74, 70, 70, 66, 66, 69)
Y_internet <- c(13, 14, 20, 24, 20, 24, 24, 40, 35, 41, 43, 50)
Data <- data.frame(X, Y_television, Y_internet)
Xaxis <- list(title = "", showline = TRUE, showgrid = FALSE, showticklabels = TRUE, 
              linecolor = 'rgb(204, 204, 204)', linewidth = 2, autotick = FALSE,
              ticks = 'outside', tickcolor = 'rgb(204, 204, 204)', tickwidth = 2,
              ticklen = 5, tickfont = list(family = 'Arial', size = 12, color = 'rgb(82, 82, 82)'))
Yaxis <- list(title = "", showgrid = FALSE, zeroline = FALSE, showline = FALSE, showticklabels = FALSE)
Margin <- list(autoexpand = FALSE, l = 100, r = 100, t = 110)

# Build the annotations
Television_1 <- list(xref = 'paper', yref = 'y', x = 0.05, y = Y_television[1], xanchor = 'right', 
                     yanchor = 'middle', text = ~paste('Television ', Y_television[1], '%'), 
                     font = list(family = 'Arial', size = 16, color = 'rgba(67,67,67,1)'), showarrow = FALSE)
Internet_1 <- list(xref = 'paper', yref = 'y', x = 0.05, y = Y_internet[1], xanchor = 'right', 
                   yanchor = 'middle', text = ~paste('Internet ', Y_internet[1], '%'), 
                   font = list(family = 'Arial', size = 16, color = 'rgba(49,130,189, 1)'), showarrow = FALSE)
Television_2 <- list(xref = 'paper', x = 0.95, y = Y_television[12], xanchor = 'left', yanchor = 'middle',
                     text = paste('Television ', Y_television[12], '%'),  
                     font = list(family = 'Arial', size = 16, color = 'rgba(67,67,67,1)'),  showarrow = FALSE)
Internet_2 <- list(xref = 'paper', x = 0.95, y = Y_internet[12], xanchor = 'left', yanchor = 'middle',
                   text = paste('Internet ', Y_internet[12], '%'),  
                   font = list(family = 'Arial', size = 16, color = 'rgba(67,67,67,1)'), showarrow = FALSE)
plot_ly(Data, x = ~X) %>%
   add_trace(y = ~Y_television, type = 'scatter', mode = 'lines', line = list(color = 'rgba(67,67,67,1)', width = 2))  %>%
   add_trace(y = ~Y_internet, type = 'scatter', mode = 'lines', line = list(color = 'rgba(49,130,189, 1)', width = 4)) %>%
   add_trace(x = ~c(X[1], X[12]), y = ~c(Y_television[1], Y_television[12]), type = 'scatter', mode = 'markers', 
             marker = list(color = 'rgba(67,67,67,1)', size = 8)) %>%
   add_trace(x = ~c(X[1], X[12]), y = ~c(Y_internet[1], Y_internet[12]), type = 'scatter', mode = 'markers', 
             marker = list(color = 'rgba(49,130,189, 1)', size = 12)) %>%
   layout(title = "Main Source for News", xaxis = Xaxis, yaxis = Yaxis, margin = Margin,
          autosize = FALSE, showlegend = FALSE, annotations = Television_1) %>%
   layout(annotations = Internet_1) %>%
   layout(annotations = Television_2) %>%
   layout(annotations = Internet_2)


#(1-3-8) Filled Lines
Month <- c('January', 'February', 'March', 'April', 'May', 'June', 'July',
           'August', 'September', 'October', 'November', 'December')
High_2014 <- c(28.8, 28.5, 37.0, 56.8, 69.7, 79.7, 78.5, 77.8, 74.1, 62.6, 45.3, 39.9)
Low_2014 <- c(12.7, 14.3, 18.6, 35.5, 49.9, 58.0, 60.0, 58.6, 51.7, 45.2, 32.2, 29.1)
Data <- data.frame(Month, High_2014, Low_2014)
Data$Average_2014 <- rowMeans(Data[,c("High_2014", "Low_2014")])
Data$Month <- factor(Data$Month, levels = Data[["Month"]])

# fill = 'tozeroy'    # fill = 'tonexty'     # fill = 'toself'

plot_ly(Data, x = ~Month, y = ~High_2014, type = 'scatter', mode = 'lines',
             line = list(color = 'transparent'), showlegend = FALSE, name = 'High 2014') %>%
   add_trace(y = ~Low_2014, type = 'scatter', mode = 'lines', fill = 'tonexty', fillcolor='rgba(0,100,80,0.2)', 
             line = list(color = 'transparent'), showlegend = FALSE, name = 'Low 2014') %>%
   add_trace(x = ~Month, y = ~Average_2014, type = 'scatter', mode = 'lines', line = list(color='rgb(0,100,80)'), 
             name = 'Average') %>%
   layout(title = "Average, High and Low Temperatures in New York", paper_bgcolor='rgb(255,255,255)', 
          plot_bgcolor='rgb(229,229,229)',
          xaxis = list(title = "Months", gridcolor = 'rgb(255,255,255)', showgrid = TRUE, showline = FALSE,
                       showticklabels = TRUE, tickcolor = 'rgb(127,127,127)', ticks = 'outside', zeroline = FALSE),
          yaxis = list(title = "Temperature (degrees F)", gridcolor = 'rgb(255,255,255)', showgrid = TRUE,
                       showline = FALSE, showticklabels = TRUE, tickcolor = 'rgb(127,127,127)', ticks = 'outside', 
                       zeroline = FALSE))


#(1-3-9) Density Plot
# 참고 : tapply(), lapply() 및 sapply() 
Dens <- with(diamonds, tapply(price, INDEX = cut, density))
Df <- data.frame(X = unlist(lapply(Dens, "[[", "x")), Y = unlist(lapply(Dens, "[[", "y")),  
                 cut = rep(names(Dens), each = length(Dens[[1]]$x)))
plot_ly(Df, x = ~X, y = ~Y, color = ~cut) %>%  add_lines()



#(1-4)Bar Charts
# 1-4-1 ~ 1-4-3
#(1-4-1) Basic Bar Chart
Animals <- c("giraffes", "orangutans", "monkeys")
SF_Zoo <- c(20, 14, 23)
LA_Zoo <- c(12, 18, 29)
Data <- data.frame(Animals, SF_Zoo, LA_Zoo)
plot_ly(Data, x = ~Animals, y = ~SF_Zoo, type = 'bar', name = 'SF Zoo')

#(1-4-2) Grouped Bar Chart
plot_ly(Data, x = ~Animals, y = ~SF_Zoo, type = 'bar', name = 'SF Zoo') %>%
   add_trace(y = ~LA_Zoo, name = 'LA Zoo') %>%
   layout(yaxis = list(title = 'Count'), barmode = 'group')

#(1-4-3) Stacked Bar Chart
plot_ly(Data, x = ~Animals, y = ~SF_Zoo, type = 'bar', name = 'SF Zoo') %>%
   add_trace(y = ~LA_Zoo, name = 'LA Zoo') %>%
   layout(yaxis = list(title = 'Count'), barmode = 'stack')


# 1-4-4 ~ 1-4-5
#(1-4-4) Bar Chart with Hover Text
X <- c('Product A', 'Product B', 'Product C')
Y <- c(20, 14, 23)
Y2 <- c(16,12,27)
Text <- c('27% market share', '24% market share', '19% market share')
Data <- data.frame(X, Y, Y2, Text)

plot_ly(Data, x = ~X, y = ~Y, type = 'bar', text = Text, marker = list(color = 'rgb(158,202,225)',
        line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
   layout(title = "", xaxis = list(title = ""), yaxis = list(title = ""))

#(1-4-5) Grouped Bar Chart with Direct Labels
#참조 textposition = 'auto'   'outside'    'inside'     'none'
Data %>% 
   plot_ly() %>%
   add_trace(x = ~X, y = ~Y, type = 'bar', text = Y, textposition = 'inside', 
             marker = list(color = 'rgb(158,202,225)', 
                           line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
   add_trace(x = ~X, y = ~Y2, type = 'bar', text = Y2, textposition = 'auto', 
             marker = list(color = 'rgb(58,200,225)', 
                           line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
   layout(title = "January 2013 Sales Report", barmode = 'group', 
          xaxis = list(title = ""), yaxis = list(title = ""))


#(1-4-6) Rotated Bar Chart Labels
X <- c('January','February','March','April','May','June','July','August','September','October','November','December')
Y1 <- c(20, 14, 25, 16, 18, 22, 19, 15, 12, 16, 14, 17)
Y2 <- c(19, 14, 22, 14, 16, 19, 15, 14, 10, 12, 12, 16)
Data <- data.frame(X, Y1, Y2)

##The default order will be alphabetized unless specified as below:
Data$X <- factor(Data$X, levels = Data[["X"]])

plot_ly(Data, x = ~X, y = ~Y1, type = 'bar', name = 'Primary Product', marker = list(color = 'rgb(49,130,189)')) %>%
   add_trace(y = ~Y2, name = 'Secondary Product', marker = list(color = 'rgb(204,204,204)')) %>%
   layout(xaxis = list(title = "", tickangle = 45), yaxis = list(title = ""), 
          margin = list(b = 100), barmode = 'group')


# 1-4-7 ~ 1-4-8
#(1-4-7) Customizing Bar Color
X <- c('Feature A', 'Feature B', 'Feature C', 'Feature D', 'Feature E')
Y <- c(20, 14, 23, 25, 22)
Data <- data.frame(X, Y)
plot_ly(Data, x = ~X, y = ~Y, type = 'bar', color = I("black")) %>%
   layout(title = "Features", xaxis = list(title = ""), yaxis = list(title = ""))

#(1-4-8) Customizing Individual Bar Colors
plot_ly(Data, x = ~X, y = ~Y, type = 'bar',
             marker = list(color = c('rgba(204,204,204,1)', 'rgba(222,45,38,0.5)',
                                     'rgba(204,204,204,1)', 'rgba(204,204,204,1)',
                                     'rgba(204,204,204,1)'))) %>%
   layout(title = "Least Used Features", xaxis = list(title = ""), yaxis = list(title = ""))


#(1-4-9) Customizing Individual Bar Widths
X= c(1, 2, 3, 5.5, 10);   Y= c(10, 8, 6, 4, 2)
Width = c(0.8, 0.8, 0.8, 3.5, 4)
Data <- data.frame(X, Y, Width)
plot_ly(Data) %>% add_bars(x= ~X, y= ~Y, width = ~Width  )


#(1-4-10) Customizing Individual Bar Base
plot_ly() %>%
   add_bars(x = c("2016", "2017", "2018"), y = c(500,600,700), base = c(-500,-600,-700), 
            marker = list(color = 'red'), name = 'expenses' ) %>%
   add_bars(x = c("2016", "2017", "2018"), y = c(300,400,700), base = 0,
            marker = list(color = 'blue'), name = 'revenue')


#(1-4-11) Mapping a Color Variable
#install.packages("dplyr")
library(dplyr)
ggplot2::diamonds %>% count(cut, clarity) %>%
   plot_ly(x = ~cut, y = ~n, type='bar', color = ~clarity)



#(1-4-12) Colored and Styled Bar Chart
X <- c(1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012)
RoW <- c(219, 146, 112, 127, 124, 180, 236, 207, 236, 263, 350, 430, 474, 526, 488, 537, 500, 439)
China <- c(16, 13, 10, 11, 28, 37, 43, 55, 56, 88, 105, 156, 270, 299, 340, 403, 549, 499)
Data <- data.frame(X, RoW, China)

plot_ly(Data, x = ~X, y = ~RoW, type = 'bar', name = 'Rest of the World',
             marker = list(color = 'rgb(55, 83, 109)')) %>%
   add_trace(y = ~China, name = 'China', marker = list(color = 'rgb(26, 118, 255)')) %>%
   layout(title = 'US Export of Plastic Scrap', 
          xaxis = list(title = "", tickfont = list(size = 14, color = 'rgb(107, 107, 107)')),
          yaxis = list(title = 'USD (millions)', titlefont = list( size = 16, color = 'rgb(107, 107, 107)'),
                       tickfont = list(size = 14, color = 'rgb(107, 107, 107)')), 
          legend = list(x = 0, y = 1, bgcolor = 'rgba(255, 255, 255, 0)', bordercolor = 'rgba(255, 255, 255, 0)'),
          barmode = 'group', bargap = 0.15)


#(1-4-13) Waterfall Bar Chart
X <- c('Product<br>Revenue','Services<br>Revenue','Total<br>Revenue',
       'Fixed<br>Costs','Variable<br>Costs','Total<br>Costs', 'Total<br>Profit')
Y <- c(400, 660, 660, 590, 400, 400, 340)
Base <- c(0, 430, 0, 570, 370, 370, 0)
Revenue <- c(430, 260, 690, 0, 0, 0, 0)
Costs <- c(0, 0, 0, 120, 200, 320, 0)
Profit <- c(0, 0, 0, 0, 0, 0, 370)
Text <- c('$430K', '$260K', '$690K', '$-120K', '$-200K', '$-320K', '$370K')
Data <- data.frame(X, Base, Revenue, Costs, Profit, Text)

##The default order will be alphabetized unless specified as below:
Data$X <- factor(Data$X, levels = Data[["X"]])

plot_ly(Data, x = ~X, y = ~Base, type = 'bar', marker = list(color = 'rgba(1, 1, 1, 0.1)')) %>%
   add_trace(y = ~Revenue, marker = list(color = 'rgba(55, 128, 191, 0.7)',
                                         line = list(color = 'rgba(55, 128, 191, 0.5)', width = 2))) %>%
   add_trace(y = ~Costs, marker = list(color = 'rgba(219, 64, 82, 0.7)',
                                       line = list(color = 'rgba(219, 64, 82, 0.5)', width = 2))) %>%
   add_trace(y = ~Profit, marker = list(color = 'rgba(50, 171, 96, 0.7)', 
                                        line = list(color = 'rgba(50, 171, 96, 0.5)', width = 2))) %>%
   layout(title = 'Annual Profit - 2015', xaxis = list(title = ""), yaxis = list(title = ""), barmode = 'stack', 
          paper_bgcolor = 'rgba(245, 246, 249, 1)', plot_bgcolor = 'rgba(245, 246, 249, 1)', showlegend = FALSE) %>%
   add_annotations(text = Text, x = X, y = Y, xref = "x", yref = "y", 
                   font = list(family = 'Arial', size = 14, color = 'rgba(245, 246, 249, 1)'), showarrow = FALSE)


#(1-4-14) Horizontal Bar Chart
#(1-4-14-1) Basic Horizontal Bar Chart
Y <- c('giraffes', 'orangutans', 'monkeys')
SF_Zoo <- c(20, 14, 23);  LA_Zoo <- c(12, 18, 29)
Data <- data.frame(Y, SF_Zoo, LA_Zoo)

plot_ly(Data, x = ~SF_Zoo, y = ~Y, type = 'bar', orientation = 'h')

#(1-4-14-2) Colored Horizontal Bar Chart
plot_ly(Data, x = ~SF_Zoo, y = ~Y, type = 'bar', orientation = 'h', name = 'SF Zoo',
        marker = list(color = 'rgba(246, 78, 139, 0.6)',
                      line = list(color = 'rgba(246, 78, 139, 1.0)', width = 3))) %>%
   add_trace(x = ~LA_Zoo, name = 'LA Zoo', 
             marker = list(color = 'rgba(58, 71, 80, 0.6)', 
                           line = list(color = 'rgba(58, 71, 80, 1.0)', width = 3))) %>%
   layout(barmode = 'stack', xaxis = list(title = ""), yaxis = list(title =""))


#(1-4-14-3) Color Palette for Bar Chart
Y <- c('The course was effectively<br>organized',
       'The course developed my<br>abilities and skills for<br>the subject',
       'The course developed my<br>ability to think critically about<br>the subject',
       'I would recommend this<br>course to a friend')
X1 <- c(21, 24, 27, 29);  X2 <-c(30, 31, 26, 24)
X3 <- c(21, 19, 23, 15);  X4 <- c(16, 15, 11, 18)
X5 <- c(12, 11, 13, 14)
Data <- data.frame(Y, X1, X2, X3, X4, X5)
Top_labels <- c('Strongly<br>agree', 'Agree', 'Neutral', 'Disagree', 'Strongly<br>disagree')
Data$Y <- factor(Data$Y, levels = Data[["Y"]])

plot_ly(Data, x = ~X1, y = ~Y, type = 'bar', orientation = 'h',
             marker = list(color = 'rgba(38, 24, 74, 0.8)',
                           line = list(color = 'rgb(248, 248, 249)', width = 1))) %>%
   add_trace(x = ~X2, marker = list(color = 'rgba(71, 58, 131, 0.8)')) %>%
   add_trace(x = ~X3, marker = list(color = 'rgba(122, 120, 168, 0.8)')) %>%
   add_trace(x = ~X4, marker = list(color = 'rgba(164, 163, 204, 0.85)')) %>%
   add_trace(x = ~X5, marker = list(color = 'rgba(190, 192, 213, 1)')) %>%
   layout(xaxis = list(title = "", showgrid = FALSE, showline = FALSE, showticklabels = FALSE, zeroline = FALSE, 
                       domain = c(0.15, 1)), 
          yaxis = list(title = "", showgrid = FALSE, showline = FALSE, showticklabels = FALSE, zeroline = FALSE), 
          barmode = 'stack', paper_bgcolor = 'rgb(248, 248, 255)', plot_bgcolor = 'rgb(248, 248, 255)', 
          margin = list(l = 120, r = 10, t = 140, b = 80), showlegend = FALSE) %>%
   ## labeling the y-axis
   add_annotations(xref = 'paper', yref = 'y', x = 0.14, y = Y, xanchor = 'right', text = Y, 
                   font = list(family = 'Arial', size = 12, color = 'rgb(67, 67, 67)'), showarrow = FALSE, align = 'right') %>%
   ## labeling the percentages of each bar (x_axis)
   add_annotations(xref = 'x', yref = 'y', x = X1 / 2, y = Y, text = paste(Data[,"X1"], '%'), 
                   font = list(family = 'Arial', size = 12, color = 'rgb(248, 248, 255)'), showarrow = FALSE) %>%
   add_annotations(xref = 'x', yref = 'y', x = X1 + X2 / 2, y = Y, text = paste(Data[,"X2"], '%'),
                   font = list(family = 'Arial', size = 12, color = 'rgb(248, 248, 255)'), showarrow = FALSE) %>%
   add_annotations(xref = 'x', yref = 'y', x = X1 + X2 + X3 / 2, y = Y, text = paste(Data[,"X3"], '%'),
                   font = list(family = 'Arial', size = 12, color = 'rgb(248, 248, 255)'), showarrow = FALSE) %>%
   add_annotations(xref = 'x', yref = 'y', x = X1 + X2 + X3 + X4 / 2, y = Y, text = paste(Data[,"X4"], '%'), 
                   font = list(family = 'Arial', size = 12, color = 'rgb(248, 248, 255)'), showarrow = FALSE) %>%
   add_annotations(xref = 'x', yref = 'y', x = X1 + X2 + X3 + X4 + X5 / 2, y = Y, text = paste(Data[,"X5"], '%'),
                   font = list(family = 'Arial', size = 12, color = 'rgb(248, 248, 255)'), showarrow = FALSE) %>%
   ## labeling the first Likert scale (on the top)
   add_annotations(xref = 'x', yref = 'paper', 
                   x = c(29/ 2, 29 + 24 / 2, 29 + 24 + 15 / 2, 29 + 24 + 15 + 18 / 2, 29 + 24 + 15 + 19 + 14 / 2),
                   y = 1.15, text = Top_labels, font = list(family = 'Arial', size = 12, color = 'rgb(67, 67, 67)'),
                   showarrow = FALSE)



#(1-4-14-4) Bar Chart with Line Plot
Y <- c('Japan', 'United Kingdom', 'Canada', 'Netherlands', 'United States', 'Belgium', 'Sweden',
       'Switzerland')
X_saving <- c(1.3586, 2.2623000000000002, 4.9821999999999997, 6.5096999999999996,
              7.4812000000000003, 7.5133000000000001, 15.2148, 17.520499999999998)
X_net_worth <- c(93453.919999999998, 81666.570000000007, 69889.619999999995, 78381.529999999999,
                 141395.29999999999, 92969.020000000004, 66090.179999999993, 122379.3)
Data <- data.frame(Y, X_saving, X_net_worth)

P1 <- plot_ly(x = ~X_saving, y = ~reorder(Y, X_saving), name = paste('Household savings, percentage of', 
                                                                     'household disposable income'), 
              type = 'bar', orientation = 'h',
              marker = list(color = 'rgba(50, 171, 96, 0.6)',
                            line = list(color = 'rgba(50, 171, 96, 1.0)', width = 1))) %>%
   layout(yaxis = list(showgrid = FALSE, showline = FALSE, showticklabels = TRUE, domain= c(0, 0.85)),
          xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE)) %>%
   add_annotations(xref = 'x1', yref = 'y', x = X_saving * 2.0 + 3,  y = Y,
                   text = paste(round(X_saving, 2), '%'), 
                   font = list(family = 'Arial', size = 12, color = 'rgb(50, 171, 96)'),
                   showarrow = FALSE)

P2 <- plot_ly(x = ~X_net_worth, y = ~reorder(Y, X_saving), name = 'Household net worth, Million USD/capita',
              type = 'scatter', mode = 'lines+markers', line = list(color = 'rgb(128, 0, 128)')) %>%
   layout(yaxis = list(showgrid = FALSE, showline = TRUE, showticklabels = FALSE,
                       linecolor = 'rgba(102, 102, 102, 0.8)', linewidth = 2, domain = c(0, 0.85)),
          xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE,
                       side = 'top', dtick = 25000)) %>%
   add_annotations(xref = 'x2', yref = 'y', x = X_net_worth, y = Y, text = paste(X_net_worth, 'M'),
                   font = list(family = 'Arial', size = 12, color = 'rgb(128, 0, 128)'),
                   showarrow = FALSE)

subplot(P1, P2) %>%
   layout(title = 'Household savings & net worth for eight OECD countries',
          legend = list(x = 0.029, y = 1.038, font = list(size = 10)), 
          margin = list(l = 100, r = 20, t = 70, b = 70), paper_bgcolor = 'rgb(248, 248, 255)',
          plot_bgcolor = 'rgb(248, 248, 255)') %>%
   add_annotations(xref = 'paper', yref = 'paper',  x = -0.14, y = -0.15,
                   text = paste('OECD (2015), Household savings (indicator),',
                                'Household net worth (indicator).doi:',
                                '10.1787/cfc6f499-en (Accessed on 05 June 2015)'),
                   font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
                   showarrow = FALSE)




#(1-5) Pie Charts
#(1-5-1) Basic Pie Chart

USPersonalExpenditure <- data.frame("Categorie"=rownames(USPersonalExpenditure), USPersonalExpenditure)
Data <- USPersonalExpenditure[,c('Categorie', 'X1960')]

#r타입을 파이로 두면 간단하게 파이차트를 그릴 수 있다.
plot_ly(Data, labels = ~Categorie, values = ~X1960, type = 'pie') %>%
   layout(title = 'United States Personal Expenditures by Categories in 1960')
 

#(1-5-2) Subplots
#install.packages("dplyr")
library(dplyr)

#애드 파이를 통해서 파이차트를 여러개 그릴 수 있다. 또한 텍스트 인포라는 부분에
#대해서 호버 옵션을 줄 수도 있다. 텍스트 인포가 뭘 집어넣을 것이냐 라는 뜻이다.
#위치나 크기가 바로 도메인 옵션에서 지정할 수 있다. 크기나 위치에 대한 값을
#x , y 좌표값으로 넣어주면 해당 위치나 크기에 따라 파이차트를 그릴 수 있다.
plot_ly() %>%
   add_pie(data = count(diamonds, cut), labels = ~cut, values = ~n, textinfo = 'label+percent',
           name = "Cut", domain = list(x = c(0, 0.5), y = c(0, 0.5))) %>%
   add_pie(data = count(diamonds, color), labels = ~color, values = ~n, textinfo = 'label+value',
           name = "Color", domain = list(x = c(0.5, 0.8), y = c(0.5, 0.8))) %>%
   add_pie(data = count(diamonds, clarity), labels = ~clarity, values = ~n, textinfo = "percent",
           name = "Clarity", domain = list(x = c(0.8, 1), y = c(0.8, 1))) %>%
   layout(title = "Pie Charts with Subplots", showlegend = FALSE)


##(1-5-3) Subplots Using Grid

#격자구조 형태의 파이차트 이다. 위와 다른점은 파이차트들이 격자 형태로
#모여있다는 점이다.
plot_ly() %>%
   add_pie(data = count(diamonds, cut), labels = ~cut, values = ~n, textinfo = 'label+value',
           name = "Cut", domain = list(row = 0, column = 0)) %>%
   add_pie(data = count(diamonds, color), labels = ~color, values = ~n, textinfo = 'label+value',
           name = "Color", domain = list(row = 0, column = 1)) %>%
   add_pie(data = count(diamonds, clarity), labels = ~clarity, values = ~n, textinfo = 'label+value',
           name = "Clarity", domain = list(row = 1, column = 0)) %>%
   add_pie(data = count(diamonds, cut), labels = ~cut, values = ~n, textinfo = 'label+percent',
           name = "Cut", domain = list(row = 1, column = 1)) %>%
   layout(title = "Pie Charts with Subplots", showlegend = F,
          grid=list(rows=2, columns=2),
          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))


#(1-5-4) Donut Chart

#파이차트의 한 유형인 도넛 차트 이다. 도넛차트에 대한 것을 보면 애드파이에서
#홀의 값을 두어서 가운데 빈칸 즉 구멍의 넓이를 두어서 구멍이 생기게 하는 것이다.
mtcars$manuf <- sapply(strsplit(rownames(mtcars), " "), "[[", 1 )
mtcars %>%
   group_by(manuf) %>%
   summarize(count = n()) %>%
   plot_ly(labels = ~manuf, values = ~count, textinfo = 'label+percent') %>%
   add_pie(hole = 0.4) %>%
   layout(title = "Donut charts using Plotly",  showlegend = F)




#(1-6) Bubble Chart
#(1-6-1) Simple Bubble Chart
#Data <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/school_earnings.csv')
#write.table(Data, file = "school_earnings.csv", sep = ",")
Data <- read.csv("")
str(Data)

#버블 차트에 대해서 그릴 수 있다.
plot_ly(Data, x = ~Women, y = ~Men, text = ~School, type = 'scatter', mode = 'markers', 
        marker = list(size = ~Gap, opacity = 0.5)) %>%
   layout(title = 'Gender Gap in Earnings per University',
          xaxis = list(showgrid = FALSE), yaxis = list(showgrid = FALSE))

#(1-6-2) Setting Markers Color
plot_ly(Data, x = ~Women, y = ~Men, text = ~School, type = 'scatter', mode = 'markers',
             marker = list(size = ~Gap, opacity = 0.5, color = 'rgb(255, 65, 54)')) %>%
   layout(title = 'Gender Gap in Earnings per University',
          xaxis = list(showgrid = FALSE), yaxis = list(showgrid = FALSE))


#(1-6-3) Setting Multiple Colors
#이런식으로 특별한 부분에 대해서만 색을 바꿀 수도 있다.
Colors <- c('rgba(204,204,204,1)', 'rgba(222,45,38,0.8)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)',
            'rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)',
            'rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)',
            'rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)',
            'rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)', 'rgba(204,204,204,1)',
            'rgba(204,204,204,1)')

## Note: The colors will be assigned to each observations based on the order of the observations 
#        in the dataframe.
plot_ly(Data, x = ~Women, y = ~Men, text = ~School, type = 'scatter', mode = 'markers',
             marker = list(size = ~Gap, opacity = 0.5, color = Colors)) %>%
   layout(title = 'Gender Gap in Earnings per University',
          xaxis = list(showgrid = FALSE), yaxis = list(showgrid = FALSE))

#(1-6-4) Mapping a Color Variable (Continuous)

#이건 히트맵 처럼 값에 따라서 색이 변화하도록 만든 코드이다. 그래서 갭차이를
#색으로 쉽게 확인 할 수 있는 것이다.
plot_ly(Data, x = ~Women, y = ~Men, text = ~School, type = 'scatter', mode = 'markers', 
        color = ~Gap, colors = 'Reds', marker = list(size = ~Gap, opacity = 0.5)) %>%
   layout(title = 'Gender Gap in Earnings per University',
          xaxis = list(showgrid = FALSE), yaxis = list(showgrid = FALSE))


#(1-6-5) Mapping a Color Variable (Categorical)
#이번에는 색을 구분해서 여러개의 색들이 나오게 볼 수 있다.
Data$State <- as.factor(c('Massachusetts', 'California', 'Massachusetts', 'Pennsylvania', 'New Jersey',
                          'Illinois', 'Washington DC', 'Massachusetts', 'Connecticut', 'New York',
                          'North Carolina', 'New Hampshire', 'New York', 'Indiana', 'New York', 'Michigan',
                          'Rhode Island', 'California', 'Georgia', 'California', 'California'))
plot_ly(Data, x = ~Women, y = ~Men, text = ~School, type = 'scatter', mode = 'markers', 
             size = ~Gap, color = ~State, colors = 'Paired',
             marker = list(opacity = 0.5, sizemode = 'diameter')) %>%
   layout(title = 'Gender Gap in Earnings per University',
          xaxis = list(showgrid = FALSE), yaxis = list(showgrid = FALSE), showlegend = FALSE)


#(1-6-6) Scaling the Size of Bubble Charts
plot_ly(Data, x = ~Women, y = ~Men, text = ~School, type = 'scatter', mode = 'markers', 
             size = ~Gap, color = ~State, colors = 'Paired',
             #Choosing the range of the bubbles' sizes:
             sizes = c(10, 50), marker = list(opacity = 0.5, sizemode = 'diameter')) %>%
   layout(title = 'Gender Gap in Earnings per University', 
          xaxis = list(showgrid = FALSE), yaxis = list(showgrid = FALSE), showlegend = FALSE)



#(1-6-7) Styled Buble Chart
#Data <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv")
#write.table(Data, file = "gapminderDataFiveYear.csv", sep = ",")
Data <- read.csv("gapminderDataFiveYear.csv")
str(Data)
Data_2007 <- Data[which(Data$year == 2007),]
Data_2007 <- Data_2007[order(Data_2007$continent, Data_2007$country),]
Slope <- 2.666051223553066e-05
str(Data_2007)

#버블차트에 다양한 부분에 스타일을 준 코드이다. 실행후 각 옵션이나 코드가
#어떤 의미인지 확인하면서 이해하면 된다.

Data_2007$Size <- sqrt(Data_2007$pop*Slope)
Colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', '#C61951')
plot_ly(Data_2007, x = ~gdpPercap, y = ~lifeExp, color = ~continent, size = ~size, colors = Colors,
             type = 'scatter', mode = 'markers', sizes = c(min(Data_2007$Size), max(Data_2007$Size)),
             marker = list(symbol = 'circle', sizemode = 'diameter', 
                           line = list(width = 2, color = '#FFFFFF')),
             text = ~paste('Country:', country, '<br>Life Expectancy:', lifeExp, '<br>GDP:', gdpPercap,
                           '<br>Pop.:', pop)) %>%
   layout(title = '\n Life Expectancy v. Per Capita GDP, 2007', 
          xaxis = list(title = 'GDP per capita (2000 dollars)', gridcolor = 'rgb(255, 255, 255)', 
                       range = c(2.003297660701705, 5.191505530708712),
                       type = 'log', zerolinewidth = 1, ticklen = 5, gridwidth = 2),
          yaxis = list(title = 'Life Expectancy (years)', gridcolor = 'rgb(255, 255, 255)',
                       range = c(36.12621671352166, 91.72921793264332), zerolinewidth = 1, 
                       ticklen = 5, gridwith = 2),
          paper_bgcolor = 'rgb(243, 243, 243)', plot_bgcolor = 'rgb(243, 243, 243)',
          legend = list(x = 0.8, y = 0.1, bgcolor = 'rgba(255, 255, 255, 0)', 
                        bordercolor = 'rgba(255, 255, 255, 0)') ) 



#(1-7) Filled Area Plot

#영역 채우기에 대한 부분이다. 아래 함수는 다이아몬드의 캐럿에 대한 덴서티를
#정해놓고 그걸 활용해서 라인 함수를 그린다. x값부터 y값까지 다 칠하는게
#tozeroy 즉 투 제로 와이 이다.
#(1-7-1) Basic Filled Area Plot
Density <- density(diamonds$carat)
plot_ly(x = ~Density$x, y = ~Density$y, type = 'scatter', mode = 'lines', fill = 'tozeroy') %>%
   layout(xaxis = list(title = 'Carat'), yaxis = list(title = 'Density'))


#(1-7-2) Filled Area Plot with Multiple Traces
#밀도함수 2개를 애드 트레이스로 겹쳐서 그릴 수도 있다. 여기서의 구현 방법은
#덴서티를 1 , 2 각각 나누고 각각의 요소에 대해 그림을 그리고 애드 트래이스로
#겹쳐서 그린 것이다.
Diamonds1 <- diamonds[which(diamonds$cut == "Fair"),]
Density1 <- density(Diamonds1$carat)
Diamonds2 <- diamonds[which(diamonds$cut == "Ideal"),]
Density2 <- density(Diamonds2$carat)

plot_ly(x = ~Density1$x, y = ~Density1$y, type = 'scatter', mode = 'lines', name = 'Fair cut', 
        fill = 'tozeroy') %>%
   add_trace(x = ~Density2$x, y = ~Density2$y, name = 'Ideal cut', fill = 'tozeroy') %>%
   layout(xaxis = list(title = 'Carat'), yaxis = list(title = 'Density'))

#(1-7-3) Custom Colors
#컬러에 대해서 커스텀 하는 부분에 대한 내용이다.
plot_ly(x = ~Density1$x, y = ~Density1$y, type = 'scatter', mode = 'lines', name = 'Fair cut', 
        fill = 'tozeroy', fillcolor = 'rgba(168, 216, 234, 0.5)', line = list(width = 0.5)) %>%
   add_trace(x = ~Density2$x, y = ~Density2$y, name = 'Ideal cut', fill = 'tozeroy', 
             fillcolor = 'rgba(255, 212, 96, 0.5)') %>%
   layout(xaxis = list(title = 'Carat'), yaxis = list(title = 'Density'))

#(1-7-4) Area Plot without Lines
#라인에 지우는 내용에 대한 코드이다.
plot_ly(x = ~Density1$x, y = ~Density1$y, type = 'scatter', mode = 'none', name = 'Fair cut', 
        fill = 'tozeroy', fillcolor = 'rgba(168, 216, 234, 0.5)') %>%
   add_trace(x = ~Density2$x, y = ~Density2$y, name = 'Ideal cut', fill = 'tozeroy', 
             fillcolor = 'rgba(255, 212, 96, 0.5)') %>%
   layout(xaxis = list(title = 'Carat'), yaxis = list(title = 'Density'))



#(1-7-5) Selecting Hover Points
#호버 옵션을 포인트에만 달아놓은 것이다. 나머지는 경계를 채워놓은 것이고
#각 모드와 옵션에 대해서 읽어보면서 코드를 이해 해보자.
plot_ly() %>%
   add_trace( x = c(0,0.5,1,1.5,2), y = c(0,1,2,1,0), type = 'scatter', mode='lines+markers', 
              fill = 'toself', fillcolor = '#ab63fa', hoveron = 'points',  marker = list(color = '#ab6300'), 
              line = list(color = '#ab63fa'), text = "Points + Fills", hoverinfo = 'text' )%>%    
   add_trace(x = c(3,3.5,4,4.5,5), y = c(0,1,2,1,0), type = 'scatter', mode='lines+markers', fill = 'toself',
             fillcolor = '#e763fa', hoveron = 'points', marker = list(color = '#e763fa'), 
             line = list(color = '#e763fa'), text = "Points only", hoverinfo = 'text') %>%
   layout(title = "hover on <i>points</i> or <i>fill</i>", 
          xaxis = list(range = c(0,5.2)), yaxis = list(range = c(0,3)))



#(1-7-6) Interior Filling for Area Chart

#예전에 봤었던 그래프를 표현하는 방식이다. 로우부터 하이까지 색칠을 한 
#에어리어 필 차트 이다. 
Month <- c('January', 'February', 'March', 'April', 'May', 'June', 'July',
           'August', 'September', 'October', 'November', 'December')
High_2014 <- c(28.8, 28.5, 37.0, 56.8, 69.7, 79.7, 78.5, 77.8, 74.1, 62.6, 45.3, 39.9)
Low_2014 <- c(12.7, 14.3, 18.6, 35.5, 49.9, 58.0, 60.0, 58.6, 51.7, 45.2, 32.2, 29.1)
Data <- data.frame(Month, High_2014, Low_2014)
Data$Average_2014 <- rowMeans(Data[,c("High_2014", "Low_2014")])
##The default order will be alphabetized unless specified as below:
Data$Month <- factor(Data$Month, levels = Data[["Month"]])
plot_ly(Data, x = ~Month, y = ~High_2014, type = 'scatter', mode = 'lines', 
        line = list(color = 'rgba(0,100,80,1)'),
             showlegend = FALSE, name = 'High 2014') %>%
   add_trace(y = ~Low_2014, type = 'scatter', mode = 'lines',  fill = 'tonexty', 
             fillcolor='rgba(0,100,80,0.2)', 
             line = list(color = 'rgba(0,100,80,1)'),  showlegend = FALSE, name = 'Low 2014') %>%
   layout(title = "High and Low Temperatures in New York", paper_bgcolor='rgb(255,255,255)', 
          plot_bgcolor='rgb(229,229,229)',
          xaxis = list(title = "Months",gridcolor = 'rgb(255,255,255)', showgrid = TRUE,showline = FALSE,
                       showticklabels = TRUE,tickcolor = 'rgb(127,127,127)', 
                       ticks = 'outside',zeroline = FALSE),
          yaxis = list(title = "Temperature (degrees F)",gridcolor = 'rgb(255,255,255)', 
                       showgrid = TRUE, showline = FALSE, showticklabels = TRUE,
                       tickcolor = 'rgb(127,127,127)',ticks = 'outside', zeroline = FALSE))



#(1-7-7) Stacked Area Chart with Original Values   

#원래 있던 값을 누적시키는 차트고 , 누적되면서 색이 변하는 부분을 보여주게 된다.
#일단 데이터에 트랜스포즈를 취해서 행과 열을 바꾼다. 이후 해당되는 요소에 대해
#그래프를 그린다. 그룹놈 즉 수치를 묶는 것을 빈칸을 둘 수도 있고 프랙션 즉
#0과 1사이의 확률 개념으로 둘 수도 있고 퍼센트 개념으로도 둘 수도 있다.
Data <- t(USPersonalExpenditure)
Data <- data.frame("year"=rownames(Data), Data)
plot_ly(Data, x = ~year, y = ~Food.and.Tobacco, name = 'Food and Tobacco', type = 'scatter', 
        mode = 'none', stackgroup = 'one', groupnorm = "", fillcolor = '#F5FF8D') %>%
   add_trace(y = ~Household.Operation, name = 'Household Operation', 
             fillcolor = '#50CB86') %>%
   add_trace(y = ~Medical.and.Health, name = 'Medical and Health', fillcolor = '#4C74C9') %>%
   add_trace(y = ~Personal.Care, name = 'Personal Care', fillcolor = '#700961') %>%
   add_trace(y = ~Private.Education, name = 'Private Education', fillcolor = '#312F44') %>%
   layout(title = 'United States Personal Expenditures by Categories',
          xaxis = list(title = "", showgrid = FALSE),
          yaxis = list(title = "Expenditures (in billions of dollars)",  showgrid = FALSE))

# stackgroup = 'one' :  ""이 아닌 어느 text도 가능 
# groupnorm = "" | groupnorm = "fraction" | groupnorm = "percent"

# Ex of groupnorm = "percent"
plot_ly(Data, x = ~year, y = ~Food.and.Tobacco, name = 'Food and Tobacco', type = 'scatter', 
        mode = 'none', stackgroup = 'one', groupnorm = 'percent', fillcolor = '#F5FF8D') %>%
   add_trace(y = ~Household.Operation, name = 'Household Operation', fillcolor = '#50CB86') %>%
   add_trace(y = ~Medical.and.Health, name = 'Medical and Health', fillcolor = '#4C74C9') %>%
   add_trace(y = ~Personal.Care, name = 'Personal Care', fillcolor = '#700961') %>%
   add_trace(y = ~Private.Education, name = 'Private Education', fillcolor = '#312F44') %>%
   layout(title = 'United States Personal Expenditures by Categories',
          xaxis = list(title = "", showgrid = FALSE),
          yaxis = list(title = "Proportion from the Total Expenditures",
                       showgrid = FALSE, ticksuffix = '%'))



#(1-8) Gantt Charts
#(1-8-1) Gantt Chart

## Read in data
#Data <- read.csv("https://cdn.rawgit.com/plotly/datasets/master/GanttChart-updated.csv",
#                 stringsAsFactors = F)
#write.table(Data, file = "GanttChart-updated.csv", sep = ",")
Data <- read.csv("GanttChart-updated.csv")
## Convert to dates
Data$Start <- as.Date(Data$Start, format = "%m/%d/%Y")
## Sample client name
Client = "Sample Client"
## Choose colors based on number of resources
Cols <- RColorBrewer::brewer.pal(length(unique(Data$Resource)), name = "Set3")
Data$Color <- factor(Data$Resource, labels = Cols)
## Initialize empty plot
BP <- plot_ly()
## Each task is a separate trace
## Each trace is essentially a thick line plot
## x-axis ticks are dates and handled automatically

for(i in 1:(nrow(Data) - 1)){
   BP <- add_trace(BP, x = c(Data$Start[i], Data$Start[i] + Data$Duration[i]),  # x0, x1
                   y = c(i, i),  # y0, y1
                   type="scatter", mode = "lines", 
                   line = list(color = Data$Color[i], width = 20),
                   showlegend = F, hoverinfo = "text",
                   text = paste("Task: ", Data$Task[i], "<br>", "Duration: ", 
                                Data$Duration[i], "days<br>",
                                "Resource: ", Data$Resource[i])) }
BP

#(1-8-2) Alter Layout
layout(BP,
            ## Axis options:
            ## 1. Remove gridlines
            ## 2. Customize y-axis tick labels and show task names instead of numbers
            xaxis = list(showgrid = F, tickfont = list(color = "#e6e6e6")),
            yaxis = list(showgrid = F, tickfont = list(color = "#e6e6e6"),
                         tickmode = "array", tickvals = 1:nrow(Data), 
                         ticktext = unique(Data$Task), domain = c(0, 0.9)),
            plot_bgcolor = "#333333",  # Chart area color
            paper_bgcolor = "#333333") # Axis area color


#(1-8-3) Add Annotations
## Add total duration and total resources used
## x and y coordinates are based on a domain of [0,1] and not
## actual x-axis and y-axis values
A <- list(xref = "paper", yref = "paper", x = 0.80, y = 0.1, 
          text = paste0("Total Duration: ",sum(Data$Duration)," days<br>","Total Resources: ",
                        length(unique(Data$Resource)),"<br>"),
          font = list(color = '#264E86', size = 12), ax = 0, ay = 0, align = "left", showarrow = FALSE)
## Add client name and title on top
B <- list(xref = "paper", yref = "paper", x = 0.1, y = 1, xanchor = "left", 
          text = paste0("Gantt Chart: ", Client),
          font = list(color = '#264E86', size = 20, family = "Times New Roman"),  
          ax = 0, ay = 0,  align = "left", 
          showarrow = FALSE)
BP %>% layout(annotations = A) %>% layout(annotations = B)




#(1-9) Graphing Multiple Chart Types
#(1-9-1) Bar and Line Chart
Airquality_sept <- airquality[which(airquality$Month == 9), ]
Airquality_sept$Date <-  as.Date(paste(Airquality_sept$Month, Airquality_sept$Day, 1973, sep = "."), 
                                 format = "%m.%d.%Y")
plot_ly(Airquality_sept) %>%
   add_trace(x = ~ Date, y = ~ Wind, type = 'bar', name = 'Wind', marker = list(color = '#C9EFF9'), 
             hoverinfo = "text",
             text = ~ paste(Wind, ' mph')) %>%
   add_trace(x = ~ Date, y = ~ Temp, type = 'scatter', mode = 'lines', name = 'Temperature', yaxis = 'y2',
             line = list(color = '#45171D'),  hoverinfo = "text", text = ~ paste(Temp, '°F')) %>%
   layout(title = paste('New York Wind and Temperature Measurements',
                        'for September 1973'),
          xaxis=list(title=""),yaxis=list(side='left', title = 'Wind in mph', showgrid = FALSE, 
                                          zeroline = FALSE),
          yaxis2=list(side='right',overlaying="y", title='Temperature in degrees F',
                      showgrid=FALSE, zeroline=FALSE))


#(1-9-2) Scatterplot with Loess Smoother
plot_ly(mtcars, x = ~disp, color = I("black")) %>%
   add_markers(y = ~mpg, text = rownames(mtcars), showlegend = FALSE) %>%
   add_lines(y = ~fitted(loess(mpg ~ disp)), line = list(color = '#07A4B5'), name = "Loess Smoother", 
             showlegend = TRUE) %>%
   layout(xaxis = list(title = 'Displacement (cu.in.)'), yaxis = list(title = 'Miles/(US) gallon'), 
          legend = list(x = 0.80, y = 0.90))


#(1-9-3) Loess Smoother with Uncertainty Bounds
##install.packages("broom")
library(broom)
M <- loess(mpg ~ disp, data = mtcars)
plot_ly(mtcars, x = ~disp, color = I("black")) %>%
   add_markers(y = ~mpg, text = rownames(mtcars), showlegend = FALSE) %>%
   add_lines(y = ~fitted(loess(mpg ~ disp)), line = list(color = 'rgba(7, 164, 181, 1)'), 
             name = "Loess Smoother") %>%
   add_ribbons(data = augment(M), ymin = ~.fitted - 1.96 * .se.fit, ymax = ~.fitted + 1.96 * .se.fit,
               line = list(color = 'rgba(7, 164, 181, 0.05)'), fillcolor = 'rgba(7, 164, 181, 0.2)',
               name = "Standard Error") %>%
   layout(xaxis = list(title = 'Displacement (cu.in.)'),  yaxis = list(title = 'Miles/(US) gallon'), 
          legend = list(x = 0.80, y = 0.90))


#(1-10) Dot Plots - Dot and Dumbbell Plots
#Data <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/school_earnings.csv")
#write.table(ata, file = "school_earnings.csv", sep = ",")
Data <- read.csv("school_earnings.csv")
Data <- Data[order(Data$Men), ]
plot_ly(Data, x = ~Women, y = ~School, name = "Women", type = 'scatter', mode = "markers", 
        marker = list(color = "pink")) %>%
   add_trace(x = ~Men, y = ~School, name = "Men", type = 'scatter', mode = "markers", 
             marker = list(color = "blue")) %>%
   layout(title = "Gender earnings disparity", xaxis = list(title = "Annual Salary (in thousands)"), 
          margin = list(l = 10))


#(1-11) Dumbbell Plots ; Dot and Dumbbell Plots
#Data <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/school_earnings.csv")
#write.table(ata, file = "school_earnings.csv", sep = ",")
Data <- read.csv("school_earnings.csv")
## order factor levels by men's income (plot_ly() will pick up on this ordering)
Data$School <- factor(Data$School, levels = Data$School[order(Data$Men)])
plot_ly(Data, color = I("gray80")) %>%
   add_segments(x = ~Women, xend = ~Men, y = ~School, yend = ~School, showlegend = FALSE) %>%
   add_markers(x = ~Women, y = ~School, name = "Women", color = I("pink")) %>%
   add_markers(x = ~Men, y = ~School, name = "Men", color = I("blue")) %>%
   layout( title = "Gender earnings disparity", xaxis = list(title = "Annual Salary (in thousands)"), 
           margin = list(l = 65))



#(1-12) Gauge Charts
#(1-12-1) Outline; Base Chart (rotated)
Colors = c('rgb(  0, 255, 255)', 'rgb(255,   0, 255)', 'rgb(255, 255, 0)',
           'rgb(125, 125, 125)', 'rgb(  0, 125, 125)', 'rgb(125, 125, 0)', 
           'rgb( 77,  77,  77)')
BP <- plot_ly(type = "pie", values = c(40, 10, 10, 10, 10, 10, 10), 
              labels = c("-", "0", "20", "40", "60", "80", "100"),
              rotation = 108, direction = "clockwise", hole = 0.4, 
              textinfo = "label", textposition = "outside",
              hoverinfo = "none", domain = list(x = c(0, 0.48), y = c(0, 1)), 
              marker = list(colors = Colors), showlegend = FALSE)
BP

#(1-12-2) Meter Chart
Colors = c('rgb(255, 255, 255)', 'rgb(232, 226, 202)', 'rgb(226, 210, 172)', 
           'rgb(223, 189, 139)', 'rgb(223, 162, 103)', 'rgb(226, 126, 64)')
Values <- c(50, 10, 10, 10, 10, 10)
Labels <- c("Error Log Level Meter", "Debug", "Info", "Warn", "Error", "Fatal")
BP1 <- add_trace(BP, type = "pie", values = Values, 
                 labels = Labels,
                 rotation = 90, direction = "clockwise", hole = 0.3, textinfo = "label", 
                 textposition = "inside", hoverinfo = "none", domain = list(x = c(0, 0.48), y = c(0, 1)), 
                 marker = list(colors = Colors), showlegend = FALSE)
BP1

#(1-12-3) Dial
Axis <- list(showticklabels = FALSE, autotick = FALSE, showgrid = FALSE, zeroline = FALSE)
Annotations <- list(xref = 'paper', yref = 'paper', x = 0.225, y = 0.45, showarrow = FALSE, text = '50')
Shapes = list(list(type = 'path', path = 'M 0.235 0.5 L 0.24 0.62 L 0.245 0.5 Z ',
                   xref = 'paper', yref = 'paper', fillcolor = 'rgba(44, 160, 101, 0.5)'))
layout(BP1, shapes = Shapes, xaxis = Axis, yaxis = Axis, annotations = Annotations)