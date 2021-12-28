#4. 확률분포들의 그래프 및 중심극한의 정리
#1) 확률분포들의 그래프

# 정규분포 함수의 그래프
X <- seq(40, 160, length = 120)
Hx <- dnorm(X, 100, 20)
plot(X, Hx, type = "l", lty = 1, xlab = "X value",
     ylab = "Density", main = "정규분포(100, 20^2) 밀도함수의 그래프")

# 정규분포의 비교(이론과 난수)
#a. 정규분포의 표본분포
set.seed(1)
Rnorm <- rnorm(1000, 100, 20)
hist(Rnorm,  prob = T, breaks = 30, main = "정규분포의 표본 분포",
     xlab = "확률변수", ylab = "Density")
lines(density(Rnorm), col="blue", lty = 1, lwd = 2)
#b. 정규분포의 이론적 분포
Xfit <- seq(20, 180, length = 160)
Yfit <- dnorm(Xfit, mean = 100, sd = 20)
lines(Xfit, Yfit, pch = 22, col = "red", lty = 1, lwd = 2)
legend('topright', c("난수의 분포", "이론적분포"), 
       col = c("blue", "red"), lty = c(1,1))


## Note: qqnorm(), qqline(), qqplot()
#분위수 계산
n <- 10
Quantile <- c(1 : n) / n
qnorm(Quantile)
# 분위수 보정
Quantile <- ( c(1 : n) - 3/8 ) / ( n + 1/4 )
qnorm(Quantile, 0, 1)
# 분위수 내장 함수
qnorm(ppoints(n))

# QQplot for 정규분포
# 함수 QQnorm() 사용
n <- 100; Mean = 100; Sd = 20;
set.seed(1)
qqnorm(rnorm(100, Mean, Sd))

# QQplot 계산 및 그래프 
set.seed(1)
Quantile <- (c(1 : n)-3/8 ) / (n + 1/4)
plot(qnorm(Quantile), sort(rnorm(n, Mean, Sd)),
     xlab = "이론적 분위수(표준정규분포 분위수)",
     ylab = "표본 분위수", 
     main = "정규 Q-Q Plot")


# qqline()
n <- 100; Mean = 100; Sd = 20;
set.seed(1)
Y <- sort(rnorm(n, Mean, Sd))
qqnorm(Y); qqline(Y)

YY <- quantile(Y, c(0.25, 0.75))
XX <- qnorm(c(0.25, 0.75))
lines(XX, YY, col = 'red', lwd = 5)

# QQplot for 정규분포
n <- 100; Mean = 100; Sd = 20;
set.seed(1)
X = qnorm(ppoints(n))
Y = rnorm(n, Mean, Sd)
qqplot(X, Y)
qqline(Y)
YY <- quantile(Y, c(0.25, 0.75))
XX <- quantile(X, c(0.25, 0.75))
lines(XX, YY, col = 'red', lwd = 5)



# t-분포
X <- seq(-4, 4, length=100)
Hx <- dnorm(X)
D.F. <- c(1, 3, 8, 30)
Colors <- c("red", "blue", "darkgreen", "gold", "black")
Labels <- c("df=1", "df=3", "df=8", "df=30", "normal")
plot(X, Hx, type = "l", lty = 2, xlab = "t(or z) value",
     ylab = "Density", main="자유도에 따른 여러가지 t-분포들")
for (i in 1:4){lines(X, dt(X, D.F.[i]), lwd = 2, col = Colors[i])}
legend("topright", inset =.05, title = "Distributions",
       Labels, lwd = 2, lty = c(1, 1, 1, 1, 2), col = Colors)

#t-분포의 정규화 QQ-Norm
par(mfrow = c(2,2))
set.seed(1)
t_3 <- rt(1000, df = 3); qqnorm(t_3, xlab = "t(3)"); qqline(t_3)
t_10 <- rt(1000, df = 10); qqnorm(t_10, xlab = "t(10)"); qqline(t_10)
t_20 <- rt(1000, df = 20); qqnorm(t_20, xlab = "t(20)"); qqline(t_20)
t_30 <- rt(1000, df = 30); qqnorm(t_30, xlab = "t(30)"); qqline(t_30)



