#참고 :   https://plot.ly/r/

#1. 기본 그래프(Basic Charts)

#(1-1) 첫 걸음

#install.packages("plotly")
#packageVersion('plotly')
#plotly는 아주 중요한 , 그리고 유용한 패키지 이다.
#ggplot 처럼 익혀두면 상당히 도움이 많이 될 패키지 이다.
library(plotly)
packageVersion('plotly')

str(midwest)
#plot_ly 에서 color 에 state를 두어서 색으로 구분한 경우이다.
#box 플롯 단위로 확인 한 경우이다. 또한 플롯 창이 나오는 것이 아니라
#뷰어 창이 나오는 것을 알 수 있다. 이런 부분에 있어서도 다르다.
#또한 관련 자료에 대해서 export 를 하면 html 혹은 사진 파일로 저장할 수 있다.
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
#위쪽의 다양한 유형들에 대해서 확인해보도록 하자.

str(economics)
#pop을 x 축으로 두고 히스토그램을 확인한다
plot_ly(economics, type="histogram", x = ~pop)
#타입에 스캐터가 들어가면 모드는 자동적으로 붙는다고 생각하자.
#여기서는 모드를 lines 로 두어서 라인으로연결 시켰다.
plot_ly(economics, type='scatter', mode='lines', x = ~date, y = ~pop)


str(volcano)
#히트맵이나 서페이스 타입의 그래프들도 확인 할 수 있다.
plot_ly(z = ~volcano, type = "heatmap")
plot_ly(z = ~volcano, type = "surface")


#변수 data를 y축으로 연산된 변수 unemploy/pop 을 x축으로 한 선 그래프
add_lines(plot_ly(economics, x = ~date, y = ~unemploy/pop))
# pipe ("%>%")를 사용한 같은 예
#위와 같은 경우지만 파이프 연산자를 통해 이어서 표현한 경우이다.
#위쪽과 코드적으로 다른 부분이 무엇인지 살펴보도록 하자.
economics %>% plot_ly(x = ~date, y = ~unemploy/pop) %>% add_lines()

#파이프 연산자를 활용해서 두개의 선 그래프를 그린다.
#x축을 변수 date로 하고 첫번쨰는 변수 uempmed로 검은 선,
#두번째는 변수 psavert로 빨간색으로 그렸다.
plot_ly(economics, x = ~date, color = I("black")) %>%
   add_lines(y = ~uempmed) %>%
   add_lines(y = ~psavert, color = I("red"))


#이걸 어차피 뒤에도 계속 써야 하니까 이걸 BP에 넣고 이거 뒤에서도 쓸거니까
#그냥 뒤에서 BP로 편하게 쓰는 방법이다.
BP <- plot_ly(iris, x = ~Sepal.Width, y = ~Sepal.Length) 
add_markers(BP, symbol = ~Species)

add_paths(BP, linetype = ~Species)

apropos("^add_")


#(1-2) Scatter plot
#(1-2-1) Basic Scatter Plot
#산점도에서 타입은 다양하게 많이 있다. 마커 , 라인 , 마커 + 라인 등 
#다양한 타입이 존재한다.
plot_ly(data = iris, type='scatter', mode='markers', x = ~Sepal.Length, y = ~Petal.Length)


#(1-2-2) Styled Scatter Plot
#다양한 옵션을 두어서 산점도를 꾸밀 수 있다.
#마커 옵션을 볼 수 있다. 색도 정하고 사이즈도 정할 수도 있따.
#리스트를 사용하는데 리스트는 우리가 사용하고 싶은 것들을 묶어놓은 것이라고
#생각하면 편하다.
#라인 옵션은 마커를 감싸고 있는 선을 의미하는 것이다.
#이후 파이프 연산자로 레이아웃으로 묶어서 타이틀이나 축에대한 이름을 붙여서
#만들 수 있다. 호버는 디폴트로 두어서 건들면 몇콤마 몇인지 알려주게 된다.
#제로라인이 False인데 제로라인은 축의 값을 가지고 선을 그을때 표현
#하냐 안하냐 인데 여기서는 의미가 없다. 즉 0이라는 값이 옆의 그래프에
#없기 떄문이다. 만약 0의 값이 있다면 그부분을 진하게 표현하겠다 그런 뜻이다.
plot_ly(data = iris, type='scatter', mode='markers',x = ~Sepal.Length, y = ~Petal.Length,
               marker = list(size = 10, color = 'rgba(255, 182, 193, .9)',
               line = list(color = 'rgba(152, 0, 0, .8)', width = 2))) %>%
  layout(title = 'Styled Scatter', yaxis = list(zeroline = FALSE), xaxis = list(zeroline = FALSE))


