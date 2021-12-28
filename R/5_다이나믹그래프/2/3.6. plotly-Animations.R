#1) animation
#(1-1) Basic Example
library(plotly)
Df <- data.frame(X = c(1,2,1),Y = c(1,2,1),F = c(1,2,3))
Df %>% plot_ly(x = ~X, y = ~Y, frame = ~F, type = 'scatter', mode = 'markers', showlegend = F)


#(1-2) Mulitple Trace Animations
#devtools::install_github("jennybc/gapminder")
library(gapminder)

str(gapminder)
head(gapminder)
summary(gapminder)
table(gapminder$continent)
#aggregate(lifeExp ~ continent, gapminder, median)
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
BP %>% animation_opts(1000, easing = "elastic", redraw = FALSE)

#(1-4) Add Button Options
BP %>% animation_button(x = 1, xanchor = "right", y = 0, yanchor = "bottom")

#(1-5) Add Slider Options
BP %>% animation_slider(currentvalue = list(prefix = "YEAR ", font = list(color="red")))


#(1-6) Advanced Example
gapminder %>%
  plot_ly(x = ~gdpPercap, y = ~lifeExp, size = ~pop, color = ~continent, frame = ~year, 
          text = ~country, hoverinfo = "text", type = 'scatter', mode = 'markers') %>%
  layout(xaxis = list(type = "log")) %>% 
  animation_opts(1000, easing = "elastic", redraw = FALSE) %>% 
  animation_button(x = 1, xanchor = "right", y = 0, yanchor = "bottom") %>%
  animation_slider(currentvalue = list(prefix = "YEAR ", font = list(color="red")))



#2. Cumulative Animations
#(2-1) Cumulative Lines Animation
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