#ChiSquare-분포
#a) 자유도 5까지
par(mfrow = c(1,2))
X <- seq(0, 20, length = 100)
Hx <- dchisq(X,1)
D.F. <- c(1, 2, 3, 4, 5)
Colors <- c("red", "blue", "gold", "darkgreen", "black" )
Labels <- c("df=1", "df=2", "df=3", "df=4", "df=5")
plot(X, Hx, type = "l", lwd = 2, lty = 1, xlab = "x value", col="red",
     ylab = "Density", main="자유도에 따른 여러가지 ChiSquare-분포들")
for (i in 2:5){lines(X, dchisq(X, D.F.[i]), lwd = 2, col = Colors[i])}
legend("topright", inset = .1, title = "Distributions",
       Labels, lwd = 2, lty = c(1, 1, 1, 1, 1), col = Colors)

#b) 자유도 5이상
X <- seq(0, 99, length=100)
Hx <- dchisq(X,5)
D.F. <- c(5, 10, 20, 30, 40)
Colors <- c("black", "blue", "red", "darkgreen", "gold" )
Labels <- c("df=5", "df=10", "df=20", "df=30", "df=40")
plot(X, Hx, type = "l", lwd = 2, lty = 1, xlab = "x value", col="black",
     ylab = "Density", main="자유도에 따른 여러가지 ChiSquare-분포들")
for (i in 2:5){lines(X, dchisq(X, D.F.[i]), lwd = 2, col = Colors[i])}
legend("topright", inset = .1, title = "Distributions",
       Labels, lwd = 2, lty = c(1, 1, 1, 1, 1), col = Colors)

#ChiSquare-분포의 정규화 QQ-Norm
par(mfrow=c(2,2))
set.seed(1)
c_3 <- rchisq(1000, df = 3); qqnorm(c_3, xlab = "cq(3)"); qqline(c_3)
c_10 <- rchisq(1000, df = 10); qqnorm(c_10, xlab = "cq(10)"); qqline(c_10)
c_30 <- rchisq(1000, df = 30); qqnorm(c_30, xlab = "cq(30)"); qqline(c_30)
c_50 <- rchisq(1000, df = 50); qqnorm(c_50, xlab = "cq(50)"); qqline(c_50)



#F-분포의 그래프
library(ggplot2)
ggplot(data.frame(x = c(0,5)), aes(x = x)) +
  stat_function(fun = df, args = list(df1 = 5, df2 = 10), colour = "blue", size = 1) +
  stat_function(fun = df, args = list(df1 = 10, df2 = 30), colour = "red", size = 1) +
  stat_function(fun = df, args = list(df1 = 50, df2 = 50), colour = "black", size = 1) +
  stat_function(fun = df, args = list(df1 = 100, df2 = 100), colour = "green", size = 1) +
  annotate("segment", x = 3, xend = 3.5, y = 1.4, yend = 1.4, colour = "blue", size = 1) +
  annotate("segment", x = 3, xend = 3.5, y = 1.2, yend = 1.2, colour = "red", size = 1) + 
  annotate("segment", x = 3, xend = 3.5, y = 1.0, yend = 1.0, colour = "black", size = 1) +
  annotate("segment", x = 3, xend = 3.5, y = 0.8, yend = 0.8, colour = "green", size = 1) + 
  annotate("text", x = 4.3, y = 1.4, label = "F(df1=5, df2=10)") +
  annotate("text", x = 4.3, y = 1.2, label = "F(df1=10, df2=30)") + 
  annotate("text", x = 4.3, y = 1.0, label = "F(df1=50, df2=5)") +
  annotate("text", x = 4.3, y = 0.8, label = "F(df1=100, df2=100)") +
  ggtitle("F Distribution")

#F-분포의 정규화 QQ-Norm
par(mfrow=c(2,2))
set.seed(1)
F1 <- rf(1000, df1 = 3, df2 = 10); qqnorm(F1, xlab = "f(3,10)"); qqline(F1)
F2 <- rf(1000, df1 = 20, df2 = 30); qqnorm(F2, xlab = "f(20,30)"); qqline(F2)
F3 <- rf(1000, df1 = 100, df2 = 100); qqnorm(F3, xlab = "f(100,100)"); qqline(F3)
F4 <- rf(1000, df1 = 500, df2 = 500); qqnorm(F4, xlab = "f(500,500)"); qqline(F4)