#(1-2-3) Qualitative Colorscales
#칼라 부분에서 좀더 다양한 옵션을 볼 수 있다.
#여기서도 컬러 = 요소 하면 요소에 따라 자동으로 구분을 해주는 것을 볼 수 있다.
plot_ly(data = iris, type='scatter', mode = 'markers', 
        x = ~Sepal.Length, y = ~Petal.Length, color = ~Species)


#(1-2-4) ColorBrewer Palette Names
#만약 컬러가 Set1 이런식으로 주어진 세트를 사용하면 색이 미리 정해진 순서대로
#요소들에 따라서 입력이 되고 그 색대로 들어간다.
plot_ly(data = iris, type='scatter', mode = 'markers', 
        x = ~Sepal.Length, y = ~Petal.Length, color = ~Species, colors = "Set1")


#(1-2-5) Custom Color Scales
#만약 이런식으로 손수 컬러 세트를 만들어 놓았다면 이런식으로도 사용해
#내 마음대로 색을 넣을 수도 있다.
Pal <- c("red", "blue", "green")
plot_ly(data = iris, type='scatter', mode = 'markers', 
        x = ~Sepal.Length, y = ~Petal.Length, color = ~Species, colors = Pal)

Pal <- c("red", "blue", "green")
Pal <- setNames(Pal, c("virginica", "setosa", "versicolor"))
plot_ly(data = iris, type='scatter', mode = 'markers', 
             x = ~Sepal.Length, y = ~Petal.Length, color = ~Species, colors = Pal)


#(1-2-6) Mapping Data to Symbols
#표식자 들에 대해서 정할 수 있다. 심볼 하고 칼럼에 순서대로 서클이나 x , o
#같은 표식자를 넣어주면 그에 대해서 자동으로 표식자를 정해준다.
plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length, type = 'scatter',
        mode = 'markers', symbol = ~Species, symbols = c('circle','x','o'),
        color = I('black'), marker = list(size = 10))


#(1-2-7) Adding Color
set.seed(1)
Data <- diamonds[sample(nrow(diamonds), 1000), ]
plot_ly(Data, x = ~carat, y = ~price, type = 'scatter', mode = 'markers', color = ~price )

#(1-2-8) Data Labels on Hover
#우리가 호버를 했을 때 text를 두어서 가격이 뭐고 <br> 이건 html 스타일로 
#해서 컷은 cut 나오게 해서 호버시 원하는 텍스트를 나오게 만들었다.
#이러한 동적 그래프 , 완전한 동적 그래프는 아니지만 어느정도 동적인
#그래프는 데이터를 살펴보는 부분에서 의미가 있을 수 있다.
plot_ly(Data, x = ~carat, y = ~price, type = 'scatter', mode = 'markers',
        text = ~paste("가격: ", price, '$<br>Cut:', cut), color = ~carat)



#(1-3) Line Plot
#(1-3-1) Basic Line Plot
#라인 플롯 즉 선그래프에 대해서 살펴본다. 타입을 스캐터 두고 모드에서
#라인으로 두어서 선 그래프를 만들 수 있다.
#간단한 plot_ly의 구조를 보고 옵션과 사용법의 감을 잡아보자.
#아래의 구조에서는 스캐터 즉 산점도로 그리고 그 점을 라인으로 그린 것이다.
set.seed(1)
X <- c(1:100)
Rand_y <- rnorm(100, mean = 0)
Data <- data.frame(X, Rand_y)

plot_ly(Data, x = ~X, y = ~Rand_y, type = 'scatter', mode = 'lines')



#(1-3-2) Plotting Markers and Lines

