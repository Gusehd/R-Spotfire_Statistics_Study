install.packages("ggplot2")
library(ggplot2)

#1. 함수 qplot()

#qplot()의 사용방법에 대해서 살펴본다. mtcars 라는 데이터를 사용한다.
#컬러 = 데이터 이런식으로 하면 데이터를 컬러로 구분해 점을 찍어준다.
#상당히 직관적이면서 특이하다. 또한 size = 데이터 도 가능하다.
#아래의 식은 mtcars의 데이터를 mpg와 wt 변수를 가지고 그래프를 그리는 것이다.
#그래서 첫번째가 x축 두번째가 y축이고 qplot이 가능한 그래프를 알아서 
#그려준다는 것이다. colour은 컬러 즉 색을 의미한다.

qplot(mpg, wt, data = mtcars, colour = cyl ) 
qplot(mpg, wt, data=mtcars, size=cyl)

#facets이라는 옵션은 부분도 이다. vs ~ am 은 vs와 am에 대한 형태로 나누어서
#해당 그래프를 그려라 하는 뜻이다. 0 1 / 0 1 즉 vs가 0 1 am 이 0 1 일떄의
#부분을 나누어서 그래프를 그리는 경우이다.
qplot(mpg, wt, data = mtcars, facets = vs ~ am)


#일반적으로 한변수를 넣으면 한변수 그래프는 막대같은 형태만 가능하다.
#그래서 막대가 나오게 된다.
#여기에 facets을 기어수로 나누어서 할 수 있고 bin넓이를 2로 두어서 하면
#잘 나오도록 하고 데이터를 잘 표현할 수 있는 binwidth가 무엇인지는 
#해보면서 알아가야 한다.
qplot(mpg, data = mtcars)
qplot(mpg, data = mtcars, facets=gear ~., binwidth=2)

#아까의 산점도를 다 이어놓은 path 이다.
qplot(mpg, wt, data = mtcars, geom = "path")

#factor는 인자화 시켜서 그 데이터를 wt 를 mtcars 에서 박스플롯 과
#지터는 데이터가 반복해서 있다면 그걸 뒤틀어서 반복된 것을 표현해주는 것
#인데 이를 통해서 표현하고자 하는 것이다.
qplot(factor(cyl), wt, data = mtcars, geom = c("boxplot", "jitter"))

qplot(mpg, data = mtcars, geom = "dotplot")

#스무스 옵션은 산점도 같은 것을 보고 데이터를 잘 설명할 수 있는 회기선 여기선
#비선형 회기 분석을 보여준다. 이후 95퍼의 신뢰구간도 보여주고 상당히 좋은
#것이 qplot 이다.
qplot(mpg, wt, data = mtcars, geom = c("point", "smooth"))



#2. 함수 ggplot()
set.seed(1)
diamonds <- diamonds[sample(nrow(diamonds), 1000), ]
#다이아몬드 데이터에 대해서 시드를 정하고 랜덤으로 1000개를 뽑아낸다.

#ggplot 사용법은 크게 이해하기 어려운 부분은 없다.
#aes를 통해서 x,y를 편하게 표현하는 방법이 있다는 점과 + 로 레이어를
#덮어씌워서 만들어 낸다는 점만 이해하면 된다.
qplot(data = diamonds, x = carat, y = price, geom = "point")
ggplot(diamonds, aes(carat, price)) + geom_point()

qplot(data = diamonds, x = carat, y = price, geom = "line")
ggplot(diamonds, aes(carat, price)) + geom_line()

qplot(data = diamonds, x = carat, y = price, geom = c("point", "line"))
ggplot(diamonds, aes(carat, price)) + geom_line() + geom_point()



#(1) 막대그래프

#막대그래프를 ggplot으로 그리는 방법이다. 그떄 막대그래프는 빈도수로 그리기 
#위해 identity 를 stat으로 준다.
ggplot(data=warpbreaks, aes(x=tension, y=breaks)) + geom_bar(stat="identity")


