#1) animation

#plotly에서 움직이는 동적 그래프를 보고 이게 에니메이션 이다. 즉 점이 움직이게
#한다는 개념과 같을 것이다. 옵션에서는 frame 옵션만 추가되고 이를 통해 움직이는
#에니메이션 그래프를 그릴 수 있다.
#(1-1) Basic Example
library(plotly)
Df <- data.frame(X = c(1,2,1),Y = c(1,2,1),F = c(1,2,3))
Df %>% plot_ly(x = ~X, y = ~Y, frame = ~F, type = 'scatter', mode = 'markers', showlegend = F)


#(1-2) Mulitple Trace Animations
#devtools::install_github("jennybc/gapminder")
library(gapminder)
#국가별 경제 수준과 의료 수준 동향을 정리한 데이터 셋이다.

str(gapminder)
head(gapminder)
summary(gapminder)
table(gapminder$continent)
#aggregate(lifeExp ~ continent, gapminder, median)
#국가별 경제 수준에 대한 데이터를 보고 시간이 지날수록 어떻게 해당 요소들이
#변화하는지 보여주는 코드이다. 옵션 자체를 보면 frame 옵션이 year로 되어있다.
#즉 year가 변화함에 따라서 요소들이 움직이는 것을 보여주겠다 라는 뜻이다.
#각 대륙에 따라서 컬로도 구분해서 쉽게 알아볼 수 있는 동적 그래프를 볼 수 있다.

plot(lifeExp ~ year, gapminder, subset = country == "Korea, Rep.", type = "b")
plot(lifeExp ~ gdpPercap, gapminder, subset = year == 2007, log = "x")


if (require("dplyr")) 
  {gapminder %>% filter(year == 2007) %>% group_by(continent) %>% summarise(lifeExp = median(lifeExp))
  
   # how many unique countries does the data contain, by continent?
   gapminder %>% group_by(continent) %>% summarize(n_obs = n(), n_countries = n_distinct(country))
  
   # by continent, which country experienced the sharpest 5-year drop in
   # life expectancy and what was the drop?
   gapminder %>% group_by(continent, country) %>% select(country, year, continent, lifeExp) %>%
   mutate(le_delta = lifeExp - lag(lifeExp)) %>% summarize(worst_le_delta = min(le_delta, na.rm = TRUE)) %>%
   filter(min_rank(worst_le_delta) < 2) %>% arrange(worst_le_delta)
  }

Sys.setenv('MAPBOX_TOKEN' = 'secret token')

BP <- gapminder %>%
        plot_ly(x = ~gdpPercap, y = ~lifeExp, size = ~pop, color = ~continent, frame = ~year, 
                text = ~country, hoverinfo = "text",  type = 'scatter',  mode = 'markers') %>%
        layout(xaxis = list(type = "log"))
BP

#(1-3) Add Animation Options
#에니메이션 옵션을 이런식으로 하면 움직일 때 뚝뚝 끊겨서 움직이게 된다.
#관련 에니메이션 옵션에 대해서는 더 찾아보도록 하자.
BP %>% animation_opts(1000, easing = "elastic", redraw = FALSE)

#(1-4) Add Button Options
#버튼의 위치를 옮겨놓은 옵션이다.
BP %>% animation_button(x = 1, xanchor = "right", y = 0, yanchor = "bottom")

#(1-5) Add Slider Options
#슬라이더의 글자 색을 바꾸는 옵션이다.
BP %>% animation_slider(currentvalue = list(prefix = "YEAR ", font = list(color="red")))


#(1-6) Advanced Example
#지금까지 위에서 한 것을 합쳐 놓은 코드이다. 이런 식으로 파이프 연산자를 통해
#합칠 수 있다.
gapminder %>%
  plot_ly(x = ~gdpPercap, y = ~lifeExp, size = ~pop, color = ~continent, frame = ~year, 
          text = ~country, hoverinfo = "text", type = 'scatter', mode = 'markers') %>%
  layout(xaxis = list(type = "log")) %>% 
  animation_opts(1000, easing = "elastic", redraw = FALSE) %>% 
  animation_button(x = 1, xanchor = "right", y = 0, yanchor = "bottom") %>%
  animation_slider(currentvalue = list(prefix = "YEAR ", font = list(color="red")))



#2. Cumulative Animations
#(2-1) Cumulative Lines Animation
#선그래프로 에니메이션 즉 동적 그래프를 그릴 때 선들의 자취를 남게 하는 
#옵션이다. 코드를 읽어보고 사용해보자.
Accumulate_by <- function(dat, var) 
                   {var <- lazyeval::f_eval(var, dat)
                    lvls <- plotly:::getLevels(var)
                    dats <- lapply(seq_along(lvls), 
                                   function(x){cbind(dat[var %in% lvls[seq(1, x)], ], frame = lvls[[x]])})
                    dplyr::bind_rows(dats)
                   }

BD <- txhousing %>%
        filter(year > 2005, city %in% c("Abilene", "Bay Area")) %>%
        Accumulate_by(~date)

BD %>% plot_ly(x = ~date, y = ~median, split = ~city, frame = ~frame, type = 'scatter', 
               mode = 'lines', line = list(simplyfy = F)) %>% 
       layout(xaxis = list(title = "Date", zeroline = F),  
              yaxis = list(title = "Median", zeroline = F)) %>% 
       animation_opts( frame = 100, transition = 0, redraw = FALSE) %>%
       animation_slider(hide = T) %>%
       animation_button(x = 1, xanchor = "right", y = 0, yanchor = "bottom")



#(2-2) Filled-Area Animation  
#install.packages("quantmod")

#데이터에 따라 선그래프 아래쪽도 색칠 할 수 있다. 또한 동적 그래프는 frame
#이라는 간단한 옵션을 추가하기만 해도 쉽게 그릴 수 있다.

library(quantmod)
getSymbols("AAPL",src='yahoo')

Df <- data.frame(Date=index(AAPL), coredata(AAPL))
Df <- tail(Df, 30)
Df$ID <- seq.int(nrow(Df))

Accumulate_by <- function(dat, var)
                  {var <- lazyeval::f_eval(var, dat)
                   lvls <- plotly:::getLevels(var)
                   dats <- lapply(seq_along(lvls), 
                                  function(x){cbind(dat[var %in% lvls[seq(1, x)], ], 
                                                    frame = lvls[[x]])})
                   dplyr::bind_rows(dats)
                  }

Df <- Df %>% Accumulate_by(~ID)

Df %>% plot_ly(x = ~ID, y = ~AAPL.Close, frame = ~frame, type = 'scatter', mode = 'lines', 
               fill = 'tozeroy', fillcolor='rgba(114, 186, 59, 0.5)', 
               line = list(color = 'rgb(114, 186, 59)'), 
               text = ~paste("Day: ", ID, "<br>Close: $", AAPL.Close), hoverinfo = 'text') %>%
       layout(title = "AAPL: Last 30 days", 
              yaxis = list(title = "Close", range = c(0,250), zeroline = F, tickprefix = "$"),
              xaxis = list(title = "Day", Range = c(0,30), zeroline = F, showgrid = T)) %>%
       animation_opts(frame = 100, transition = 0, redraw = FALSE) %>%
       animation_slider(currentvalue = list(prefix = "Day "))