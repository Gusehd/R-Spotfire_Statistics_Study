install.packages("ggplot2")
library(ggplot2)

#1. 함수 qplot()

qplot(mpg, wt, data = mtcars, colour = cyl ) 
qplot(mpg, wt, data=mtcars, size=cyl)

qplot(mpg, wt, data = mtcars, facets = vs ~ am)

qplot(mpg, data = mtcars)
qplot(mpg, data = mtcars, facets=gear ~., binwidth=2)

qplot(mpg, wt, data = mtcars, geom = "path")

qplot(factor(cyl), wt, data = mtcars, geom = c("boxplot", "jitter"))

qplot(mpg, data = mtcars, geom = "dotplot")

qplot(mpg, wt, data = mtcars, geom = c("point", "smooth"))



#2. 함수 ggplot()

qplot(data = diamonds, x = carat, y = price, geom = "point")
ggplot(diamonds, aes(carat, price)) + geom_point()

qplot(data = diamonds, x = carat, y = price, geom = "line")
ggplot(diamonds, aes(carat, price)) + geom_line()

qplot(data = diamonds, x = carat, y = price, geom = c("point", "line"))
ggplot(diamonds, aes(carat, price)) + geom_line() + geom_point()



#(1) 막대그래프
ggplot(data=warpbreaks, aes(x=tension, y=breaks)) + geom_bar(stat="identity")


# 막대 마다 색 구별
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_bar(stat="identity")

ggplot(data=warpbreaks, aes(x=tension, y=breaks)) + 
  geom_bar(aes(fill=tension), stat="identity")


#측정 자료 표현을 위한 경계선 추가
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_bar(colour="black", stat="identity") 


#범례 없애기
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_bar(colour="black", stat="identity") + guides(fill=FALSE)


# geom의 종류 파악
apropos("geom_")


# 제목 등 그래프 꾸미기
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_bar(colour="black", fill="green", width=.5, stat="identity") + 
  guides(fill=FALSE) +
  xlab("인장 강도") +
  ylab("고장 횟수") +
  ggtitle("인장 강도에 따른 고장 횟수")


## 빈도수 막대그래프
ggplot(data=warpbreaks, aes(x=breaks)) + geom_bar(stat="bin")   # Num of bins = 30

ggplot(data=warpbreaks, aes(x=breaks)) + geom_bar(stat="count")

ggplot(data=warpbreaks, aes(x=breaks)) + geom_bar()


# 누적막대그래프 
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=wool)) + geom_bar(stat="identity")


# 누적 막대그래프의 경계선 및 색 조정
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=wool)) + 
  geom_bar(stat="identity", colour="black") +
  scale_fill_manual(values=c("pink", "green"))