# 막대 마다 색 

#fill 이라는 옵션을 사용해 데이터 별로 색을 구별 할 수 있다.
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_bar(stat="identity")

ggplot(data=warpbreaks, aes(x=tension, y=breaks)) + 
  geom_bar(aes(fill=tension), stat="identity")


#측정 자료 표현을 위한 경계선 추가

#블랙 라인으로 자료표현을 위해 경계선을 그리는 것이다.
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_bar(colour="black", stat="identity") 


#범례 없애기

#옆의 표현해주고 있는 범례를 없앨려면 guides에서 fill을 FALSE로 
#옵션을 체크하면 된다.
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_bar(colour="black", stat="identity") + guides(fill=FALSE)


# geom의 종류 파악

#geom의 종류를 파악해보고 싶으면 관련 명령어의 종류를 알 수 있는
#apropos를 사용할 수 있다. geom_ 하면 geom_ 로 시작하는 명령어를
#모두 확인 할 수 있다. geom 앞에 ^ 꺾쇠가 있으면 포함 되는 것이고
#없으면 앞에 geom으로 시작하는 것의 차이이다.
apropos("geom_")


# 제목 등 그래프 꾸미기

#xlab , ylab , ggtitle 을 가지고 그래프 타이븥 , x , y 레이블을 정할 수 있다.
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=tension)) + 
  geom_bar(colour="black", fill="green", width=.5, stat="identity") + 
  guides(fill=FALSE) +
  xlab("인장 강도") +
  ylab("고장 횟수") +
  ggtitle("인장 강도에 따른 고장 횟수")


## 빈도수 막대그래프

#하나의 변수에 대해서 바를 그려보는 것이고 stat은 bin으로 되어있다.
#stat 에서 bin은 30이 디폴트 이고 binwidth를 사용하면 숫자를 조절 가능하다.자.
#그래서 아래쪽을 해보면서 어떤 차이가 있는지 확인 해보
ggplot(data=warpbreaks, aes(x=breaks)) + geom_bar(stat="bin")   # Num of bins = 30

ggplot(data=warpbreaks, aes(x=breaks)) + geom_bar(stat="count")

ggplot(data=warpbreaks, aes(x=breaks)) + geom_bar()


# 누적막대그래프

#막대그래프를 누적하는 경우 fill=wool 이런식으로 요소에 대해서 사용한다.
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=wool)) + geom_bar(stat="identity")


# 누적 막대그래프의 경계선 및 색 조정
ggplot(data=warpbreaks, aes(x=tension, y=breaks, fill=wool)) + 
  geom_bar(stat="identity", colour="black") +
  scale_fill_manual(values=c("pink", "green"))


# Lines that go all the way across
# Add a horizontal line