# QQ-Plot; 여러 분포들의 직관적 판단
par(mfrow=c(1,1))
#QQ-t분포
require(graphics)
n = 500 ;   D.F = 3
Basic <- qt(ppoints(n), D.F)
set.seed(1)
qqplot(Basic, rt(n, D.F) )
qqline(Basic, distribution = function(prob) qt(prob, D.F), 
       prob = c(0.25, 0.75), col = 2)
XX <- quantile(qt(ppoints(n), D.F), c(0.25, 0.75))
YY <- quantile( rt(n, D.F), c(0.25, 0.75))
lines(XX, YY, col = 'red', lwd = 5)


D.F = 30
Basic <- qt(ppoints(n), D.F)
set.seed(1)
qqplot(Basic, rnorm(n, 0, 1) )
qqline(Basic, distribution = function(prob) qnorm(prob), prob = c(0.25, 0.75), col = 2)
XX <- quantile(rt(n, D.F), c(0.25, 0.75))
YY <- quantile(qnorm(ppoints(n)), c(0.25, 0.75))
lines(XX, YY, col = 'red', lwd = 5)



#QQ-Chisquare
set.seed(1)
n = 500 ;   D.F = 3
Basic <- qchisq(ppoints(n), D.F)
ChiSq <- rchisq(n, D.F)
## Q-Q plot for Chi^2 data against true theoretical distribution:
qqplot(Basic, ChiSq, main = expression("Q-Q plot for" ~~ {chi^2}[nu == 3]))
qqline(Basic, distribution = function(prob) qchisq(prob, D.F),
       prob = c(0.25, 0.75), col = 2)
mtext("qqline(*, dist = qchisq(., df=3), prob = c(0.25, 0.75))")
XX <- quantile(rchisq(n, D.F), c(0.25, 0.75))
YY <- quantile(Basic, c(0.25, 0.75))
lines(XX, YY, col = 'red', lwd = 5)



#QQ-F 분포
set.seed(1)
n = 500 ;   D.F1 = 30 ;     D.F2 = 30
Basic <- qf(ppoints(n), D.F1, D.F2)
F <- rf(n, D.F1, D.F2)
## Q-Q plot for F data against true theoretical distribution:
qqplot(Basic, F, main = expression("Q-Q plot for" ~~ {F}["30,30"] ))
qqline(Basic, distribution = function(prob) qf(prob, D.F1, D.F2),
       prob = c(0.25, 0.75), col = 2)
mtext("qqline(*, dist = qf(., df1=30, df2=30), prob = c(0.25, 0.75))")
XX <- quantile(rf(n, D.F1, D.F2), c(0.25, 0.75))
YY <- quantile(Basic, c(0.25, 0.75))
lines(XX, YY, col = 'red', lwd = 5)




#2) 이변량 정규분포의 동적그래프
#install.packages("mvtnorm")
library(mvtnorm)
#install.packages("rgl")
library(rgl)
# 좌표의 범위 설정 
X <- seq(-3, 3, .01) -> Y
# x 와 y 의 평면 좌표값 설정
XY <- expand.grid(x=X, y=Y)
# 평균,  표준편차 및 상관계수 설정
Mean = c(0, 0) ;   Rho = 0.7 ;   Sigma_1 = 1 ;   Sigma_2 = 1
Sigma = matrix(c(Sigma_1, Rho, Rho, Sigma_2), 2, 2)
#이변량정규분포 함수값 결정
Z <- dmvnorm(XY, mean = Mean, sigma = Sigma)

persp3d(X, Y, matrix(Z, length(X), length(Y)), smooth = T, 
        color = rgb(0.7,0.5,0.2, 0.5),
        axes = T, xlab = "X", ylab = "Y", zlab = "BiNorm")
play3d(spin3d(axis = c(0, 0,1), rpm = 0.5), duration = 100)