# Lines that go all the way across
# Add a horizontal line
ggplot(data=warpbreaks, aes(x=tension, y=breaks)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_hline(aes(yintercept=60))

# Make the line red and dashed
ggplot(data=warpbreaks, aes(x=tension, y=breaks)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_hline(aes(yintercept=60), colour="#990000", linetype="dashed")


#(2) 선그래프(line graphs)
install.packages("plyr")
library(plyr)
Swarpbreaks <- ddply(warpbreaks, .(tension, wool), summarise, MeanBreaks=round(mean(breaks), 1))
Swarpbreaks


# 다음 두개는 같은 결과 제공
ggplot(data=Swarpbreaks, aes(x=tension, y=MeanBreaks, group=wool)) + geom_line() 
ggplot(data=Swarpbreaks, aes(x=tension, y=MeanBreaks)) + geom_line(aes(group=wool))

# 색 구별
ggplot(data=Swarpbreaks, aes(x=tension, y=MeanBreaks, group=wool, colour=wool)) + geom_line() 
ggplot(data=Swarpbreaks, aes(x=tension, y=MeanBreaks)) + geom_line(aes(group=wool, colour=wool ))


# 점 추가
ggplot(data=Swarpbreaks, aes(x=tension, y=MeanBreaks, group=wool, colour=wool)) + geom_line() + geom_point()


## 표식 구분
ggplot(data=Swarpbreaks, aes(x=tension, y=MeanBreaks, group=wool, shape=wool)) + geom_line() + geom_point()


# 굵은선 및 표식 모양 및 크기 설정
ggplot(data=Swarpbreaks, aes(x=tension, y=MeanBreaks, group=wool, shape=wool)) + 
  geom_line(size=1.5) + 
  geom_point(size=3, fill="white") +
  scale_shape_manual(values=c(22,21))


# 선의 구별, 범례의 위치등 그래프 꾸미기
ggplot(data=Swarpbreaks, aes(x=tension, y=MeanBreaks, group=wool, shape=wool, colour=wool)) +
  geom_line(aes(linetype=wool), size=1) +     ## Set linetype by wool
  geom_point(size=3, fill="white") +          ## Use larger points, fill with white
  ylim(0, max(Swarpbreaks$MeanBreaks)) +      ## Set y range
  scale_colour_hue(name="Wool",               ## Set legend title
                   l=30)  +                   ## Use darker colors (lightness=30)
  scale_shape_manual(name="Wool",
                     values=c(22,21)) +       ## Use points with a fill color
  scale_linetype_discrete(name="Wool") +
  xlab("Time of day") + ylab("Mean of breaks") + ## Set axis labels
  ggtitle("장력에 따른 평균 중단 횟수") +  ## Set title
  theme_bw() + theme(legend.position=c(.7, .4)) ## Position legend inside


install.packages("Rmisc")
library(Rmisc) 
## summarySE provides the standard deviation, standard error of the mean, and a (default 95%) confidence interval
S2warpbreaks <- summarySE(warpbreaks, measurevar="breaks", groupvars=c("tension","wool"))
S2warpbreaks


# 평균의 표준 오차 표현
ggplot(S2warpbreaks, aes(x=tension, y=breaks, group=wool, colour=wool)) + 
  geom_errorbar(aes(ymin=breaks-se, ymax=breaks+se), width=.1) +
  geom_line() +
  geom_point()



# 오차막대의 오버랩 해결
Pd <- position_dodge(0.1) ## move them .05 to the left and right
ggplot(S2warpbreaks, aes(x=tension, y=breaks, group=wool, colour=wool)) + 
  geom_errorbar(aes(ymin=breaks-se, ymax=breaks+se), width=.1, position=Pd) +
  geom_line(position=Pd) +
  geom_point(position=Pd)

# 95% 신리구간 표현
ggplot(S2warpbreaks, aes(x=tension, y=breaks, group=wool, colour=wool)) + 
  geom_errorbar(aes(ymin=breaks-ci, ymax=breaks+ci), width=.1, position=Pd) +
  geom_line(position=Pd) +
  geom_point(position=Pd)


# 오차막대의 색상 결정
ggplot(S2warpbreaks, aes(x=tension, y=breaks, group=wool, colour=wool)) + 
  geom_errorbar(aes(ymin=breaks-ci, ymax=breaks+ci), colour="black", width=.1, position=Pd) +
  geom_line(position=Pd) +
  geom_point(position=Pd, size=3)

# 축이름, 제목 등 그래프 꾸미기
ggplot(S2warpbreaks, aes(x=tension, y=breaks, group=wool, colour=wool)) + 
  geom_errorbar(aes(ymin=breaks-se, ymax=breaks+se), colour="black", width=.1, position=Pd) +
  geom_line(position=Pd) +
  geom_point(position=Pd, size=3, shape=21, fill="white") + ## 21 is filled circle
  xlab("장력(tension)") +
  ylab("mean of breaks") +
  scale_colour_hue(name="Wool",    ## Legend label, use darker colors
                   breaks=c("A", "B"),
                   labels=c("Wool A", "Wool B"),
                   l=40) +                    ## Use darker colors, lightness=40
  ggtitle("장력에 의한 평균 중단 횟수") +
  expand_limits(y=0) +                        ## Expand y range
  scale_y_continuous(breaks=0:20*4) +         ## Set tick every 4
  theme_bw() +
  theme(legend.justification=c(1,0),
        legend.position=c(1,0))               ## Position legend in bottom right


# 막대그래프에서의 표준오차 표현
ggplot(S2warpbreaks, aes(x=tension, y=breaks, fill=wool)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=breaks-se, ymax=breaks+se),
                width=.2,                    ## Width of the error bars
                position=position_dodge(.9))


# 막대그래프에서의 95%의 신뢰구간 표현
ggplot(S2warpbreaks, aes(x=tension, y=breaks, fill=wool)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=breaks-ci, ymax=breaks+ci),
                width=.2,                    ## Width of the error bars
                position=position_dodge(.9))