#마커를 두어서 선과 점을 함께 표현하는 경우를 살펴보자.
#즉 모드 부분에서만 차이를 보이고 있는데 모드에서 라인 , 마커 , 마커 + 라인
#이런 3가지 경우를 보고 다 이런 부분에 대해서 모드를 사용가능하다.
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

#사용할 데이터를 월수와 함께 다양한 부분으로 세팅해놓았다.
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

#위의 데이터에서 월은 문자형이라 순서가 다르다. 그래서 데이터에서 먼스에서
#팩터에서 레빌을 정하는 것이다. 데이터의 먼스 개념을 먼스 즉 월 개념으로
#두겠다 이런 식으로 세팅 해놓은 것이다.

#그래서 선을 6가지 그리는데 다 다른 스타일로 그리는 것을 보여준다.
#다 옵션에만 차이가 있는데 일단 라인 = 리스트로 두어 옵션을 리스트로 묶었다.
#이후 그 옵션들을 적용시키는데 컬러 , 넓이 , 대시 등등 세팅을 둘 수 있다.
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
#데이터를 라인 타입으로 맵핑해서 보여주는 방법이다.
library(plyr)
TG <- ddply(ToothGrowth, c("supp", "dose"), summarise, Length=mean(len))
plot_ly(TG, x = ~dose, y = ~Llength, type = 'scatter', mode = 'lines', linetype = ~supp, color = I('black')) %>%
   layout(title = '보충제 종류에 따른 기니피그의 치아 성장에 대한 비타민 C의 효과',
          xaxis = list(title = '복용량(mg/day)'), yaxis = list (title = '치아 길이'))


#(1-3-5) Connect Data Gaps
#x 데이터를 잡갔고 y데이터를 정수형 형태로 잡갔다. 중간의 NA 즉 결측치가 섞여
#있도록 데이터를 만들었다. 이걸로 그림을 그리는데 plot_ly의 첫줄만 실행하면
#그냥 NA 즉 결측치 부분에서느 선이 끊어지게 나온다.
#이후 Y에서 5를 뺸 새로운 데이터를 가지고 캡이 없도록 만들어 본다.
#즉 커넥트 갭 부분에서 TRUE로 두어서 갭을 잇겠다 이런 식으로 옵션을 둔 것이다.
#그러면 그 부분에서는 직선 개념으로 그냥 선을 그어서 그려주게 된다.
X <- c(1:15);  Y <- c(10, 20, NA, 15, 10, 5, 15, NA, 20, 10, 10, 15, 25, 20, 10)
Data <- data.frame(X, Y)
plot_ly(Data, x = ~X, y = ~Y, name = "Gaps", type = 'scatter', mode = 'lines') %>%
   add_trace(y = ~Y-5, name = "<b>No</b> Gaps", connectgaps = TRUE)


#(1-3-6) Line Interpolation Options
#같은 데이터에 대해서 선을 애드 라인 하는 것이다. 그래서 각각 Shape 옵션을
#보면 리니어 , 스플라인 , vhv , hvh , vh , hv 로 나뉘어져 있다.
#각각 확인해보고 어느 방식으로 표현하는지 확인 해보자.
#그리고 대부분 사용할 때는 직선 즉 리니어나 스플라인을 사용한다.
X <- c(1:5);     Y <- c(1, 3, 2, 3, 1)
plot_ly(x = ~X) %>%
   add_lines(y = ~Y, name = "linear", line = list(shape = "linear")) %>%
   add_lines(y = Y + 5, name = "spline", line = list(shape = "spline")) %>%
   add_lines(y = Y + 10, name = "vhv", line = list(shape = "vhv")) %>%
   add_lines(y = Y + 15, name = "hvh", line = list(shape = "hvh")) %>%
   add_lines(y = Y + 20, name = "vh", line = list(shape = "vh")) %>%
   add_lines(y = Y + 25, name = "hv", line = list(shape = "hv"))