#인위적인 선을 추가하는 경우이다. geom_hline을 통해 그리고 싶은 부분에
#선을 그릴 수 있다.
ggplot(data=warpbreaks, aes(x=tension, y=breaks)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_hline(aes(yintercept=60))

# Make the line red and dashed

#컬러에 대한 속성값도 주면 할 수 있고 라인타입도 옵션으로 줄 수 있다.
ggplot(data=warpbreaks, aes(x=tension, y=breaks)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_hline(aes(yintercept=60), colour="#990000", linetype="dashed")


#(2) 선그래프(line graphs)

#요즘에는 dplyr 이라는 패키지를 더 쓰고 있다.
#ddply라는 것은 변수에 대해서 평균을 구해서 반올림 해주는 것인데 한번 쭉 읽어보자.
#대문자로 되어있는 민브레이크스에 평균을 구해서 넣은 것이다.
#아래는 새로운 요소를 만들고 그에 대해서 선그래프를 그리는 경우이다.
#한번 실행해보면서 살펴보도록 하자.
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
#Rmisc 패키지를 사용한다. 데이터를 요약해서 만들어주는 패키지 이다.
#자주 쓰진 않지만 수정 요약자료가 필요하면 사용한다.
#서머리SE라는 함수를 사용한다. 어떤 데이터에 대해서 측정변수 이고 어떤 것에 대해서
#그룹핑을 할 것인지를 정해서 할 수 있다. 그러면 텐션과 울의 조합에 대해서
#BREAKS 에 대한 정보가 쭉 나오게 된다. CI는 컨피던스 인터벌인데 정규분포를
#가정하지만 분산 이런걸 못쓰니까 T분포를 사용해서 구현하고 T분포의 자유도
#8짜리의 양쪽 값이 들어가고 그게 저쪽에 들어가기 된다. 즉 se에 그 값을 곱한것
#이 ci에 들어가게 되는 것이다.
S2warpbreaks <- summarySE(warpbreaks, measurevar="breaks", groupvars=c("tension","wool"))
S2warpbreaks


# 평균의 표준 오차 표현

#이를 통해 오차를 브레이크에서 se를 뺴고 더한 값대로 그려서 표준 오차를
#표현할 수도 있다.
ggplot(S2warpbreaks, aes(x=tension, y=breaks, group=wool, colour=wool)) + 
  geom_errorbar(aes(ymin=breaks-se, ymax=breaks+se), width=.1) +
  geom_line() +
  geom_point()



# 오차막대의 오버랩 해결

#포지션 언더바 닷지를 통해서 겹치는 부분을 조금 비켜서 그릴 수 있다.
Pd <- position_dodge(0.1) ## move them .05 to the left and right
ggplot(S2warpbreaks, aes(x=tension, y=breaks, group=wool, colour=wool)) + 
  geom_errorbar(aes(ymin=breaks-se, ymax=breaks+se), width=.1, position=Pd) +
  geom_line(position=Pd) +
  geom_point(position=Pd)

# 95% 신리구간 표현

#se가 아닌 ci를 활용한다면 이처럼 95퍼의 신뢰구간도 표현할 수 있다.
#또한 여기서 포지션을 pd로 두는 옵션이 있는데 pd는 위에서 포지션 닷지를
#해준 경우의 옵션이다.
ggplot(S2warpbreaks, aes(x=tension, y=breaks, group=wool, colour=wool)) + 
  geom_errorbar(aes(ymin=breaks-ci, ymax=breaks+ci), width=.1, position=Pd) +
  geom_line(position=Pd) +
  geom_point(position=Pd)


# 오차막대의 색상 결정

#오차막대의 색상도 정할 수 있다.
ggplot(S2warpbreaks, aes(x=tension, y=breaks, group=wool, colour=wool)) + 
  geom_errorbar(aes(ymin=breaks-ci, ymax=breaks+ci), colour="black", width=.1, position=Pd) +
  geom_line(position=Pd) +
  geom_point(position=Pd, size=3)

# 축이름, 제목 등 그래프 꾸미기

#그래프 꾸미는 부분은 실행하고 옵션을 하나씩 살펴보도록 하자.
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

#막대그래프에서도 표준 오차를 표현할 수 있고 95% 신뢰구간 등등 위에서 했던
#모든 것들이 다 가능하다.
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
#part는 reap를 반복해서 rep으로 반복한다는 것이고 100개 이다.
#Rnorm은 100개를 꺼낼 것인데 평균은 1로 나오도록 한다.
Df <- data.frame(Part = factor( rep(c("A","B"), each=100) ), 
                 Rnorm = c(rnorm(100),rnorm(100, mean=1)))
str(Df)


# 기본적인 히스토그램 Each bin is .5 wide.

#가장 기본적인 히스토그램은 변수를 정하고 geom_히스토그램을 bin넓이를
#0.5로 두어서 보는 경우이고 count의 경우니까 막대그래프와 비슷하다.
#상대도수라면 그게 히스토그램일 것이다.
ggplot(Df, aes(x=Rnorm)) + geom_histogram(binwidth=.5)


# 경계선 및 색 채우기 

#컬러는 경계선 , fill 은 내부 색이다.
ggplot(Df, aes(x=Rnorm)) + 
  geom_histogram(binwidth=.5, colour="black", fill="white")


# 밀도 그래프 

#density 를 사용하면 밀도 그래프를 그릴 수 있다. 즉 count가 디폴트 였는데
#그걸 density로 바꾼 것이다.
ggplot(Df, aes(x=Rnorm)) + geom_density()


# 히스토그램과 밀도 그래프를 동시에 그리기
ggplot(Df, aes(x=Rnorm)) + 
  geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                 binwidth=.5, colour="black", fill="white") +
  geom_density(alpha=0.2, fill="green")  # Overlay with transparent density plot


# 히스토그램 중첩

#히스토그램도 이처럼 갈라서 그리기도 할 수 있다. 한번 해보고 확인해보자.
ggplot(Df, aes(x=Rnorm, fill=Part)) + geom_histogram(binwidth=.5, alpha=.5, position="identity")


# Interleaved histograms

#포지션을 닷지로 두어서 하면 위의 중첩되있는 녀석들을 조금 떨어져서 그리고
#닷지2 는 좀더 띄어져서 보이게 그린다.
ggplot(Df, aes(x=Rnorm, fill=Part)) + geom_histogram(binwidth=.5, position="dodge")

ggplot(Df, aes(x=Rnorm, fill=Part)) + geom_histogram(binwidth=.5, position="dodge2")


# 중첩 밀도 그래프
ggplot(Df, aes(x=Rnorm, colour=Part)) + geom_density()


# 중첩 밀도그래프에 색 채우기

#중첩 밀도그래프에 색채우는 방법이고 위쪽과 다른점은 크게 없다.
ggplot(Df, aes(x=Rnorm, fill=Part)) + geom_density(alpha=0.5)


# 패키지 이용 자료 일부의 통계량 구하기
#install.packages("pylr")
library(plyr)
SDf <- ddply(Df, "Part", summarise, MeanRnorm=mean(Rnorm))
SDf


# 히스토그램에 특정한 선분 추가 

#vline을 통해서 라인을 세로로 그려넣을 수 있다. hline과의 차이는 세로 가로
#인 듯 하다.
ggplot(Df, aes(x=Rnorm, fill=Part)) +
  geom_histogram(binwidth=.5, alpha=.5, position="identity") +
  geom_vline(data=SDf, aes(xintercept=MeanRnorm,  colour=Part), linetype="dashed", size=1)


# 밀도 그래프에 특정한 선분 추가 
ggplot(Df, aes(x=Rnorm, colour=Part)) + geom_density() +
  geom_vline(data=SDf, aes(xintercept=MeanRnorm,  colour=Part),
             linetype="dashed", size=1)

# 분할도 도입

#분할도를 그리는데 각 분할도에 대해서 각각 선을 그릴 수도 있다.
ggplot(Df, aes(x=Rnorm)) + geom_histogram(binwidth=.5, colour="black", fill="white") + 
  facet_grid(Part ~ .)

ggplot(Df, aes(x=Rnorm)) + geom_histogram(binwidth=.5, colour="black", fill="white") + 
  facet_grid(Part ~ .) +
  geom_vline(data=SDf, aes(xintercept=MeanRnorm),
             linetype="dashed", size=1, colour="red")



# (4)점도표

#점도표는 dotplot으로 사용한다. 점도표는 이처럼 점을 찍어서 표현해
#데이터가 사라지지 않고 데이터가 어디에 있었는지를 잘 알 수 있다.
#데이터 수가 많지 않다면 유용한 그래프로 사용가능하다.
#stackdir 옵션은 center / centerhole / down / up - 디폴트 가 있다.

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

#ggplot의 상자 그림을 그릴 수 있다. 데이터를 어떤 것으로 사용해서 x축 y축
#정하고 어떤 그림 그릴지 레이어 덮어서 씌우면 된다. 박스 바깥은 점은
#박스 범위를 넘어선 관측치 이고 이게 하나인지 이상인지는 알 수 없고
#데이터로 확인해야한다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot()


## 색상과 범례

#fill에 텐션하면 자동으로 색을 붙여서 그려주게 된다.
ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot()


## 범례 제외

#가이드를 false 하면 범례가 사라진다.
ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() +
  guides(fill=FALSE)


## 수평으로 전환

#coord_filp() 을 추가하면 수평으로 그릴 수 있다. 즉 플립 명령어를 쓴 것이다.
ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_boxplot() + 
  guides(fill=FALSE) + coord_flip()


## 평균값 추가

#stat의 다양한 메소드가 있다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  stat_summary(fun.y=mean, geom="point", shape=8, size=3)

# stat_의 종류 파악
apropos("stat_")


# 제목 추가

#ggtile 이나 labs 를 통해 제목을 붙일 수도 있다. 제목과 관련된 부분은
#아래쪽을 다 확인하면 쉽게 구현하고 있음을 알 수 있다.
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

#스케일_x축이나 y축_discrete 하고 리미트 c 칼럼 순서 하면 그 칼럼의 순서대로
#다시 순서를 정렬해서 보여줄 수 있다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(limits=c("H","M","L"))

# Reverse the order of a discrete-valued axis
# Get the levels of the factor

#d레벨즈를 아래서는 리벌스 해서 그 순서를 바꾼 것이다.
Dlevels <- levels(warpbreaks$tension)
Dlevels

# Reverse the order
DRlevels <- rev(Dlevels)
DRlevels

#그래서 위에서 바꾼 d레벨즈 칼럼을 가지고 사용한 것이고 위쪽의 범주 순서
#바꾸기와 동일한 내용이다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(limits=DRlevels)
# 위와 동일
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(limits = rev(levels(warpbreaks$tension)))

# Discrete axis; Setting tick mark labels

#정렬 순서를 바꾸고 거기에 레이블로 이름을 길게 붙여준 경우이다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(breaks=c("H", "M", "L"),
                 labels=c("High", "Middle", "Low"))