# 막대그래프에서 축이름, 제목 등 그래프 꾸미기
ggplot(S2warpbreaks, aes(x=tension, y=breaks, fill=wool)) + 
  geom_bar(position=position_dodge(), stat="identity",
           colour="black", ## Use black outlines,
           size=.3) +      ## Thinner lines
  geom_errorbar(aes(ymin=breaks-se, ymax=breaks+se),
                size=.3,    ## Thinner lines
                width=.2,
                position=position_dodge(.9)) +
  xlab("장력(tension)") +
  ylab("평균 중단 횟수") +
  scale_fill_hue(name="Wool", ## Legend label, use darker colors
                 breaks=c("A", "B"),
                 labels=c("Wool A", "Wool B")) +
  ggtitle("장력에 따른 평균 중단 횟수") +
  scale_y_continuous(breaks=0:20*4) +
  theme_bw()



#(3) 히스토그램 및 밀도그래프
# 난수생성 및 (가상)자료 생성
set.seed(1)
Df <- data.frame(Part = factor( rep(c("A","B"), each=100) ), 
                 Rnorm = c(rnorm(100),rnorm(100, mean=1)))
Df


# 기본적인 히스토그램 Each bin is .5 wide.
ggplot(Df, aes(x=Rnorm)) + geom_histogram(binwidth=.5)


# 경계선 및 색 채우기 
ggplot(Df, aes(x=Rnorm)) + 
  geom_histogram(binwidth=.5, colour="black", fill="white")


# 밀도 그래프 
ggplot(Df, aes(x=Rnorm)) + geom_density()


# 히스토그램과 밀도 그래프를 동시에 그리기
ggplot(Df, aes(x=Rnorm)) + 
  geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                 binwidth=.5, colour="black", fill="white") +
  geom_density(alpha=0.2, fill="green")  # Overlay with transparent density plot


# 히스토그램 중첩
ggplot(Df, aes(x=Rnorm, fill=Part)) + geom_histogram(binwidth=.5, alpha=.5, position="identity")


# Interleaved histograms
ggplot(Df, aes(x=Rnorm, fill=Part)) + geom_histogram(binwidth=.5, position="dodge")

ggplot(Df, aes(x=Rnorm, fill=Part)) + geom_histogram(binwidth=.5, position="dodge2")


# 중첩 밀도 그래프
ggplot(Df, aes(x=Rnorm, colour=Part)) + geom_density()


# 중첩 밀도그래프에 색 채우기
ggplot(Df, aes(x=Rnorm, fill=Part)) + geom_density(alpha=0.5)


# 패키지 이용 자료 일부의 통계량 구하기
#install.packages("pylr")
library(plyr)
SDf <- ddply(Df, "Part", summarise, MeanRnorm=mean(Rnorm))
SDf


# 히스토그램에 특정한 선분 추가 
ggplot(Df, aes(x=Rnorm, fill=Part)) +
  geom_histogram(binwidth=.5, alpha=.5, position="identity") +
  geom_vline(data=SDf, aes(xintercept=MeanRnorm,  colour=Part), linetype="dashed", size=1)


# 밀도 그래프에 특정한 선분 추가 
ggplot(Df, aes(x=Rnorm, colour=Part)) + geom_density() +
  geom_vline(data=SDf, aes(xintercept=MeanRnorm,  colour=Part),
             linetype="dashed", size=1)

# 분할도 도입
ggplot(Df, aes(x=Rnorm)) + geom_histogram(binwidth=.5, colour="black", fill="white") + 
  facet_grid(Part ~ .)

ggplot(Df, aes(x=Rnorm)) + geom_histogram(binwidth=.5, colour="black", fill="white") + 
  facet_grid(Part ~ .) +
  geom_vline(data=SDf, aes(xintercept=MeanRnorm),
             linetype="dashed", size=1, colour="red")



