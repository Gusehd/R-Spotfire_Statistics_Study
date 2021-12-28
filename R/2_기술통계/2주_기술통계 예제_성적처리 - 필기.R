#옵션으로 유효숫자를 디폴트가 7에 80 인데 , 그게 싫어서 5에
#120으로 만든 것이다. 아래의 주석은 R을 사용하는 방법들 이다.
#나중에 한번 읽어보도록 하자.

options(digits=5, width=120)

## Working directory
#getwd() # Shows the working directory (wd)
#setwd(choose.dir()) # Select the working directory interactively
#setwd("C:/myfolder/data") # Changes the wd
#setwd("H:\\myfolder\\data") # Changes the wd

## Creating directories/downloading from the internet
#dir() # Lists files in the working directory
#dir.create("C:/myfolder") # Creates folder ‘test’ in drive ‘C:’
#setwd("C:/myfolder") # Changes the working directory to “C:/myfolder”

## Download file ‘***.xls’ from the internet.
#download.file("http://***.***/****/***.xls", "C:/Myfolder/****..xls", method="auto",
#              quiet=FALSE, mode = "wb", cacheOK = TRUE)

## Installing/loading packages/user???written programs
## install.packages("ABC") # This will install the package ???-ABC--. A window will pop-up, select a
## mirror site to download from (the closest to where you are) and click ok.
## library(ABC) # Load the package ???-ABC-??? to your workspace
## Install the following packages:
#install.packages("foreign")
#library(foreign)
#install.packages("car")
#install.packages("Hmisc")
#install.packages("reshape")

##  http://cran.r-project.org/web/views/  # Full list of packages by subject area

## Keeping track of your work
## Save the commands used during the session
#savehistory(file="mylog.Rhistory")

## Load the commands used in a previous session
#loadhistory(file="mylog.Rhistory")

## Display the last 25 commands
#history()

##  You can read mylog.Rhistory with any word processor. Notice that the file has to have the extension
##  *.Rhistory

## Getting help
#?plot # Get help for an object, in this case for the ???-plot??? function. You can also type: help(plot)
#??regression # Search the help pages for anything that has the word "regression". You can also type:
#help.search("regression")
#apropos("기말고사") # Search the word "기말고사" in the objects available in the current R session.
#help(package=car) # View documentation in package ‘car’. You can also type: library(help="car“)
#help(DataABC) # Access codebook for a dataset called ‘DataABC’ in the package ABC
#args(log) # Description of the command.


## Data from *.csv (copy and paste)
## Select the table from the excel file, copy, go to the R Console and type:
## EXCEL화일을 열어놓은 상태에서
#mydata <- read.table("clipboard", header=TRUE, sep="\t")

## Data from *.csv (interactively)
#mydata <- read.csv(file.choose(), header = TRUE)

## Data from *.csv
#mydata <- read.csv("C:\myfolder\****.csv", header=TRUE)

#--------------------------------------------------------------------------
#여기서 마이데이터에 read.csv로 csv 파일을 읽어올 수 있다.
#이 경우 R 스크립트 폴더와 같은 폴더에 있어야 이렇게 열 수 있고
#아니면 경로 지정을 해야 될 듯 하다.
#--------------------------------------------------------------------------

mydata <- read.csv("2주_기술통계 예제_성적처리_자료.csv", header=TRUE) # Present Dir
#mydata <- read.csv("http://***.***./***/***/****.csv", header=TRUE)

## Data to *.csv
#write.table(mydata, file = "****.csv", sep = ",")

## Data from *.txt (space , tab, comma???separated)
## If you have spaces and missing data is coded as ‘-9’, type:
#mydata <- read.table("C:/myfolder/****.txt", header=TRUE, sep="\t", na.strings = "-9")

## Data to *.txt (space , tab, comma???separated)
#write.table(mydata, file = "****.txt", sep = "\t")