# Hide x tick marks, labels, and grid lines

#아래쪽은 그래프의 그리드 표시와 관련된 옵션들이다 한번씩 실행해보면
#어떤 것이 어떤 것을 의미하는 지 알 수 있다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_x_discrete(breaks=NULL)

# Hide all tick marks and labels (on X axis), but keep the gridlines
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
 theme(axis.ticks = element_blank(), axis.text.x = element_blank())

#Continuous axis; Setting range and reversing direction of an axis
# Make sure to include 0 in the y axis

#리미트 즉 아래 바운더리를 늘려주는 옵션이다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  expand_limits(y=0)

# Make sure to include 0 and 8 in the y axis

#이번에는 바운더리 자체를 칼럼으로 넣어서 세팅하는 방법이다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  expand_limits(y=c(0,80))
# 위와 같은 결과
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  ylim(0, 80)
# 위와 같은 결과
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(limits=c(0, 80))

# y축 범위 제한에 따른 새로운 결과

#ylim과 스케일_y_continuous 는 같은 기능이다. 그런데 만약 이렇게 
#데이터 범위를 벗어나게 찝으면 오류가 나고 몇개의 데이터가 소실되었다
#라고 알려주게 된다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  ylim(30,50)
# 위와 같은 결과
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(limits=c(30,50))