# (4)점도표
ggplot(warpbreaks, aes(x=tension, y=breaks)) + 
  geom_dotplot(binaxis="y", stackdir="center")

ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) +  
  geom_dotplot(binaxis="y", stackdir="center")

ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_dotplot(binaxis="y", stackdir="center") +
  guides(fill=FALSE)

ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_dotplot(binaxis="y", stackdir="center") + 
  guides(fill=FALSE) + 
  coord_flip()



# (5) 상자그림
# 기본형
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot()


## 색상과 범례
ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot()


## 범례 제외
ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  guides(fill=FALSE)


## 수평으로 전환
ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() + 
  guides(fill=FALSE) + coord_flip()


## 평균값 추가
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  stat_summary(fun.y=mean, geom="point", shape=8, size=3)

# stat_의 종류 파악
apropos("stat_")


# 제목 추가
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() + 
  ggtitle("인장 강도에 따른 고장 횟수")
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() + 
  labs(title="인장 강도에 따른 고장 횟수")

# 제목의 줄 바꿈
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() + 
  labs(title="인장 강도에 따른 \n 고장 횟수")

# 제목 꾸미기
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() + 
  labs(title="인장 강도에 따른 \n 고장 횟수") +
  theme(plot.title = element_text(lineheight=1.8, face="bold"))

# 범주의 순서 바꾸기
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(limits=c("H","M","L"))

# Reverse the order of a discrete-valued axis
# Get the levels of the factor
Dlevels <- levels(warpbreaks$tension)
Dlevels

# Reverse the order
DRlevels <- rev(Dlevels)
DRlevels

ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(limits=DRlevels)
# 위와 동일
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(limits = rev(levels(warpbreaks$tension)))

# Discrete axis; Setting tick mark labels
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(breaks=c("H", "M", "L"),
                 labels=c("High", "Middle", "Low"))

# Hide x tick marks, labels, and grid lines
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(breaks=NULL)

# Hide all tick marks and labels (on X axis), but keep the gridlines
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
 theme(axis.ticks = element_blank(), axis.text.x = element_blank())

#Continuous axis; Setting range and reversing direction of an axis
# Make sure to include 0 in the y axis
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  expand_limits(y=0)

# Make sure to include 0 and 8 in the y axis
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  expand_limits(y=c(0,80))
# 위와 같은 결과
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  ylim(0, 80)
# 위와 같은 결과
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(limits=c(0, 80))

# y축 범위 제한에 따른 새로운 결과
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  ylim(30,50)
# 위와 같은 결과
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(limits=c(30,50))

# Using coord_cartesian "zooms" into the area
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  coord_cartesian(ylim=c(30,50))

# Specify tick marks directly
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  coord_cartesian(ylim=c(30,50)) + 
  scale_y_continuous(breaks=seq(40,50, 2))  ## Ticks from 0-10, every .25

# Reverse order of a continuous-valued axis
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_reverse()

# y축의 범위 조절 방법
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(breaks=seq(10,80,10))

# y축의 범위 조절 방법 
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(breaks=c(10, 30, 50, 55, 70))

# y축의 범위 제거
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(breaks=NULL)

# Hide tick marks and labels (on Y axis), but keep the gridlines
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  theme(axis.ticks = element_blank(), axis.text.y = element_blank())


# Continuous axis; Axis labels and text formatting
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  theme(axis.title.x = element_blank()) +   ## Remove x-axis label
  ylab("고장 (횟수)")                       ## Set y-axis label

# Also possible to set the axis label with the scale
# Note that vertical space is still reserved for x's label
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(name="") +
  scale_y_continuous(name="고장 (횟수)")

# Change font options:
# X-axis label: bold, red, and 20 points
# X-axis tick marks: rotate 90 degrees CCW, move to the left a bit (using vjust,
#   since the labels are rotated), and 16 points
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  theme(axis.title.x = element_text(face="bold", colour="#990000", size=20),
  axis.text.x  = element_text(angle=90, vjust=0.5, size=16))


#Continuous axis; Tick mark label text formatters
# Label formatters
library(scales)   ## Need the scales package
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(labels=percent) +
  scale_x_discrete(labels=abbreviate)  ## In this particular case, it has no effect