# 3) 중심극한의 정리
Clt <- function( n = 1, reps = 10000, nclass = 30, 
                 norm.param = list(mean = 0, sd = 1),
                 binom.param = list(size = 100, prob = 0.1),
                 unif.param = list(min = 0, max = 20),
                 exp.param = list(rate = 0.1) )
        {old.par <- par(oma = c(0, 0, 2, 0), mfrow =c(2, 2))
        on.exit( par(old.par) )
  
        # Normal
        norm.param$n <- n*reps
        norm.mat <- matrix(do.call('rnorm', norm.param), ncol = n)
        norm.mean <- rowMeans(norm.mat)
        x <- seq(min(norm.mean), max(norm.mean), length = 100)
        normmax <- max(dnorm(x, mean(norm.mean), sd(norm.mean)))
        tmp.hist <- hist(norm.mean, plot = FALSE, nclass = nclass)
        normmax <- max(tmp.hist$density, normmax)*1.05
        hist(norm.mean, main = "정규분포", xlab = "x", col = 'skyblue', 
             freq = FALSE, ylim = c(0, normmax), nclass = nclass)
        lines(density(norm.mean), col = "blue", lty = 1, lwd = 2)
        lines(x, dnorm(x, mean(norm.mean), sd(norm.mean)),
              col = "red", lty = 1, lwd = 2)
  
        # binom
        binom.param$n <- n*reps
        binom.mat <- matrix(do.call('rbinom', binom.param), ncol = n)
        binom.mean <- rowMeans(binom.mat)
        x <- seq(min(binom.mean), max(binom.mean), length = 100)
        binommax <- max(dnorm(x, mean(binom.mean), sd(binom.mean)))
        tmp.hist <- hist(binom.mean, plot = FALSE, nclass = nclass)
        binommax <- max(tmp.hist$density, binommax)
        hist(binom.mean, main = "이항분포", xlab = "x", col = 'skyblue',
        freq = FALSE, ylim = c(0, binommax), nclass = nclass)
        lines(density(binom.mean), col = "blue", lty = 1, lwd = 2)
        lines(x, dnorm(x, mean(binom.mean), sd(binom.mean)),
              col = "red", lty = 1, lwd = 2)
  
        # Uniform
        unif.param$n <- n*reps
        unif.mat <- matrix(do.call('runif', unif.param), ncol = n)
        unif.mean <- rowMeans(unif.mat)
        x <- seq(min(unif.mean), max(unif.mean), length = 100)
        unimax <- max(dnorm(x, mean(unif.mean), sd(unif.mean)))
        tmp.hist <- hist(unif.mean, plot = FALSE, nclass = nclass)
        unimax <- max(tmp.hist$density, unimax)*1.05
        hist(unif.mean, main = "균등분포", xlab = "x", col= 'skyblue',
        freq=FALSE, ylim=c(0, unimax), nclass = nclass)
        lines(density(unif.mean), col = "blue", lty = 1, lwd = 2)
        lines(x, dnorm(x, mean(unif.mean), sd(unif.mean)),
              col = "red", lty = 1, lwd = 2)
  
        # exp
        exp.param$n <- n*reps
        exp.mat <- matrix(do.call('rexp',exp.param), ncol = n)
        exp.mean <- rowMeans(exp.mat)
        x <- seq(min(exp.mean), max(exp.mean), length = 100)
        expmax <- max(dnorm(x, mean(exp.mean), sd(exp.mean)))
        tmp.hist <- hist(exp.mean, plot = FALSE, nclass = nclass)
        expmax <- max(tmp.hist$density, expmax)*1.05
        hist(exp.mean, main = "지수분포", xlab = "x", col = 'skyblue',
             freq = FALSE, ylim = c(0, expmax), nclass = nclass)
        lines(density(exp.mean), col = "blue", lty = 1, lwd = 3)
        lines(x, dnorm(x, mean(exp.mean), sd(exp.mean)),
              col = "red", lty = 1, lwd = 2)
        mtext( paste("표본의 크기 =", n), outer = TRUE, cex = 1)
        invisible(NULL)
        }

Clt(1)
Clt(2)
Clt(20)
Clt(30)