# Using coord_cartesian "zooms" into the area

#이건 확대하고 싶은 부분만 확대하는 기능이다. 확대라서 데이터 소실도 없고
#오류도 뜨지 않는다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  coord_cartesian(ylim=c(30,50))

# Specify tick marks directly
#이건 뒤쪽의 범위는 몇개로 끊어서 볼것이냐 그런 명령어이다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  coord_cartesian(ylim=c(30,50)) + 
  scale_y_continuous(breaks=seq(40,50, 2))  ## Ticks from 0-10, every .25

# Reverse order of a continuous-valued axis

#리버스는 위아래를 뒤집는 명령어 이다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_reverse()

# y축의 범위 조절 방법
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  scale_y_continuous(breaks=seq(10,80,10))

# y축의 범위 조절 방법

#breaks 로 그리드 포인트를 정할 수도 있다.
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

#종합적으로 사용하는 경우이고 글자 색이나 글자 기울이는 부분 , 사이즈에 대한
#옵션이 들어있다.
ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_boxplot() +
  theme(axis.title.x = element_text(face="bold", colour="#990000", size=20),
  axis.text.x  = element_text(angle=90, vjust=0.5, size=16))


#Continuous axis; Tick mark label text formatters
# Label formatters

#y축의 표현을 실수가 아닌 퍼센트로 표현하는 예시이다.
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

