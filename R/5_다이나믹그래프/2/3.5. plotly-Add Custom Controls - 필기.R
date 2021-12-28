#1. Buttons
#(1-1) Restyle Buttons
#버튼의 메소드 즉 버튼을 눌렀을때 어떤 역할을 하는지와 타입 드롭다운이나 버튼 식
#같은 것으로 구분이 되어있다. 리스타일은 데이터 또는 속성 수정 , 레이아웃은 
#레이아웃 속성 수정 , 업데이트는 데이터 및 레이아웃 속성 수정 , 에니메이트는
#에니메이션 시작 또는 일시 중지 이고 이는 오프라인에서만 사용 가능하다.
library(plotly)
X <- seq(-2*pi, 2*pi, length.out = 1000)
Df <- data.frame(X, Y1 = sin(X))
BP <- plot_ly(Df, x = ~X) %>% add_lines(y = ~Y1)
Buttons <-  list(list(method = "restyle", args = list("line.color", "blue"), label = "Blue"),
                 list(method = "restyle", args = list("line.color", "red"), label = "Red"))
Updatemenus = list(list(type = "buttons", y = 0.8, buttons = Buttons))
BP %>% layout(title = "Button Restyle", xaxis = list(domain = c(0.1, 1)), yaxis = list(title = "y"),
              updatemenus = Updatemenus)
# "method = "    <=  "restyle" | "relayout" | "animate" | "update" | "skip"   
# "type = "      <=  "dropdown" | "buttons"


#(1-2) Update Several Data Attributes
BP <- plot_ly(z = ~volcano, type = "heatmap", colorscale='Rainbow')
# chart option buttons
#또 버튼을 잉용해서 다양한 차트 옵션을 키고 끄고 할 수도 있다.
Buttons1 <- list(list(method="restyle", args=list("type","heatmap"), label="Heatmap"),
                 list(method="restyle", args=list("type","contour"), label="Contour"),
                 list(method="restyle", args=list("type","surface"), label="Surface"))
Chart_types <- list(type = "buttons", direction = "right", xanchor = 'center', yanchor = "top",
                    pad = list('r'= 0, 't'= 10, 'b' = 10), x = 0.5, y = 1.27,
                    buttons = Buttons1)
# color option buttons
#버튼을 통해서 색에 대한 옵션도 변경 할 수 있다.
Buttons2 <- list(list(method="restyle", args=list("colorscale","Rainbow"), label="Rainbow"),
                 list(method="restyle", args=list("colorscale","Jet"), label="Jet"),
                 list(method="restyle", args=list("colorscale","Earth"), label="Earth"),
                 list(method="restyle", args=list("colorscale","Electric"), label="Electric"))
Color_types <- list(type="buttons", direction="right", xanchor='center', yanchor="top",
                    pad = list('r' = 0, 't' = 10, 'b' = 10), x = 0.5,  y = 1.17,
                    buttons = Buttons2)
Updatemenus = list(Chart_types,Color_types)
Annotations <- list(list(text = "Chart Type", x=0.1, y=1.25, xref='paper', yref='paper', showarrow=FALSE),
              list(text = "Color Type", x=0.1, y=1.15, xref='paper', yref='paper', showarrow=FALSE))
# plot
BP %>% layout(xaxis = list(domain = c(0.1, 1)),  yaxis = list(title = "Y"),
              updatemenus = Updatemenus, annotations = Annotations)


#(1-3) Relayout Button
#리 레이아웃 버튼 이다. 각각의 클러스터로 구분되어있는 것들을 레이아웃으로
#클러스터를 구분할 수 있도록 모양을 띄우는 코드이다.
set.seed(1)
X0 <- rnorm(400, mean=2, sd=0.4);   Y0 <- rnorm(400, mean=2, sd=0.4);
X1 <- rnorm(400, mean=3, sd=0.6);   Y1 <- rnorm(400, mean=6, sd=0.4);
X2 <- rnorm(400, mean=4, sd=0.2);   Y2 <- rnorm(400, mean=4, sd=0.4);

