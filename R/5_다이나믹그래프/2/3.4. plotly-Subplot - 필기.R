# 3. subplot
#1) Multiple Axes
#다중축에 대한 내용이다. 그래서 축 자체를 분리해서 그린다는 개념이다.
#즉 파란선에 대해서는 y축 스케일을 10 15 20 25 30 ... 으로 보고
#노란선에 대해서는 스케일을 1 1.5 2 2.5 3 ... 으로 본다는 것이다.
library(plotly)
Yaxis2 <- list(tickfont = list(color = "red"), overlaying = "y",
           side = "right", title = "second y axis")
plot_ly() %>%
  add_lines(x = ~1:3, y = ~10*(1:3), name = "slope of 10") %>%
  add_lines(x = ~2:4, y = ~1:3, name = "slope of 1", yaxis = "y2") %>%
  layout(title = "Double Y Axis", yaxis2 = Yaxis2, xaxis = list(title = "x"))


#2) Subplots
#(2-1) Basic Subplots 

#서브플롯의 기본적인 사용법은 아래처럼 subplot(그래프1, 그래프2) 이다.
#그냥 그래프 2개를 하나의 화면에 합치는 것이다. 

Plot1 <- plot_ly(economics, x = ~date, y = ~unemploy) %>% add_lines(name = ~"unemploy")
Plot2 <- plot_ly(economics, x = ~date, y = ~uempmed) %>% add_lines(name = ~"uempmed")
subplot(Plot1, Plot2)

#(2-2) Scaled Subplots
#언제나 우리가 원하는 타입으로 데이터가 있지 않다. 그래서 원하는 형식의 데이터로
#바꾸기 위해 사용하는 패키지가 있는데 tidyr 이다.
#게더는 모으는 것이고 스프레드는 뿌리는 것이다.
#즉 와이드 타입과 롱타입을 변환하는 것이다. 롱 타입은 엑셀에서 보고싶은
#칼럼만 선택해서 보는 형태이고 와이드는 전체 칼럼이 다 나온 구조이다.
#R에서는 롱타입을 기존으로 하기 떄문에 롱 타입으로 변환해서 사용하는 것이다.
# gather  <= Gather columns into key-value pairs.
# ~paste0("y", Id)    <=    ~paste0("y", rev(Id))
economics %>%
  tidyr::gather(Variable, Value, -date) %>%
  transform(Id = as.integer(factor(Variable))) %>%
  plot_ly(x = ~date, y = ~Value, color = ~Variable, colors = "Dark2", yaxis = ~paste0("y", Id)) %>%
  add_lines() %>%
  subplot(nrows = 5, shareX = TRUE)

# Same result
#그래서 게더로 해당 요소를 모아서 데이터에 넣어서 사용하고 있다.
#그래서 통계 처리를 할 때 롱타입이나 와이드 타입이 필요하다면 이와 같이
#tidyr을 통해서 변환 후 사용 가능하다.
library(tidyr)
Data <- gather(economics, Variable, Value, -date)
Data <- transform(Data, Id = as.integer(factor(Data$Variable)))
Data %>% 
  plot_ly(x = ~date, y = ~Value, color = ~Variable, colors = "Dark2", yaxis = ~paste0("y", Id)) %>% 
  add_lines() %>% 
  subplot(nrows = 5, shareX = TRUE)



#(2-3) Recursive Subplots
#좌표축을 리컬시브하게 그리고 거기에 원하는 그래프를 그릴 수 있다.
PlotList <- function(nplots) {lapply(seq_len(nplots), function(x) plot_ly())}
S1 <- subplot(PlotList(6), nrows = 2, shareX = TRUE, shareY = TRUE)
S2 <- subplot(PlotList(2), shareY = TRUE)
subplot(S1, S2, plot_ly(), nrows = 3, margin = 0.04, heights = c(0.6, 0.3, 0.1))


#3) Inset Plots
#그래프를 그리고 그 그래프 위에 원하는 부분에 작은 그래프를 더 그릴 수 있다.
#서브플롯 개념을 안쓰고 여기에는 레이아웃으로 그리고 있다.
BP <- plotly::plot_ly()
BP1 <- plotly::add_trace(BP, x = c(1, 2, 3), y = c(4, 3, 2), mode = 'lines')
BP2 <- plotly::add_trace(BP1, x = c(20, 30, 40), y = c(30, 40, 50), 
                         xaxis = 'x2', yaxis = 'y2', mode = 'lines')
plotly::layout(BP2, xaxis2 = list(domain = c(0.6, 0.95), anchor = 'y2'  ),
                    yaxis2 = list(domain = c(0.6, 0.95), anchor = 'x2'))


#4) 3D Subplots
# custom grid style
#3D 서브플롯을 그리는 코드이다. 등고선 그래프를 서브플롯으로 나누어서
#각각 그래프를 그리고 있다. BP 1 ~ 4 까지 각각 그리고 서브플롯으로
#묶어서 레이아웃에 이름을 붙이고 옆에 따로 레벨 표시 그래프도 달아준다.
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

#서브플롯 즉 그래프를 나누어서 그릴것인데 행과 열을 나눠서 그래프를 그리는
#예시를 보여주고 있다. 한 면에 여러개의 그래프를 다양하게 그릴 수 있다는 것
#을 보고 이해하면 된다.

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