# Self-defined formatting function for times.
timeHMS_formatter <- function(x) {
  h <- floor(x/60)
  m <- floor(x %% 60)
  s <- round(60*(x %% 1))                   ## Round to nearest second
  lab <- sprintf('%02d:%02d:%02d', h, m, s) ## Format the strings as HH:MM:SS
  lab <- gsub('^00:', '', lab)              ## Remove leading 00: if present
  lab <- gsub('^0', '', lab)                ## Remove leading 0 if present
}

ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(label=timeHMS_formatter)


#Continuous axis; Hiding gridlines
# Hide all the gridlines
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  theme(panel.grid.minor=element_blank(),
  panel.grid.major=element_blank())

# Hide just the minor gridlines
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  theme(panel.grid.minor=element_blank())


# Hide all the vertical gridlines
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  theme(panel.grid.minor.x=element_blank(),
  panel.grid.major.x=element_blank())

# Hide all the horizontal gridlines
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  theme(panel.grid.minor.y=element_blank(),
  panel.grid.major.y=element_blank())

# 자료 변환 
Wb <- warpbreaks    # Copy data into new data frame
# Rename the column and the values in the factor
levels(Wb$tension)[levels(Wb$tension)=="L"] <- "Low"
levels(Wb$tension)[levels(Wb$tension)=="M"] <- "Middle"
levels(Wb$tension)[levels(Wb$tension)=="H"] <- "High"
names(Wb)[names(Wb)=="tension"]  <- "Tension"

# View a few rows from the end product
head(Wb)

# Make the plot 
ggplot(data=Wb, aes(x=`Tension`, y=breaks, fill=`Tension`)) +
  geom_boxplot()

# 범례의 제목 조정
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  theme(legend.title = element_text(colour="blue", size=16, face="bold"))

# Removing the legend
# Remove legend for a particular aesthetic (fill)
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  guides(fill=FALSE)
# It can also be done when specifying the scale
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
   scale_fill_discrete(guide=FALSE)
# This removes all legends
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  theme(legend.position="none")

# Changing the order of items in the legend
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  scale_fill_discrete(breaks=c("H","M","L"))

# Reversing the order of items in the legend
# These two methods are equivalent:
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  guides(fill = guide_legend(reverse=TRUE))
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  scale_fill_discrete(guide = guide_legend(reverse=TRUE))
# You can also modify the scale directly:
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  scale_fill_discrete(breaks = rev(levels(warpbreaks$tension)))


# Hiding the legend title
# Remove title for fill legend
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  guides(fill=guide_legend(title=NULL))
# Remove title for all legends
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  theme(legend.title=element_blank())

# Modifying the text of legend titles and labels
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  scale_fill_discrete(name="인장 강도에 따른 \n 고장 횟수")

# 범례의 표현값 변경
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  scale_fill_discrete(name="인장 강도에 따른 \n 고장 횟수",
                      breaks=c("L", "M", "H"),
                      labels=c("Low", "Middle", "High"))


# Using a manual scale instead of hue
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"), 
                    name="Experimental\nCondition",
                    breaks=c("L", "M", "H"),
                    labels=c("Low", "MIddle", "High"))

# Label appearance
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  theme(legend.text = element_text(colour="blue", size = 16, face = "bold"))

# Modifying the legend box
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  theme(legend.background = element_rect())

ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  theme(legend.background = element_rect(fill="gray90", size=.5, linetype="dotted"))

# Changing the position of the legend
Gp <- ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot()

# Position legend in graph :  top 
Gp + theme(legend.position="top")
# Position legend in graph, where x,y is 0,0 (bottom left) to 1,1 (top right)
Gp + theme(legend.position=c(.6, .7))
# Set the "anchoring point" of the legend (bottom-left is 0,0; top-right is 1,1)
# Put bottom-left corner of legend box in bottom-left corner of graph
Gp + theme(legend.justification=c(0,0), legend.position=c(0,0))
# Put bottom-right corner of legend box in bottom-right corner of graph
Gp + theme(legend.justification=c(1,0), legend.position=c(1,0))