#그리드 라인을 모두 없애는 기능이다. 엘리멘트 블랭크를 사용하였다.
#마이너와 메이저 부분에 대해서 모두 옵션이 존재한다.
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

#legend 타이틀 해서 텍스트를 변경한다. 여기서는 제목을 조정하고 있다.
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

#범례가 옆에 있으니까 그래프가 작아져서 보이게 되서 포지션을 top으로 잡아서 
#그래프가 안찌그러지도록 만든다. 그래서 각각 포지션을 잡는 방법에 대해서 4가지
#정도를 보여주고 있다.
Gp + theme(legend.position="top")
# Position legend in graph, where x,y is 0,0 (bottom left) to 1,1 (top right)
Gp + theme(legend.position=c(.6, .7))
# Set the "anchoring point" of the legend (bottom-left is 0,0; top-right is 1,1)
# Put bottom-left corner of legend box in bottom-left corner of graph
Gp + theme(legend.justification=c(0,0), legend.position=c(0,0))
# Put bottom-right corner of legend box in bottom-right corner of graph
Gp + theme(legend.justification=c(1,0), legend.position=c(1,0))


# (6) 바이올린 그래프

#박스플롯은 조금 밋밋한 감이 있는데 즉 어디 부분에 뭐가 많고 그걸 잘 보기
#어렵다. 그럴때는 바이올린 플롯을 통해서 표현하면 조금더 어디에 뭐가 많고
#뭐가 적은지를 살펴볼 수 있다.

ggplot(warpbreaks, aes(x=tension, y=breaks)) + geom_violin(scale="area")

ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) +  geom_violin(scale="area")

ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_violin(scale="area") +
  guides(fill=FALSE)

ggplot(warpbreaks, aes(x=tension, y=breaks, fill=tension)) + geom_violin(scale="area") + 
  guides(fill=FALSE) + coord_flip()



#(7) 산점도  

#변수와 변수간의 관계를 보고 싶으면 이 산점도를 사용한다.

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

#스무드를 사용해서 회귀선과 신뢰구간을 그릴 수 있다.
ggplot(Data, aes(x=X, y=Y)) + geom_point(shape=1) + geom_smooth(method=lm)


# 산점도 + 회귀선만

#se 옴션을 false로 두면 신뢰구간을 끌 수 있다.
ggplot(Data, aes(x=X, y=Y)) + geom_point(shape=1) + geom_smooth(method=lm,se=FALSE)  


# 산점도 + 회귀선 + 신뢰구간(비선형+신뢰구간)

#스무드의 메소드를 1m 으로 두지 않으면 비선형으로 이루어진 회귀선과 신뢰구간
#이 나오게 된다.
ggplot(Data, aes(x=X, y=Y)) + geom_point(shape=1) + geom_smooth()          