# shapes components
Cluster0 = list(type = 'circle', xref ='x', yref='y', x0=min(X0), y0=min(Y0), x1=max(X0), y1=max(Y0), 
                opacity=0.25, line = list(color="#835AF1"), fillcolor="#835AF1")
Cluster1 = list(type = 'circle', xref ='x', yref='y', x0=min(X1), y0=min(Y1), x1=max(X1), y1=max(Y1), 
                opacity=0.25, line = list(color="#7FA6EE"), fillcolor="#7FA6EE")
Cluster2 = list(type = 'circle', xref ='x', yref='y', x0=min(X2), y0=min(Y2), x1=max(X2), y2=max(Y2),
                opacity=0.25, line = list(color="#B8F7D4"),  fillcolor="#B8F7D4")

# updatemenus component
#액티브 옵션에 버튼을 두면 처음부터 켜져있게 된다. 
Buttons <- list(list(label="None", method="relayout", args=list(list(shapes=c()))),
                list(label="Cluster 0", method="relayout", args=list(list(shapes=list(Cluster0,c(),c())))),
                list(label="Cluster 1", method="relayout", args=list(list(shapes=list(c(),Cluster1,c())))),
                list(label="Cluster 2", method="relayout", args=list(list(shapes=list(c(),c(),Cluster2)))),
                list(label="All", method="relayout", args=list(list(shapes=list(Cluster0,Cluster1,Cluster2)))))
Updatemenus <- list(list(active = -1, type = 'buttons', buttons=Buttons))

plot_ly(type = 'scatter', mode='markers') %>%
  add_trace(x=X0, y=Y0, mode='markers', marker=list(color='#835AF1')) %>%
  add_trace(x=X1, y=Y1, mode='markers', marker=list(color='#7FA6EE')) %>%
  add_trace(x=X2, y=Y2, mode='markers', marker=list(color='#B8F7D4')) %>%
  layout(title = "Highlight Clusters", showlegend = FALSE, updatemenus = Updatemenus)



#2) Dropdown Events 
#(2-1) Simple Dropdown Menu Example
#install.packages("MASS")
library(MASS)

#그래프를 드랍다운의 형태로 버튼을 눌러서 스캐터와 히스토그램을 모두 볼 수 있는
#형태로 만드는 코드이다. 한번 살펴보면 버튼을 리스트1 리스트2 로 2개 만들고
#그걸 버튼이라는 것에 묶었다. 그래서 그걸 누르면 해당하는 그래프가 나오도록 
#만들었다. 이처럼 선택해야할 버튼이 많으면 드랍다운을 사용하는 것이 좋다.
Covmat <- matrix(c(0.8, 0.4, 0.3, 0.8), nrow = 2, byrow = T)
Df <- mvrnorm(n = 10000, c(0,0), Sigma = Covmat)
Df <- as.data.frame(Df)
colnames(Df) <- c("x", "y")
List1 = list(method = "restyle", args = list("type", "scatter"), label = "Scatter")
List2 = list(method = "restyle", args = list("type", "histogram2d"), label = "2D Histogram")
Button  <- list(List1, List2)
Marker = list(line = list(color = "black", width = 1))
Updatemenus = list(list(y = 0.8, buttons = Button))
plot_ly(Df, x = ~x, y = ~y, alpha = 0.3) %>%
  add_markers(marker = Marker) %>%
  layout(title = "Drop down menus - Plot type", xaxis = list(domain = c(0.1, 1)),
         yaxis = list(title = "y"), updatemenus = Updatemenus)



#(2-2) Add Two Dropdown Menus to Restyle Graph
X <- seq(-2 * pi, 2 * pi, length.out = 1000)
Df <- data.frame(X, Y1 = sin(X), Y2 = cos(X))
Buttons1 <- list(list(method="restyle", args=list("line.color","blue"), label="Blue"),
                 list(method = "restyle", args = list("line.color", "red"), label = "Red"))
BUttons2 <- list(list(method="restyle", args=list("visible", list(TRUE,FALSE)), label="Sin"),
                 list(method="restyle", args=list("visible", list(FALSE,TRUE)), label="Cos")) 