# (6) 바이올린 그래프
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_violin(scale="area")

ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) +  geom_violin(scale="area")

ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_violin(scale="area") +
  guides(fill=FALSE)

ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_violin(scale="area") + 
  guides(fill=FALSE) + coord_flip()



#(7) 산점도  

# 자료 구성(가상 자료)
# 정규분포 난수 생성
set.seed(1)
Data <- data.frame(Part  = rep(c("A", "B"), each=20),
                   X = 1:40 + rnorm(40,sd=5),
                   Y = 11:50 + rnorm(40,sd=5), 
                   Z = 21:60 + rnorm(40,sd=6))
Data


# 산점도(기본형)
ggplot(Data, aes(x=X, y=Y)) + geom_point(shape=1)   


# 산점도 + 회귀선 + 신뢰구간
ggplot(Data, aes(x=X, y=Y)) + geom_point(shape=1) + geom_smooth(method=lm)


# 산점도 + 회귀선만
ggplot(Data, aes(x=X, y=Y)) + geom_point(shape=1) + geom_smooth(method=lm,se=FALSE)  


# 산점도 + 회귀선 + 신뢰구간(비선형+신뢰구간)
ggplot(Data, aes(x=X, y=Y)) + geom_point(shape=1) + geom_smooth()          


# Part에 따른 색상구분
ggplot(Data, aes(x=X, y=Y, color=Part)) + geom_point(shape=1)


# Part에 따른 색상구분 + 회귀선
ggplot(Data, aes(x=X, y=Y, color=Part)) + geom_point(shape=1) +
  scale_colour_hue(l=30) + geom_smooth(method=lm, se=FALSE)


# Part에 따른 색상구분 + 회기선(전체 영역에 대한) 
ggplot(Data, aes(x=X, y=Y, color=Part)) + geom_point(shape=1) +
  scale_colour_hue(l=50) + geom_smooth(method=lm, se=FALSE, fullrange=T) 


# Part에 따른 색상구분 + 사용자 지정 모양
ggplot(Data, aes(x=X, y=Y, shape=Part)) + geom_point() + scale_shape_manual(values=c(1,4)) 


# Handling overplotting
# Round xvar and yvar to the nearest 5
Data$Xn <- round(Data$X/10)*10
Data$Yn <- round(Data$Y/10)*10

# Make each dot partially transparent, with 1/4 opacity
# For heavy overplotting, try using smaller values
ggplot(Data, aes(x=Xn, y=Yn)) +
  geom_point(shape=19,      ## Use solid circles
             alpha=1/4)     ## 1/4 opacity

# Jitter the points
# Jitter range is 1 on the x-axis, 2 on the y-axis
ggplot(Data, aes(x=Xn, y=Yn)) +
  geom_point(shape=1,      ## Use hollow circles
             position=position_jitter(width=1,height=2))

# Add a horizontal line
ggplot(Data, aes(x=X, y=Y,  colour=Part)) + geom_point() +
  geom_hline(aes(yintercept=37))

# Add a red dashed vertical line
ggplot(Data, aes(x=X, y=Y,  colour=Part)) + geom_point() +
  geom_hline(aes(yintercept=37)) +
  geom_vline(aes(xintercept=22), colour="#BB0000", linetype="dashed")

install.packages("dplyr")
library(dplyr)

Lines <- Data %>% group_by(Part) %>% summarise( x = mean(X), ymin = min(Y), ymax = max(Y) )

# Add colored lines for the mean xval of each group
ggplot(Data, aes(x=X, y=Y,  colour=Part)) + geom_point() +
  geom_hline(aes(yintercept=37)) +
  geom_linerange(aes(x=x, y=NULL, ymin=ymin, ymax=ymax), data=Lines)


# Continuous axis; Axis transformations: log, sqrt, etc.
# Create some noisy exponentially-distributed data
set.seed(1)
n <- 100
Datan <- data.frame(
  Xval = (1:n+rnorm(n,sd=5))/20,
  Yval = 2*2^((1:n+rnorm(n,sd=5))/20)
)

# A scatterplot with regular (linear) axis scaling
ggplot(Datan, aes(Xval, Yval)) + geom_point()