# Part에 따른 색상구분

#컬러에 파트를 넣으면 파트로 색을 구분한다. R에서는 이처럼 색이나 사이즈에
#구분 요소를 넣으면 그 구분 요소대로 색과 사이즈를 달리해 각 요소들을 구분해
#준다.
ggplot(Data, aes(x=X, y=Y, color=Part)) + geom_point(shape=1)


# Part에 따른 색상구분 + 회귀선

#파트에 따라서 색상도 구분하고 회귀선도 따로 그릴 수 있다. 즉 컬러 = 파트
#라는 옵션이 들어가는 동시에 뒤쪽의 작업들은 파트별로 다르게 작업이 들어가게
#되는 것이다.
ggplot(Data, aes(x=X, y=Y, color=Part)) + geom_point(shape=1) +
  scale_colour_hue(l=30) + geom_smooth(method=lm, se=FALSE)


# Part에 따른 색상구분 + 회기선(전체 영역에 대한) 

#색상을 구별하지만 그래도 다 보고 싶다 하면 이런식으로 할 수 있고 옵션을
#보면 풀레인지를 T 즉 트루로 두면 된다.
ggplot(Data, aes(x=X, y=Y, color=Part)) + geom_point(shape=1) +
  scale_colour_hue(l=50) + geom_smooth(method=lm, se=FALSE, fullrange=T) 


# Part에 따른 색상구분 + 사용자 지정 모양

#SHApe을 파트로 두면 모양이 파트에 따라 바뀌게 된다.
ggplot(Data, aes(x=X, y=Y, shape=Part)) + geom_point() + scale_shape_manual(values=c(1,4)) 


# Handling overplotting
# Round xvar and yvar to the nearest 5

#라운드 함수를 이용해 소수부분을 날려버렸다.
Data$Xn <- round(Data$X/10)*10
Data$Yn <- round(Data$Y/10)*10

# Make each dot partially transparent, with 1/4 opacity
# For heavy overplotting, try using smaller values
#알파는 오페서티 즉 불투명도 인데 진한것은 중첩되서 나타난 것이고 연한 것은
#조금 있으니까 아 여기 많고 적구나 라고 알 수 있다.
ggplot(Data, aes(x=Xn, y=Yn)) +
  geom_point(shape=19,      ## Use solid circles
             alpha=1/4)     ## 1/4 opacity

# Jitter the points
# Jitter range is 1 on the x-axis, 2 on the y-axis
#지터를 사용해 흩뿌려서 좀 더 보기 편하게 둘 수도 있다.
ggplot(Data, aes(x=Xn, y=Yn)) +
  geom_point(shape=1,      ## Use hollow circles
             position=position_jitter(width=1,height=2))

# Add a horizontal line

#아래 2개는 선을 x축 수직으로 y축 수직으로 그리는 방법이다.
ggplot(Data, aes(x=X, y=Y,  colour=Part)) + geom_point() +
  geom_hline(aes(yintercept=37))

# Add a red dashed vertical line
ggplot(Data, aes(x=X, y=Y,  colour=Part)) + geom_point() +
  geom_hline(aes(yintercept=37)) +
  geom_vline(aes(xintercept=22), colour="#BB0000", linetype="dashed")

install.packages("dplyr")
library(dplyr)

#dplyr 은 파이프 연산자로 연결을 한다 지지플롯은 + 이고 여기는 % 파이프연산자 이다.
#데이터에 대해서 뭘 해라 파트로 그룹하고 x에 대해서는 평균, y는 최소값 등 해서
#그걸 라인에 넣어라 라는 뜻이다.
Lines <- Data %>% group_by(Part) %>% summarise( x = mean(X), ymin = min(Y), ymax = max(Y) )

# Add colored lines for the mean xval of each group
ggplot(Data, aes(x=X, y=Y,  colour=Part)) + geom_point() +
  geom_hline(aes(yintercept=37)) +
  geom_linerange(aes(x=x, y=NULL, ymin=ymin, ymax=ymax), data=Lines)