#(1-3-7) Label Lines with Annotations
#x는 2001 ~ 2012년도 까지의 년도를 넣고 인터넷과 텔레비전에 대한 데이터를
#넣어주었다. 이를 통해서 데이터를 살펴볼 수 있다.
#이후 x축과 y축에 대해서 옵션을 다 설정해서 넣어줄었다.
#이후 마진에도 옵션을 넣어주었다. 마진은 위 아래 좌 우에 마진 즉 공간을
#얼마나 두고 그리냐 에 대한 옵션이다.
X <- c(2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012)
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
#x앵커와 y액커는 닻 처럼 어느 부분에 고정을 할 것이냐 에 대한 옵션이다.
#그래서 텔레지번 1 , 2 인터넷 1 , 2로 우리가 표현하고 싶은 것을 리스트로
#옵션으 싹 정리해 두었다. 이후 애드 트레이스로 해당 옵션에 대해서
#그림을 그리고 있다. 이때 레이아웃에서 위에서 만든 x축 , y축 , 마진 옵션을
#사용해서 그리고 있다.
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

#라인을 색칠하고 싶을 때가 있다. 그럴 때 사용하는 코드다.
#일단 데이터를 설정한다. 이번에도 역시 월 데이터를 팩터로 레벨을 두어
#월순으로 다시 표현되도록 한다.
Month <- c('January', 'February', 'March', 'April', 'May', 'June', 'July',
           'August', 'September', 'October', 'November', 'December')
High_2014 <- c(28.8, 28.5, 37.0, 56.8, 69.7, 79.7, 78.5, 77.8, 74.1, 62.6, 45.3, 39.9)
Low_2014 <- c(12.7, 14.3, 18.6, 35.5, 49.9, 58.0, 60.0, 58.6, 51.7, 45.2, 32.2, 29.1)
Data <- data.frame(Month, High_2014, Low_2014)
Data$Average_2014 <- rowMeans(Data[,c("High_2014", "Low_2014")])
Data$Month <- factor(Data$Month, levels = Data[["Month"]])

# fill = 'tozeroy'    # fill = 'tonexty'     # fill = 'toself'

#각 월의 로우값 하이값을 두고 그 평균선을 그려놓은 것이다.
#그래서 옵션을 보면 fill에 tonexty로 두어 로우값부터 하이값까지 칠하도록 하였다.
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
#with 펑션을 두어서 가격에 대한 정보를 뽑겠다. 그런데 뭐로? 인덱스는 컷으로
#즉 컷 종류에 따라 가격을 뽑아내겠다는 것이다.
#이후 x값을 어떻게 , y값은 어떻게 할지 건드리는 것이다.
#이후 dense를 조정해서 density를 보는 가격에 대한 밀도 함수를 보는 것이다.
#그래서 이런 가격에서 이게 가장 많은 밀도 즉 많이 존재하는 구나를 볼 수 있다.
#이 밀도함수 부분에서 좀 더 세밀하게 사용하려면 좀 더 공부가 필요하다.

#그래서 최종적으로는 산점도와 라인그래프는 점을 그리고 선을 잇냐 잇지 않느냐의
#사소한 차이만 존재할 뿐 어느정도 비슷한 개념이다.
#R에서 코드를 통해 구현할때도 옵션에서 타입이 스캐터일때 모드가 라인인지
#마커인지에 대해 차이만 있는 것이다.
Dens <- with(diamonds, tapply(price, INDEX = cut, density))
Df <- data.frame(X = unlist(lapply(Dens, "[[", "x")), Y = unlist(lapply(Dens, "[[", "y")),  
                 cut = rep(names(Dens), each = length(Dens[[1]]$x)))
plot_ly(Df, x = ~X, y = ~Y, color = ~cut) %>%  add_lines()



#(1-4)Bar Charts
# 1-4-1 ~ 1-4-3
#(1-4-1) Basic Bar Chart

#바차트를 살펴본다. plot_ly의 타입을 bar로 하면 된다.
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
#바모드는 그룹 방식과 스택 방식이 있고 확인해보자.
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