Updatemenus = list(list(y = 0.8, buttons = Buttons1), list(y=0.7, buttons = BUttons2))
plot_ly(Df, x = ~X) %>%
  add_lines(y = ~Y1, name = "A") %>%
  add_lines(y = ~Y2, name = "B", visible = F) %>%
  layout(title="Drop down menus - Styling", xaxis=list(domain=c(0.1, 1)), yaxis=list(title="Y"),
         updatemenus = Updatemenus)



#3) Range Sliders and Selectors
# Basic Range Slider and Selector Buttons
#install.packages("quantmod")
#퀀트 모드는 경제 , 주식 , 재정적 인 데이터를 다룰 수 있는 패키지 이다.
#그래서 보면 데이터를 다운로드 하는 과정이 섞여있다. 즉 실시간으로 데이터를
#받아왔기 때문에 코드 실행에 시간이 조금 걸린다.
library(quantmod)
# Download some data
getSymbols(Symbols = c("AAPL", "MSFT"))
#겟 심볼이라는 코드는 퀀트모드에서 해당하는 회사의 가격을 가지고 오는 
#함수이다. 이를 통해서 해당 데이터를 불러올 수 있다. 옵션을 세팅하는 과정이
#그렇게 어렵지 않기 떄문에 짧은 코드로도 많은 결과를 보여줄 수 있는 슬라이더
#타입의 버튼이다.

Ds <- data.frame(Date = index(AAPL), AAPL[,6], MSFT[,6])
Ls1 <- list(count = 3, label = "3 mo", step = "month", stepmode = "backward")
Ls2 <- list(count = 6, label = "6 mo", step = "month", stepmode = "backward")
Ls3 <- list(count = 1, label = "1 yr", step = "year", stepmode = "backward")
Ls4 <- list(count = 1, label = "YTD",  step = "year", stepmode = "todate")
Ls5 <- list(step = "all")
Button <- list( Ls1,  Ls2,  Ls3,  Ls4,  Ls5) 

plot_ly(Ds, x = ~Date) %>%
  add_lines(y = ~AAPL.Adjusted, name = "Apple") %>%
  add_lines(y = ~MSFT.Adjusted, name = "Microsoft") %>%
  layout(title = "Stock Prices",
         xaxis = list(rangeselector = list(buttons = Button),
         rangeslider = list(type = "date")), yaxis = list(title = "Price"))



#4) Sliders
#(4-1) Basic Slider Control
Df <- data.frame(X = c("1", "2", "3", "4", "5"), Y = c("1", "1", "1", "1", "1")) 
# create steps for slider
List1 <- list(args = list("marker.color", "red"), label="Red", method = "restyle", value = "1")
List2 <- list(args = list("marker.color", "green"), label="Green", method="restyle", value="2")
List3 <- list(args = list("marker.color", "blue"), label = "Blue", method = "restyle", value = "3")
Steps <- list(List1, List2, List3)
Df %>%
  plot_ly(x = ~X, y = ~Y, mode = "markers", marker = list(size = 20, color = 'green'), 
          type = "scatter") %>%
  layout(title = "Basic Slider",
         sliders = list(list(active = 1, currentvalue = list(prefix = "Color: "),
                             pad = list(t = 60), steps = Steps))) 


#(4-2) Sine Wave Slider
#슬라이더를 통해서 다양한 결과를 한 그래프 안에 담아놓을 수 있다.
X <- seq(0,10, length.out = 1000)
# create data
Aval <- list()
for(Step in 1:11){Aval[[Step]] <-list(visible = FALSE, name = paste0('v = ', Step), 
                                      x = X, y = sin(Step*X))}
Aval[3][[1]]$visible = TRUE
# create steps and plot all traces
Steps <- list()
BP <- plot_ly()
for (i in 1:11) {BP <- add_lines(BP, x=Aval[i][[1]]$x, y=Aval[i][[1]]$y, 
                                 visible = Aval[i][[1]]$visible, name = Aval[i][[1]]$name, 
                                 type = 'scatter', mode = 'lines', hoverinfo = 'name', 
                                 line = list(color = '00CED1'), showlegend = FALSE)
                 Step <- list(args = list('visible', rep(FALSE, length(Aval))), method = 'restyle')
                 Step$args[[2]][i] = TRUE
                 Steps[[i]] = Step }  