## Data from R
#load("mydata.RData")
#load("mydata.rda")  #  Add path to data if necessary 

## Data to R
#save.image("mywork.RData") # Saving all objects to file *.RData 
#save(object1, object2, file=“mywork.rda")  # Saving selected objects


##################################################################
## Exploring data

#서머리를 사용하면 대략적인 데이터에 대한 정보를 알려준다. 변수명을 
#한글로 해놓았는데 이걸 피할 수 있으면 피하자. 한글 완전지원을 안해줄때도
#있어서 변수명 , 데이터 명은 영어명을 쓰는것이 좋을 것이다.
#str로 스트럭쳐도 보자. 서머리랑은 다른 정보를 제공해준다.
#names는 변수 이름 , head는 앞의 5줄 정도 보여줄 때 쓴다.
#헤드에 -1088 이런식으로 하면 마지막부터 해서 1088개를 뺸 나머지를 보여준다.
#헤드말고 테일 하면 끝쪽 즉 꼬리를 보여주고 이 역시 헤드와 옵션이 같다.
#슬라이딩 처럼 []를 이용해서 해도 같게 보여준다.
#데이터를 불러오고 나면 일반 데이터 프레임에 사용할 수 있는 것은 모두 
#사용할 수 있다.

summary(mydata) # Provides basic descriptive statistics and frequencies.
#edit(mydata) # Open data editor
str(mydata) # Provides the structure of the dataset
names(mydata) # Lists variables in the dataset
head(mydata) # First 6 rows of dataset
head(mydata, n=10)# First 10 rows of dataset
head(mydata, n= -1088) # All rows but the last 1088
tail(mydata) # Last 6 rows
tail(mydata, n=10) # Last 10 rows
tail(mydata, n= -1090) # All rows but the first 1090
mydata[1:10, ] # First 10 rows
mydata[1:10,1:3] # First 10 rows of data of the first 3 variables

## Exploring the workspace
#objects()       # Lists the objects in the workspace
#ls()            # Same as objects()
#remove()        # Remove objects from the workspace
#rm(list=ls())   #clearing memory space
#detach(package:ABC)  # Detached packages when no longer need them
#search()        # Shows the loaded packages
#library()       # Shows the installed packages
#dir()           # show files in the working directory


##################################################
## Descriptive Statistics

#평균을 보고 싶으면 아래 2가지 방법처럼 할 수 있다. 지금까지 보니까 
#데이터프레임 이름$데이터열 이름 이런식으로 해서 어느 데이터 프레임 안의
#어느 데이터 열 이름을 가진 전체 데이터를 $를 사용해서 불러오는 것 같다.

#아래쪽은 또 1강에서 했던 다양한 내용이 나오고 있다.

#위치 맥스나 민은 최대 , 최소값이 어디 있는지 알려준다. 즉 최대 , 최소의
#인덱스를 알려준다. 주의해야 할 점은 동일한 점수로 예를 들어 35점의 최대 
#점수가 3명 있다면 그중에서 처음 발견한 최대값의 위치만 알려준다.
#최소값도 마찬가지 이다.

#테이블도 맥스도 솔트도 사용 가능하다.

mean(mydata[,3])
mean(mydata$중간고사)

with(mydata, mean(중간고사))

median(mydata$중간고사)    # 중앙값
var(mydata$중간고사)       # 분산
sd(mydata$중간고사)        # 표준편차
max(mydata$중간고사)       # 최댓값
min(mydata$중간고사)       # 최솟값
range(mydata$중간고사)     # 범위
quantile(mydata$중간고사)  # 백분위수 25%
quantile(mydata$중간고사, c(.3,.6,.9)) # 백dnl이수 with Customized quantiles
fivenum(mydata$중간고사)   # Boxplot elements. From help: "Returns Tukey's five number summary 
                           # (minimum, lower-hinge, median, upper-hinge, maximum) 
                           # for the input data ~ boxplot"