#텍스트 옵션이 바로 호버 옵션이다. 그래서 텍스트를 미리 만들어 두었고
#그걸 활용해서 호버 옵션 즉 텍스트 옵션을 달아준 것이다.
plot_ly(Data, x = ~X, y = ~Y, type = 'bar', text = Text, marker = list(color = 'rgb(158,202,225)',
        line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
   layout(title = "", xaxis = list(title = ""), yaxis = list(title = ""))

#(1-4-5) Grouped Bar Chart with Direct Labels
#참조 textposition = 'auto'   'outside'    'inside'     'none'
#디폴트는 none 이고 밖에 넣고싶으면 아웃사이드 안이면 인사이드로 두면 된다.
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
#바 폭에 대한 부분도 세팅 할 수 있다.
X= c(1, 2, 3, 5.5, 10);   Y= c(10, 8, 6, 4, 2)
Width = c(0.8, 0.8, 0.8, 3.5, 4)
Data <- data.frame(X, Y, Width)
plot_ly(Data) %>% add_bars(x= ~X, y= ~Y, width = ~Width  )


#(1-4-10) Customizing Individual Bar Base
#또한 각각의 바 즉 막대 자체에 베이스라인을 주면서 +와 -의 개념을 달리 줄
#수 있다.
plot_ly() %>%
   add_bars(x = c("2016", "2017", "2018"), y = c(500,600,700), base = c(-500,-600,-700), 
            marker = list(color = 'red'), name = 'expenses' ) %>%
   add_bars(x = c("2016", "2017", "2018"), y = c(300,400,700), base = 0,
            marker = list(color = 'blue'), name = 'revenue')


#(1-4-11) Mapping a Color Variable
#install.packages("dplyr")
library(dplyr)
#요소에 따라 색을 주고 또 바 플롯으로 두고 카운트를 해서 붙여주었다.
#실행하고 알아보자.
ggplot2::diamonds %>% count(cut, clarity) %>%
   plot_ly(x = ~cut, y = ~n, type='bar', color = ~clarity)



#(1-4-12) Colored and Styled Bar Chart
#바 차트에 대해서 색을 주고 스타일을 넣은 부분이다. 옵션에 대해서는 한번
#쭉 읽어보면서 파악하는 것이 좋다.
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

#경제 상황을 살펴볼 때 많이 사용하는 워터폴 모델 이다.
#한번 사용하고 옵션에 대해서 확인 해보자.
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

#설문조사 결과 같은 막대그래프 타입의 그래프 이다. 이런 팔레트 형식으로도
#바 차트를 사용할 수 있구나 정도를 확인하면 좋을 듯 하다.
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

#서브플롯은 수직이나 수평으로 분할해서 왼쪽 하나 오른쪽 하나 이런식으로
#다른 성질의 그래프를 2가지 그릴 수 있다. 그래서 p1 과 p2 그래프를 따로
#만들어 두고 서브플롯으로 p1 , p2 를 같이 그린 것이고 서브플롯에 대한 내용은
#나중에 뒤에서 더 살펴보도록 하자.
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

plot_ly(Data, labels = ~Categorie, values = ~X1960, type = 'pie') %>%
   layout(title = 'United States Personal Expenditures by Categories in 1960')
 

#(1-5-2) Subplots
#install.packages("dplyr")
library(dplyr)
plot_ly() %>%
   add_pie(data = count(diamonds, cut), labels = ~cut, values = ~n, textinfo = 'label+percent',
           name = "Cut", domain = list(x = c(0, 0.5), y = c(0, 0.5))) %>%
   add_pie(data = count(diamonds, color), labels = ~color, values = ~n, textinfo = 'label+value',
           name = "Color", domain = list(x = c(0.5, 0.8), y = c(0.5, 0.8))) %>%
   add_pie(data = count(diamonds, clarity), labels = ~clarity, values = ~n, textinfo = "percent",
           name = "Clarity", domain = list(x = c(0.8, 1), y = c(0.8, 1))) %>%
   layout(title = "Pie Charts with Subplots", showlegend = FALSE)


##(1-5-3) Subplots Using Grid
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
Data <- read.csv("school_earnings.csv")
str(Data)

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
plot_ly(Data, x = ~Women, y = ~Men, text = ~School, type = 'scatter', mode = 'markers', 
        color = ~Gap, colors = 'Reds', marker = list(size = ~Gap, opacity = 0.5)) %>%
   layout(title = 'Gender Gap in Earnings per University',
          xaxis = list(showgrid = FALSE), yaxis = list(showgrid = FALSE))


#(1-6-5) Mapping a Color Variable (Categorical)
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
#(1-7-1) Basic Filled Area Plot
Density <- density(diamonds$carat)
plot_ly(x = ~Density$x, y = ~Density$y, type = 'scatter', mode = 'lines', fill = 'tozeroy') %>%
   layout(xaxis = list(title = 'Carat'), yaxis = list(title = 'Density'))


#(1-7-2) Filled Area Plot with Multiple Traces
Diamonds1 <- diamonds[which(diamonds$cut == "Fair"),]
Density1 <- density(Diamonds1$carat)
Diamonds2 <- diamonds[which(diamonds$cut == "Ideal"),]
Density2 <- density(Diamonds2$carat)

plot_ly(x = ~Density1$x, y = ~Density1$y, type = 'scatter', mode = 'lines', name = 'Fair cut', 
        fill = 'tozeroy') %>%
   add_trace(x = ~Density2$x, y = ~Density2$y, name = 'Ideal cut', fill = 'tozeroy') %>%
   layout(xaxis = list(title = 'Carat'), yaxis = list(title = 'Density'))

#(1-7-3) Custom Colors
plot_ly(x = ~Density1$x, y = ~Density1$y, type = 'scatter', mode = 'lines', name = 'Fair cut', 
        fill = 'tozeroy', fillcolor = 'rgba(168, 216, 234, 0.5)', line = list(width = 0.5)) %>%
   add_trace(x = ~Density2$x, y = ~Density2$y, name = 'Ideal cut', fill = 'tozeroy', 
             fillcolor = 'rgba(255, 212, 96, 0.5)') %>%
   layout(xaxis = list(title = 'Carat'), yaxis = list(title = 'Density'))

#(1-7-4) Area Plot without Lines
plot_ly(x = ~Density1$x, y = ~Density1$y, type = 'scatter', mode = 'none', name = 'Fair cut', 
        fill = 'tozeroy', fillcolor = 'rgba(168, 216, 234, 0.5)') %>%
   add_trace(x = ~Density2$x, y = ~Density2$y, name = 'Ideal cut', fill = 'tozeroy', 
             fillcolor = 'rgba(255, 212, 96, 0.5)') %>%
   layout(xaxis = list(title = 'Carat'), yaxis = list(title = 'Density'))



#(1-7-5) Selecting Hover Points
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

#for문을 돌면서 add 트레이스를 판위에 계속 그려나가는 코드이다.
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
#그리드 라인도 없애고 뒤족 색을 검은 색으로 바꾸는 코드이다.
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

#위쪽과 달리 글자를 써넣을 것인데 그걸 어디다 쓸지 정하고 써넣는 코드이다.
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
#다중차트 하나의 판에 여러개의 그래프를 섞는 것이다.
#막대와 선을 함께 그리는 경우를 살펴보자.
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
#산점도에 회귀선을 넣어서 표현한 경우이다. fitted 라는 옵션을 사용해서 해당
#피쳐와 레이블에 대해 피팅을 하고 선을 표현해준다.
plot_ly(mtcars, x = ~disp, color = I("black")) %>%
   add_markers(y = ~mpg, text = rownames(mtcars), showlegend = FALSE) %>%
   add_lines(y = ~fitted(loess(mpg ~ disp)), line = list(color = '#07A4B5'), name = "Loess Smoother", 
             showlegend = TRUE) %>%
   layout(xaxis = list(title = 'Displacement (cu.in.)'), yaxis = list(title = 'Miles/(US) gallon'), 
          legend = list(x = 0.80, y = 0.90))


#(1-9-3) Loess Smoother with Uncertainty Bounds
##install.packages("broom")
#broom의 augment라는 함수에서 계산해서 통계적인 계산을 할 수 있도록 한다.
#즉 해당 요소들에 대해 피팅한 에러값이나 편차값 등등을 보여주게 된다.
#이를 통해 회귀선에 대해 신뢰구간도 표현할 수 있다.
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
#점도표에 대한 경우이다. 
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
#게이지 차트를 본다. 파이차트의 개념으로 반을 잘라서 가는 마인드 이다.
#즉 파이차트를 잘라서 사용한다는 느낌 이다. 그래서 맨 아래의 코드를 보면
#자동차 엔진 게이지 처럼 눈금에 어디에 있는지 보여주고 있다.
#이처럼 다이얼을 넣으면 엔진 게이지 처럼 지금 위치가 어딘지 보여줄 수도 있다.
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