# add slider control to plot
Sliders = list(list(active = 3, currentvalue = list(prefix = "Frequency: "), steps = Steps))
BP %>% layout(sliders = Sliders)



#(4-3) Mulitple Slider Controls
#지구본을 살펴보는 코드이다. 코드가 굉장히 긴데 실행해보고 넘어가보자.
#아래의 슬라이더와 위쪽의 버튼을 통해 다양한 버튼의 사용법을 보여주고 있다.

#Df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/globe_contours.csv')
#write.table(Df, file = "globe_contours.csv", sep = ",")
Df <- read.csv("globe_contours.csv")
Df$Id <- seq_len(nrow(Df))

#install.packages("tidyr")
library(tidyr)
D <- Df %>% gather(key, value, -Id) %>% separate(key, c("l", "line"), "\\.") %>% spread(l, value)
Projection = list(type = 'orthographic', rotation = list(lon = -100, lat = 40, roll = 0) )
Lonaxis = list(showgrid = TRUE, gridcolor = toRGB("gray40"), gridwidth = 0.5)
Lataxis = list(showgrid = TRUE, gridcolor = toRGB("gray40"), gridwidth = 0.5)


Geo <- list(showland = TRUE,  showlakes = TRUE,  showcountries = TRUE,  showocean = TRUE,
            countrywidth = 0.5, landcolor = 'rgb(230, 145, 56)', 
            lakecolor = 'rgb(0, 255, 255)', oceancolor = 'rgb(0, 255, 255)',  
            projection = Projection, lonaxis = Lonaxis, lataxis = Lataxis)

# add custom events & dropdow
Selection <- c("equirectangular", "mercator", "orthographic", "natural earth",  "kavrayskiy7","miller", 
               "robinson", "eckert4", "azimuthal equal area", "azimuthal equidistant", 
               "conic equal area", "conic conformal", "conic equidistant", "gnomonic", 
               "stereographic","mollweide", "hammer", "transverse mercator", "albers usa", "winkel tripel")
Projections = data.frame(type = Selection )
All_buttons <- list()
for (i in 1:length(Projections[,])) 
  { All_buttons[[i]] <- list(method = "relayout",
                             args = list(list(geo.projection.type = Projections$type[i])),
                             label = Projections$type[i]) }

# sliders
Lon_range = data.frame(seq(-180, 180, 10))
Lat_range = data.frame(seq(-90, 90, 10))
colnames(Lon_range) <- "x"
colnames(Lat_range) <- "x"

All_lat <- list()
for (i in 1:length(Lat_range[,])) 
  { All_lat[[i]] <- list(method = "relayout",
                         args = list(list(geo.projection.rotation.lat = Lat_range$x[i])),
                         label = Lat_range$x[i]) }

All_lon <- list()
for (i in 1:length(Lon_range[,])) 
  { All_lon[[i]] <- list(method = "relayout", 
                         args = list(list(geo.projection.rotation.lon = Lon_range$x[i])),
                         label = Lon_range$x[i])} 

# annotations
Annot <- list(x = 0, y=0.8, text = "Projection", yanchor = 'bottom', xref = 'paper', 
              xanchor = 'right', showarrow = FALSE)

# original d3-globe with contours
BP <- plot_geo(D) %>%
      group_by(line) %>%
      add_lines(x = ~lon, y = ~lat, color = ~line, colors = 'Reds') %>%
      layout(showlegend = FALSE, geo = Geo)

# plot with custom events
List1 <- list(active = (length(Lon_range[,])-1)/2, currentvalue = list(prefix = "Longitude: "), 
            pad = list(t = 20), steps = All_lon)
List2 <- list(active = (length(Lat_range[,])-1)/2, currentvalue = list(prefix = "Latitude: "), 
            pad = list(t = 100), steps = All_lat)
BP %>%
  layout(annotations = Annot, 
         updatemenus = list(list(active = 2, x = 0, y = 0.8, buttons = All_buttons)),
         sliders = list(List1, List2))