length(mydata$중간고사)    # Num of observations when a variable is specify
length(mydata)             # Number of variables when a dataset is specify
which.max(mydata$중간고사) # 조건 일치 값 출력 (자료중 지정 변수의 최댓값)
which.min(mydata$중간고사) # 조건 일치 값 출력 (자료중 지정 변수의 최솟값)

## Mode by frequencies
table(mydata$학점)
max(table(mydata$학점))
names(sort(-table(mydata$학점)))[1]
names(sort(-table(mydata$학점)))[2]


#################################################
## Histograms

#히스토그램도 사용가능하다. 익숙하게 사용하기 위해서는 많이 해보아야 한다.

hist(mydata$중간고사)

hist(mydata$중간고사, col="green")

with(mydata, hist(중간고사)) # Histogram of 중간고사 

with(mydata, hist(중간고사, breaks="FD", col="green"))
box()

hist(mydata$중간고사, breaks="FD")

## Conditional histograms

#컨디셔널 히스토그램으로 일부 부분을 잘라서 보겠다는 것이다.
#이와 관련된 코드들과 함수는 1강에서 이야기 했었다. 모르는 부분은 찾아보면서
#공부 해보도록 하자. 오버레이드는 그래프 2개를 겹쳐서 그려주는 함수이다.

par(mfrow=c(1, 2))
hist(mydata$중간고사[mydata$학점=="A+"], breaks="FD", main="A+", xlab="중간고사",col="green")
hist(mydata$중간고사[mydata$학점=="B+"], breaks="FD", main="B+", xlab="중간고사", col="green")

## Braces indicate a compound command allowing several commands with 'with' command
par(mfrow=c(1, 1))
with(mydata, {
   hist(중간고사, breaks="FD", freq=FALSE, col="green")
   lines(density(중간고사), lwd=2)
   lines(density(중간고사, adjust=0.5),lwd=1)
   rug(중간고사)
  })

## Histograms overlaid
hist(mydata$중간고사, breaks="FD", col="green")

hist(mydata$중간고사[mydata$학점=="B+"], breaks="FD", col="gray", add=TRUE)
legend("topright", c("A+","B+"), fill=c("green","gray"))

강좌번호학점 <- table(mydata$강좌번호,mydata$학점)
강좌번호학점

## Scatterplots 
## Useful to 1) study the mean and variance functions in the regression of y on x
##           2) to identify outliers and leverage points.

## plot(x,y)
par(mfrow=c(1, 2))
plot(mydata$중간고사) # Index plot
plot(mydata$기말고사, mydata$중간고사)

#이경우는 추세선 즉 리니어 리그레션 같은 회귀 라인을 보여주는 함수이다.
#abline 과 line 에서 lowess는 산점도에서 부드러운 곡선을 그려주는 함수이다.
#다 이 코드들을 보고 모르면 찾아서 해보도록 하자.

par(mfrow=c(1, 1))
plot(mydata$기말고사, mydata$중간고사, main="기말고사/중간고사", xlab="기말고사", ylab="중간고사", col="red")
abline(lm(mydata$중간고사~mydata$기말고사), col="blue")
lines(lowess(mydata$기말고사, mydata$중간고사), col="black") #  locally-weighted polynomial regression line (x,y)
#identify(mydata$기말고사, mydata$중간고사, row.names(mydata))

## Rule on span for lowess, big sample smaller (~0.3), small sample bigger (~0.7)

#car안의 스캐터플롯을 이용하면 복잡하지 않고 좋은 결과를 내올수 있다.
#박스플롯도 그려주고 , 회기 선도 그려주고 , 95퍼의 신뢰구간도 보여준다.
#통계적인 이야기가 많이 담겨있는 쉬운 함수이다.
#그래서 이런 패키지를 잘 사용하는 것이 코드를 짧게 만들고 쉽게 구현하도록
#만들 수 있는 것이다.

library(car)
scatterplot(중간고사~기말고사, data=mydata)