# Continuous axis; Axis transformations: log, sqrt, etc.
# Create some noisy exponentially-distributed data

#지수적 증가를 하는 랜덤 데이터를 만든다.
#지수적 증가를 하는 것같으면 y축 스케일을 2 2^2 2^3 ... 이런식으로 바꿔서
#리니어 하게 증가하는 듯하도록 그래프를 변경할 수도 있다.
#이때 scales 패키지가 사용된다.
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

#로그2_trans 를 하면 log2를 취해서 보여주게 된다.
ggplot(Datan, aes(Xval, Yval)) + geom_point() + 
  scale_y_continuous(trans=log2_trans())

# log2 coordinate transformation (with visually-diminishing spacing)
#coord_trans 로도 좀더 보기 좋게 그릴 수도 있다.
ggplot(Datan, aes(Xval, Yval)) + geom_point() + 
  coord_trans(y="log2")

#극단적으로 움직이는 경우를 살펴본다.
set.seed(1)
n <- 100
Data10 <- data.frame( Xval = (1:n+rnorm(n,sd=5))/20,
                      Yval = 10*10^((1:n+rnorm(n,sd=5))/20) )

ggplot(Data10, aes(Xval, Yval)) + geom_point()

#log10 즉 상용로그를 취해서 볼 수 있다.
ggplot(Data10, aes(Xval, Yval)) + geom_point() +
  scale_y_log10()

# log10 with exponents on tick labels
#각 로그를 취한 y값에 대해 레이블을 붙여서도 볼 수 있다.
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
#coord 픽스드 하면 같은 수치로 그래프를 줄이거나 변경해서 보기 좋게 바꾼다.
#ratio 즉 비율을 옵션으로 넣음녀 그에 대해서 x , y 축의 비율을 조정되게 된다.
ggplot(Datau, aes(Xval, Yval)) + geom_point() + 
  coord_fixed()

# Equal scaling, with each 1 on the x axis the same length as y on x axis
ggplot(Datau, aes(Xval, Yval)) + geom_point() + 
  coord_fixed(ratio=1/3)



# (8) 부분도(Facets)

#그룹간 자료의 분포형태 , 변화 추이등을 비교 분석에 유용
#비교하려는 축을 기준으로 면을 분할하여 그래프를 그리는 방법
#facet 그리드와 wrap을 사용한다.
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1)

#알파는 이전에도 보았듯이 투명도 이다. 그래서 많이 쌓이면 진해지고 많이 없으면
#연하지는 기능을 넣을 수 있다.
ggplot(diamonds, aes(carat, price)) + geom_point(alpha = 1/30)

#컷을 기준으로 그림판을 행으로 분할한다. 아래쪽은 열로 분할하는 것이고
#변수 cut을 기준으로 범주에 다라 자동으로 분할한다.
#또한 wrap을 통해서 구현하는 방법도 보여주고 있다.
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_grid(cut ~ .)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_grid(. ~ cut)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_grid(color ~ cut)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_wrap( ~ clarity, ncol=2)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point(shape=1) + facet_wrap( ~ clarity, nrow=2)


install.packages("reshape2")
library(reshape2)

# Divide with "sex" vertical, "day" horizontal

#성별과 날짜에 따라서 팁을 어떻게 주는지 살펴보는 데이터 인 듯 하다.
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
#파트로 색도 나느고 facet_grid로 파트에 따라 구간도 나뉘에 그래프를 잘라서
#그리는 방식이다.
ggplot(Data, aes(x=X, y=Y, colour=Part)) + geom_point() +
  facet_grid(. ~ Part)

# Draw a horizontal line in all of the facets at the same value
#수평선 넣는 것은 편하게 geom 에이치라인을 통해서 y절편에 값을 넣어 선을 그릴
#수 있다.
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
