# 3. subplot
#1) Multiple Axes
library(plotly)
Yaxis2 <- list(tickfont = list(color = "red"), overlaying = "y",
           side = "right", title = "second y axis")
plot_ly() %>%
  add_lines(x = ~1:3, y = ~10*(1:3), name = "slope of 10") %>%
  add_lines(x = ~2:4, y = ~1:3, name = "slope of 1", yaxis = "y2") %>%
  layout(title = "Double Y Axis", yaxis2 = Yaxis2, xaxis = list(title = "x"))


#2) Subplots
#(2-1) Basic Subplots 
Plot1 <- plot_ly(economics, x = ~date, y = ~unemploy) %>% add_lines(name = ~"unemploy")
Plot2 <- plot_ly(economics, x = ~date, y = ~uempmed) %>% add_lines(name = ~"uempmed")
subplot(Plot1, Plot2)

#(2-2) Scaled Subplots
# gather  <= Gather columns into key-value pairs.
# ~paste0("y", Id)    <=    ~paste0("y", rev(Id))
economics %>%
  tidyr::gather(Variable, Value, -date) %>%
  transform(Id = as.integer(factor(Variable))) %>%
  plot_ly(x = ~date, y = ~Value, color = ~Variable, colors = "Dark2", yaxis = ~paste0("y", Id)) %>%
  add_lines() %>%
  subplot(nrows = 5, shareX = TRUE)

# Same result
library(tidyr)
Data <- gather(economics, Variable, Value, -date)
Data <- transform(Data, Id = as.integer(factor(Data$Variable)))
Data %>% 
  plot_ly(x = ~date, y = ~Value, color = ~Variable, colors = "Dark2", yaxis = ~paste0("y", Id)) %>% 
  add_lines() %>% 
  subplot(nrows = 5, shareX = TRUE)



#(2-3) Recursive Subplots
PlotList <- function(nplots) {lapply(seq_len(nplots), function(x) plot_ly())}
S1 <- subplot(PlotList(6), nrows = 2, shareX = TRUE, shareY = TRUE)
S2 <- subplot(PlotList(2), shareY = TRUE)
subplot(S1, S2, plot_ly(), nrows = 3, margin = 0.04, heights = c(0.6, 0.3, 0.1))


#3) Inset Plots 
BP <- plotly::plot_ly()
BP1 <- plotly::add_trace(BP, x = c(1, 2, 3), y = c(4, 3, 2), mode = 'lines')
BP2 <- plotly::add_trace(BP1, x = c(20, 30, 40), y = c(30, 40, 50), 
                         xaxis = 'x2', yaxis = 'y2', mode = 'lines')
plotly::layout(BP2, xaxis2 = list(domain = c(0.6, 0.95), anchor = 'y2'  ),
                    yaxis2 = list(domain = c(0.6, 0.95), anchor = 'x2'))


#4) 3D Subplots
# custom grid style
Axx <- list(gridcolor='rgb(255, 255, 255)', zerolinecolor='rgb(255, 255, 255)',
            showbackground = TRUE, backgroundcolor = 'rgb(230, 230, 230)')
# individual plots
BP1 <- plot_ly(z = ~volcano, scene = 'scene1') %>% add_surface(showscale = TRUE)
BP2 <- plot_ly(z = ~volcano+10, scene = 'scene2') %>% add_surface(showscale = TRUE)
BP3 <- plot_ly(z = ~volcano+200, scene = 'scene3') %>% add_surface(showscale = TRUE)
BP4 <- plot_ly(z = ~volcano+300, scene = 'scene4') %>% add_surface(showscale = TRUE)
# subplot and define scene
subplot(BP1, BP2, BP3, BP4) %>%
  layout(title = "3D Subplots",
         scene = list(domain=list(x=c(0,0.5), y=c(0.5,1)), 
                      xaxis=Axx, yaxis=Axx, zaxis=Axx, aspectmode='manual'),
         scene2 = list(domain=list(x=c(0.5,1), y=c(0.5,1)), 
                       xaxis=Axx, yaxis=Axx, zaxis=Axx, aspectmode='cube'),
         scene3 = list(domain=list(x=c(0,0.5), y=c(0,0.5)),
                       xaxis=Axx, yaxis=Axx, zaxis=Axx, aspectmode='data'),
         scene4 = list(domain=list(x=c(0.5,1), y=c(0,0.5)), 
                       xaxis=Axx, yaxis=Axx, zaxis=Axx, aspectmode='auto'))
# aspectmode =     <=   "auto" | "cube" | "data" | "manual"  



#5) Map Subplots And Small Multiples
library(dplyr)
#Df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/1962_2006_walmart_store_openings.csv')
#write.table(Df, file = "1962_2006_walmart_store_openings.csv", sep = ",")
Df <- read.csv("1962_2006_walmart_store_openings.csv")

# common map properties
Geo <- list(scope = 'usa', showland = T, landcolor = toRGB("gray90"),
            showcountries = F, subunitcolor = toRGB("white"))

One_map <- function(dat){
             plot_geo(dat) %>%
             add_markers(x = ~LON, y = ~LAT, color = I("blue"), alpha = 0.5) %>%
             add_text(x = -78, y = 47, text = ~unique(YEAR), color = I("black")) %>%
             layout(geo = Geo) }

Df %>%
  group_by(YEAR) %>%
  do(map = One_map(.)) %>%
  subplot(nrows = 9) %>%
  layout(showlegend = FALSE,
         title = 'New Walmart Stores per year 1962-2006<br> Source: <a href="http://www.econ.umn.edu/~holmes/data/WalMart/index.html">University of Minnesota</a>',
         width = 1000, height = 900, hovermode = FALSE)