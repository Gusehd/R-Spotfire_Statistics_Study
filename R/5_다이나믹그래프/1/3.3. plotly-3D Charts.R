#1) 3D Scatter Plots 
#(1-1) Basic 3D Scatter Plot
library(plotly)
mtcars$am[which(mtcars$am == 0)] <- 'Automatic'
mtcars$am[which(mtcars$am == 1)] <- 'Manual'
mtcars$am <- as.factor(mtcars$am)

plot_ly(mtcars, x = ~wt, y = ~hp, z = ~qsec, color = ~am, colors = c('#BF382A', '#0C4B8E')) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Weight'), yaxis = list(title = 'Gross horsepower'),
                      zaxis = list(title = '1/4 mile time')))

#(1-2) 3D Scatter Plot with Color Scaling
plot_ly(mtcars, x = ~wt, y = ~hp, z = ~qsec,
        marker = list(color = ~mpg, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>%
   add_markers() %>%
   layout(scene = list(xaxis = list(title = 'Weight'), yaxis = list(title = 'Gross horsepower'),
                       zaxis = list(title = '1/4 mile time')),
   annotations = list(x = 1.13, y = 1.05, text = 'Miles/(US) gallon',
                      xref = 'paper', yref = 'paper', showarrow = FALSE))

#(1-3) 3D Bubble Plot
#Data <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv")
#write.table(Data, file = "gapminderDataFiveYear.csv", sep = ",")
Data <- read.csv("gapminderDataFiveYear.csv")
Data_2007 <- Data[which(Data$year == 2007),]
Data_2007 <- Data_2007[order(Data_2007$continent, Data_2007$country),]
Data_2007$size <- Data_2007$pop
Colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', '#C61951')
plot_ly(Data_2007, x = ~gdpPercap, y = ~lifeExp, z = ~pop, type="scatter3d", 
        mode="markers", color = ~continent, size = ~size, colors = Colors,
        marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(5, 150),
        text = ~paste('Country:', country, '<br>Life Expectancy:', lifeExp, '<br>GDP:',
                       gdpPercap, '<br>Pop.:', pop)) %>%
  layout(title = 'Life Expectancy v. Per Capita GDP, 2007',
         scene = list(xaxis = list(title = 'GDP per capita (2000 dollars)',
                                   gridcolor = 'rgb(255, 255, 255)',
                                   range = c(2.003297660701705, 5.191505530708712),
                                   type = 'log', zerolinewidth = 1, ticklen = 5, gridwidth = 2),
                      yaxis = list(title = 'Life Expectancy (years)',
                                   gridcolor = 'rgb(255, 255, 255)',
                                   range = c(36.12621671352166, 91.72921793264332),
                                   zerolinewidth = 1, ticklen = 5, gridwith = 2),
                     zaxis = list(title = 'Population', gridcolor = 'rgb(255, 255, 255)',
                                  type = 'log', zerolinewidth = 1, ticklen = 5, gridwith = 2)),
         paper_bgcolor = 'rgb(243, 243, 243)', plot_bgcolor = 'rgb(243, 243, 243)')



#2) 3D Line Plots
#(2-1) Basic 3D Line Plot
#Data <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/3d-line1.csv')
#write.table(Data, file = "3d-line1.csv", sep = ",")
Data <- read.csv("3d-line1.csv")
Data$color <- as.factor(Data$color)
plot_ly(Data, x = ~x, y = ~y, z = ~z, type = 'scatter3d', mode = 'lines',
        opacity = 1, line = list(width = 6, color = ~color, reverscale = FALSE))


#(2-2) 3D Line and Markers Plot
X <- c(); Y <- c(); Z <- c(); C <- c()
for (i in 1:62) { r <- 20 * cos(i / 20); X <- c(X, r * cos(i)); Y <- c(Y, r * sin(i));
                  Z <- c(Z, i); C <- c(C, i) }
Data <- data.frame(X, Y, Z, C)
plot_ly(Data, x = ~X, y = ~Y, z = ~Z, type = 'scatter3d', mode = 'lines+markers',
        line = list(width = 6, color = ~C, colorscale = 'Viridis'),
        marker = list(size = 3.5, color = ~C, colorscale = 'Greens', cmin = -20, cmax = 50))


##(2-3) Custom Color Scale
Count <- 3000; X <- c(); Y <- c(); Z <- c(); C <- c()
for (i in 1:Count) {r <- i * (Count - i);  X <- c(X, r * cos(i / 30)); 
                    Y <- c(Y, r * sin(i / 30)); Z <- c(Z, i);   C <- c(C, i) }
Data <- data.frame(X, Y, Z, C)
plot_ly(Data, x = ~X, y = ~Y, z = ~Z, type = 'scatter3d', mode = 'lines',
        line = list(width = 4, color = ~C, colorscale = list(c(0,'#BA52ED'), c(1,'#FCB040'))))


#(2-4) 3D Random Walk Plot
#Data <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/_3d-line-plot.csv')
#write.table(Data, file = "_3d-line-plot.csv", sep = ",")
Data <- read.csv("_3d-line-plot.csv")
str(Data)
plot_ly(Data, x = ~x1, y = ~y1, z = ~z1, type = 'scatter3d', mode = 'lines',
        line = list(color = '#1f77b4', width = 1)) %>%
  add_trace(x = ~x2, y = ~y2, z = ~z2, line = list(color = 'rgb(44, 160, 44)', width = 1)) %>%
  add_trace(x = ~x3, y = ~y3, z = ~z3, line = list(color = 'bcbd22', width = 1))


##(2-5) 3D Density Plot
Dens <- with(diamonds, tapply(price, INDEX = cut, density))
Data <- data.frame(x = unlist(lapply(Dens, "[[", "x")),  y = unlist(lapply(Dens, "[[", "y")),
                   cut = rep(names(Dens), each = length(Dens[[1]]$x)))
plot_ly(Data, x = ~x, y = ~y, z = ~cut, type = 'scatter3d', mode = 'lines', color = ~cut)


#3) 3D Surface Plots
#(3-1) Basic 3D Surface Plot
# volcano is a numeric matrix that ships with R
plot_ly(z = ~volcano) %>% add_surface()

#(3-2) Surface Plot With Contours
plot_ly(z = ~volcano) %>% 
  add_surface(contours = list(z = list(show=TRUE, usecolormap=TRUE, highlightcolor="#ff0000", 
                                       project=list(z=TRUE)))) %>%
  layout(scene = list(camera=list(eye = list(x=1.87, y=0.88, z=-0.64))))


#(3-3) 2D Kernel Density Estimation
Kd <- with(MASS::geyser, MASS::kde2d(duration, waiting, n = 50))
plot_ly(x = Kd$x, y = Kd$y, z = Kd$z) %>% add_surface()


#(3-4) Multiple Surfaces
Z <- c( c(8.83,8.89,8.81,8.87,8.9,8.87),   c(8.89,8.94,8.85,8.94,8.96,8.92),
        c(8.84,8.9,8.82,8.92,8.93,8.91),   c(8.79,8.85,8.79,8.9,8.94,8.92),
        c(8.79,8.88,8.81,8.9,8.95,8.92),   c(8.8,8.82,8.78,8.91,8.94,8.92),
        c(8.75,8.78,8.77,8.91,8.95,8.92),  c(8.8,8.8,8.77,8.91,8.95,8.94),
        c(8.74,8.81,8.76,8.93,8.98,8.99),  c(8.89,8.99,8.92,9.1,9.13,9.11),
        c(8.97,8.97,8.91,9.09,9.11,9.11),  c(9.04,9.08,9.05,9.25,9.28,9.27),
        c(9,   9.01,9,   9.2, 9.23,9.2 ),  c(8.99,8.99,8.98,9.18,9.2,9.19),
        c(8.93,8.97,8.97,9.18,9.2,9.18) )
dim(Z) <- c(15,6)
Z2 <- Z + 1
Z3 <- Z - 1

plot_ly(showscale = FALSE) %>%
  add_surface(z = ~Z) %>%
  add_surface(z = ~Z2, opacity = 0.98) %>%
  add_surface(z = ~Z3, opacity = 0.98)



#4) 3D Mesh Plots
#(4-1) Basic 3D Mesh Plot
set.seed(1)
X <- runif(50, 0, 1); Y <- runif(50, 0, 1); Z <- runif(50, 0, 1)
plot_ly(x = ~X, y = ~Y, z = ~Z, type = 'mesh3d')


#(4-2) Tetrahedron Mesh Plot
plot_ly(type = 'mesh3d', x = c(0, 1, 2, 0), y = c(0, 0, 1, 2), z = c(0, 2, 0, 1),
        i = c(0, 0, 0, 1), j = c(1, 2, 3, 2), k = c(2, 3, 1, 3),
        intensity = c(0, 0.33, 0.66, 1), color = c(0, 0.33, 0.66, 1),
        colors = colorRamp(c("red", "green", "blue")))


#(4-3) Cube Mesh Plot
plot_ly(type = 'mesh3d', x = c(0, 0, 1, 1, 0, 0, 1, 1),  y = c(0, 1, 1, 0, 0, 1, 1, 0),
        z = c(0, 0, 0, 0, 1, 1, 1, 1), i = c(7, 0, 0, 0, 4, 4, 6, 6, 4, 0, 3, 2),
        j = c(3, 4, 1, 2, 5, 6, 5, 2, 0, 1, 6, 3),  
        k = c(0, 7, 2, 3, 6, 7, 1, 1, 5, 5, 7, 6),
        intensity = seq(0, 1, length = 8), color = seq(0, 1, length = 8),
        colors = colorRamp(rainbow(8)))



#5) 3D Tri-Surf Plots
#(5-1) Basic Tri-Surf Plot
plot_ly(type = 'mesh3d', x = c(0, 1, 2, 0), y = c(0, 0, 1, 2), z = c(0, 2, 0, 1), 
        i = c(0, 0, 0, 1), j = c(1, 2, 3, 2), k = c(2, 3, 1, 3), 
        facecolor = toRGB(viridisLite::viridis(4)))


#(5-2) Cube with Different Face Colors
plot_ly(type = 'mesh3d', x = c(0, 0, 1, 1, 0, 0, 1, 1), y = c(0, 1, 1, 0, 0, 1, 1, 0),
        z = c(0, 0, 0, 0, 1, 1, 1, 1),  i = c(7, 0, 0, 0, 4, 4, 2, 6, 4, 0, 3, 7),
        j = c(3, 4, 1, 2, 5, 6, 5, 5, 0, 1, 2, 2),  
        k = c(0, 7, 2, 3, 6, 7, 1, 2, 5, 5, 7, 6),
        facecolor = rep(toRGB(viridisLite::inferno(6)), each = 2))



#(5-3) Helicopter
#install.packages("geomorph")
library(geomorph)

PlyFile <- 'http://people.sc.fsu.edu/~jburkardt/data/ply/chopper.ply'
Dest <- basename(PlyFile)
if (!file.exists(Dest)) {download.file(PlyFile, Dest) }

Mesh <- read.ply(Dest)

# see getS3method("shade3d", "mesh3d") for details on how to plot

# plot point cloud
X <- Mesh$vb["xpts",]
Y <- Mesh$vb["ypts",]
Z <- Mesh$vb["zpts",]
M <- matrix(c(X,Y,Z), ncol=3, dimnames=list(NULL,c("x","y","z")))

## now figure out the colormap
Zmean <- apply(t(Mesh$it), MARGIN=1,function(row){mean(M[row,3])})

library(scales)
Facecolor = colour_ramp(brewer_pal(palette="RdBu")(9))(rescale(x=Zmean))

plot_ly(x = X, y = Y, z = Z, i = Mesh$it[1,]-1, j = Mesh$it[2,]-1, k = Mesh$it[3,]-1,
        facecolor = Facecolor, type = "mesh3d")