# log2 scaling of the y axis (with visually-equal spacing)
install.packages("scales")
library(scales)     ## Need the scales package
ggplot(Datan, aes(Xval, Yval)) + geom_point() + 
  scale_y_continuous(trans=log2_trans())

# log2 coordinate transformation (with visually-diminishing spacing)
ggplot(Datan, aes(Xval, Yval)) + geom_point() + 
  coord_trans(y="log2")

# 
set.seed(1)
n <- 100
Data10 <- data.frame( Xval = (1:n+rnorm(n,sd=5))/20,
                      Yval = 10*10^((1:n+rnorm(n,sd=5))/20) )

ggplot(Data10, aes(Xval, Yval)) + geom_point()

#log10
ggplot(Data10, aes(Xval, Yval)) + geom_point() +
  scale_y_log10()

# log10 with exponents on tick labels
ggplot(Data10, aes(Xval, Yval)) + geom_point() +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))


# Continuous axis; Fixed ratio between x and y axes
# Data where x ranges from 0-10, y ranges from 0-30
set.seed(1)
Datau <- data.frame(
  Xval = runif(40,0,10),
  Yval = runif(40,0,30)
)
ggplot(Datau, aes(Xval, Yval)) + geom_point()

## Force equal scaling
ggplot(Datau, aes(Xval, Yval)) + geom_point() + 
  coord_fixed()

# Equal scaling, with each 1 on the x axis the same length as y on x axis
ggplot(Datau, aes(Xval, Yval)) + geom_point() + 
  coord_fixed(ratio=1/3)



# (8) 부분도(Facets)
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1)

ggplot(diamonds, aes(carat, price)) + geom_point(alpha = 1/30)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_grid(cut ~ .)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_grid(. ~ cut)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_grid(color ~ cut)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_wrap( ~ clarity, ncol=2)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_wrap( ~ clarity, nrow=2)


install.packages("reshape2")
library(reshape2)

# Divide with "sex" vertical, "day" horizontal
ggplot(tips, aes(x=total_bill, y=tip/total_bill)) + 
  geom_point(shape=1) +
  facet_grid(sex ~ day)


# Modifying facet label appearance
ggplot(tips, aes(x=total_bill, y=tip/total_bill)) + 
  geom_point(shape=1) +
  facet_grid(sex ~ day) +
  theme(strip.text.x = element_text(size=8, angle=75),
        strip.text.y = element_text(size=12, face="bold"),
        strip.background = element_rect(colour="red", fill="#CCCCFF"))


# Modifying facet label text
Labels <- c(Female = "Women", Male = "Men")
ggplot(tips, aes(x=total_bill, y=tip/total_bill)) + 
  geom_point(shape=1) +
  facet_grid(. ~ sex, labeller=labeller(sex = Labels))


# 정규분포 난수 생성
set.seed(1)
Data <- data.frame(Part  = rep(c("A", "B"), each=20),
                   X = 1:40 + rnorm(40,sd=5),
                   Y = 11:50 + rnorm(40,sd=5) ) 
 
install.packages("dplyr")
library(dplyr)

Lines <- Data %>%
  group_by(Part) %>%
  summarise(x = mean(X),
    ymin = min(Y), ymax = max(Y) )

# Facet, based on Part
ggplot(Data, aes(x=X, y=Y, colour=Part)) + geom_point() +
  facet_grid(. ~ Part)

# Draw a horizontal line in all of the facets at the same value
ggplot(Data, aes(x=X, y=Y, colour=Part)) + geom_point() + facet_grid(. ~ Part) +
  geom_hline(aes(yintercept=37))


Data_vlines <- data.frame(Part=levels(Data$Part), xval=c(10, 11.5))
Data_vlines


ggplot(Data, aes(x=X, y=Y, colour=Part)) + geom_point() + facet_grid(. ~ Part) +
  geom_hline(aes(yintercept=37)) +
  geom_vline(aes(xintercept=xval), data=Data_vlines,
             colour="#990000", linetype="dashed")

  
ggplot(Data, aes(x=X, y=Y, colour=Part)) + geom_point() + facet_grid(. ~ Part) +
  geom_hline(aes(yintercept=37)) +
  geom_linerange(aes(x=x, y=NULL, ymin=ymin, ymax=ymax), data=Lines)
