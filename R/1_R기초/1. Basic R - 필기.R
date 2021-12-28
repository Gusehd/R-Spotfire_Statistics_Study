#R의 기초 

# 1. 자료생성 및 표작성

#데이터가 많이 없다면 이런식으로 해도 된다.
#앞의 c는 아마 칼럼 일 것이다. 왜와이 벡터로 이루어져있기 때문이다.
#그리고 아래에서 = 대신에 <- 를 사용해도 된다. 둘다 상관 없다.
#드래그 해서 블럭지정하고 위에서 따로 런을 할 수 있다.
#그리고 옆의 파일 , 플롯 , 패키지 에서 플롯에서 그래프를 보여준다.
#드래그 실행 해보니 아래쪽 콘솔에 잘 나오고 있다.
#만약 오류가 있다면 아래 콘솔창에 + 가 나온다. 즉 뭐가 마무리 안되었으니까
#추가해서 넣어달라 뭐 이런 뜻인듯 하다.
#이후 내가 드링크에 잘 들어갔는지 보고 싶으면 아래 콘솔창에 Drink 처럼
#자료 이름을 입력하면 자료 내용이 나오게 된다.

#테이블은 보고 싶은 데이터를 도수분포표 즉 표로 나타내어준다.
#정말 기본적인 테이블을 보여주게 된다.
#비율로 보고 싶다면 프로포션 테이블이다.
#우리가 만든 테이블을 비율로 보자는 마인드라 바로 prop.table이 아니라
#그 안에 바꾼 테이블을 넣어준다는 개념이다.
#또 상대도수분포표를 만드는 방법이 바로 테이블 안의 것들을 Drink의 길이
#즉 전체 표본의 개수로 나누어서 만들어 주는 방식이다.
#두개가 같은 의미라는 것은 생각해보면 이해 가능하다.

Drink = c(3, 4, 1, 1, 3, 4, 3, 3, 1, 3, 2, 1, 2, 1, 2, 3, 2, 3, 1, 1, 1, 1, 4, 3, 1)
table(Drink)                  # 자료 Drink의 도수분포표
prop.table(table(Drink))      # 자료 Drink의 상대도수분포표
table(Drink)/length(Drink)       # 자료 Drink의 상대도수분포표


# 2. 그래프를 이용한 자료의 요약
# 2.1. 막대 그래프(Bar Charts)

#바 플롯은 일반적인 막대그래프를 그리는 함수이고 barplot() 이다.
#확인 해보면 옆쪽에 잘 나오는 것을 알 수 있다.
#그런데 옆의 바 플롯을 확인해보면 우리가 입력한 데이터의 순서대로 나오고
#있다. 그래서 일반적인 바 플롯을 보고 싶다면 테이블을 넣어주어야 할 것이다.
#어떠한 테이블을 넣던지 간에 해당되는 요소에 대해서 그래프를 그려주게 된다.

barplot(Drink)  
barplot(table(Drink)) 	                 #  일반적인 막대 그래프 : 막대의 높이는 도수이다.

barplot(prop.table(table(Drink)))        #  막대의 높이를 상대도수로 한다.
barplot(table(Drink)/length(Drink))      #  막대의 높이를 상대도수로 한다.


# 2.2. 원형 그래프(Pie Charts)

#파이차트 즉 원형 그래프 이다.
#테이블을 드링크 카운트에 저장한 것이다.
#그래서 그걸 파이 드링크 카운트 하면 그에 대해서 원형 그래프를 그려준다.
#이 변주 안에 라벨을 붙일 수 있다. 그래서 보면 names 하고 요소
#이름 넣으면 이름 넣기도 되고 거기에 대해서 색도 변경할 수 있다.


Drink.counts = table(Drink)              #  변수 drink의 요약자료 저장
Drink.counts                             # Drink.counts 자료 확인
pie(Drink.counts)

names(Drink.counts) = c("A","B","C","D")  # 각 범주에 이름 부여
pie(Drink.counts)                        # 이름으로 표시되는 원형그래프 작성

pie(Drink.counts, col=c("blue","pink","yellow","green"))	   # 색 지정


# 2.3. 줄기-잎 그림

#통계에서 가장 많이 쓰이는 방법이 줄기 잎 그림이다.
#줄기 - 잎 그림은 stem 으로 만들게 된다.
#R이 실행되면 기본적으로 가지고 있는 데이터 셋이 몇개 있는데 그중에 하나가
#island 이다. island 드래그 하고 help 해보면 이런 데이터에 대해서 이야기 해준다.
#아무튼 아일랜드라는 주요 국가의 면적 넓이? 그런 데이터 인듯 하다.
#help를 통해 데이터를 살펴볼 때는 유용한 example도 제공하기 떄문에
#이런 것들도 잘 보면 공부가 된다.

#이런 것들을 하다보면 어떤 패키지가 필요할 떄도 있는데 그럴떄는 옆의 패키지에서
#필요한 패키지를 다운 받아서 사용하면 된다. 다양한 유저 라이브러리 이다.
#패키지에서 아래쪽에서 시스템 패키지 즉 우리가 무슨 패키지를 사용하고 있는지
#보여주고 있다. require 라는 명령어는 패키지를 다운받지 않고 빌려쓸 수 있는
#명령어 이다. 

#아래는 일반 아일랜드고 log10은 너무 커서 로그 10 스케일로 줄여서 본다는
#마인드 이다. 스케일은 1이 기본이고 2 , 3 하면 스케일을 늘려서 볼 수 있다.

stem(islands)
stem(log10(islands))
stem(log10(islands), scale=1)


#2.4. 히스토그램(Histograms)

#히스토그램도 이미 있는 데이터 셋을 이용한다.
#히스토그램도 그냥 hist(데이터) 이런식으로 사용한다.
#상대도수나 확률은 안의 옵션인 프로버블리티를 TRUE로 두면 된다.
#아래쪽의 RUG(X)는 밑의 데이터의 FORM을 좀 더 보여준다.
#데이터를 요약하는 순간 로우 데이터의 정보가 사라지니까
#러그를 이용하면 데이터가 어디에 분포되어있는지 표현해준다.
#그런데 러그도 거기 있는 것만 알지 몇갠진 모른다.
#그래서 하는게 러그안에 지터를 이용하는 것이다.
#지터를 넣어서 하면 뺵빽하게 몇개 있는지도 보여준다.
#히스토그램의 옵션에는 breaks 즉 분할도 사용할 수 있다.
#breaks를 6개가 아니라 포인트 지정도 된다. 그래서 보면 min(x)
#즉 미니멈 부터 max(x) 까지 자르겠다 도 가능하다.

X <- faithful$waiting
hist(X) 				            # 도수로 나타낼 때
hist(X, probability=TRUE)     # 상대도수(or 확률)로 나타낼 때

hist(X, probability=TRUE) 
rug(X)       

hist(X, probability=TRUE) 
rug(jitter(X))

hist(X, probability=TRUE, breaks=6) 	   # 6개의 분할을 사용 
hist(X,breaks=c(min(X), 50, 70, 80, max(X)))  # 분할을 지정할 수도 있다.



# 3. 자료의 수치적 요약 

#자료의 수치적 요약이다. .4 같은 것은 0.4 이다. 그리고 R은 대소문자 구분한다.
#사용되는 것들
#mean -> 평균 / var -> 분산 / sd -> 표준편차 / median -> 중앙값
#fivenum , summary -> 함수를 이용한 자료 요약이다.
#fivenum은 0 25 50 75 100 비율로 로 잘라서 보여준다.
#퀀타일이랑 조금 다르긴 한데 비율로 자른다는 마인드 이다.
#서머리는 그냥 서드 퀀타일 넣어서 평균 , 분산 같은 것 다 정리 해준다.
#서머리는 그 안의 해당 값이 없으면 근처 값으로 퀀타일을 계산해준다.
#즉 안의 데이터로 하는게 아니라 그 데이터에 가까운 것을 계산한다.

#퀀타일은 퀀타일 하고 0.25 0.75 하면 해당 비율의 퀀타일을 찾아준다.
#sort는 크기순으로 정렬 해준다.
#mean 에서 trim은 아래와 윗부분을 버린다는 것이다.

#mad는 미디엄 앱솔루트 디베이션 이다 검색해보자.
#IQR 같은 것들도 한번 찾아보자.

Sals = c(12, .4, 5, 2, 50, 8, 3, 1, 4, 0.25) # “.4”는 “0.4”로 인식한다.
mean(Sals) 		                 # 평균
var(Sals)                       # 분산(표본 분산을 의미한다)
sd(Sals) 	             	     # 표준편차(표본표준편차)
median(Sals)     		           # 중앙값
fivenum(Sals)                   # “fivenum”함수 이용 자료 요약
summary(Sals)                   # “summary”함수 이용 자료 요약

Data=c(10, 17, 18, 25, 28, 28)
summary(Data)
quantile(Data, .25)
quantile(Data, c(.25, .75)) 	  # 한 번에 두 값을 출력

sort(Sals)                      # 크기 순으로 정렬
fivenum(Sals)                   # “1”은 3번째, “8”은 8번째 자료이다.
summary(Sals)   

mean(Sals, trim=1/10)   	# 아래/윗부분을 모두 1/10씩 버린 후 나머지들의 평균 
mean(Sals, trim=2/10)	   # 아래/윗부분을 모두 2/10씩 버린 후 나머지들의 평균 
IQR(Sals)
mad(Sals)
median(abs(Sals - median(Sals))) 	             # abs()은 절대값 함수이다.
median(abs(Sals - median(Sals))) * 1.4826        # 중앙평균차의 공식



#4. 복합적 요약 
#4.1 상자그림(Boxplot 또는 상자수염그림)

#박스 플롯은 그래픽 정리에서 가장 많이 쓰는 부분일 것이다.
#패키지가 꽤 많은데 다 쓰면 프로그램이 무겁다.
#그래서 사용할 것만 사용하고 안쓰면 내려놓고 이런 마인드로
#library 함수를 사용한다. 라이브러리 하면 해당 패키지만 쓰겠다 그런 것이다.

#usingR의 무비 데이터를 이용한다.
#names 로는 어떤 데이터 들이 있는지 이름을 확인한다.
#패키지를 다 쓰는 것도 아닌 것처럼 데이터도 복합적으로 쓸 것이다.
#그래서 데이터를 계속 쓸 것 같은 상태로 유지하면 그것도 문제다.
#그래서 attach로 내가 지금 이 데이터를 쓰겠다 라는 준비 해줘 라는 명령어다.
#어태치 이후 박스 플롯으로 보여주는 것이다. 박스 플롯에서 main은 박스 플롯의
#제목이다. 이후 호라즌탈이냐 버티컬 이냐도 고를 수 있다.
#어태치 하고 난 후에 안쓸거면 디태치도 떼내야 한다.

#install.packages(UsingR)
library("UsingR") 	# package “UsingR”을 사용할 준비 한다.

data(movies) 	   	# “movies"이름을 가진 자료를 사용할 준비 한다.
names(movies)	      # “movies"에 사용된 변수이름을 알아본다.
attach(movies)		   # “movies"의 자료를 불러들일 때
boxplot(current, main="이번주 수입", horizontal=TRUE)
boxplot(gross, main="총 수입",horizontal=TRUE)
detach(movies) 	   # “movies” 자료를 더 이상 취급하지 않을 때

# “library”와 “data”를 이용하여 자료를 읽는 방법
library(stats) 		# 패키지 "stats"를 지정한다. 
data(lynx) 		      # 자료명 "lynx"를 지정한다.
summary(lynx)	    	# "lynx"의 자료에 대한 요약


#4.2. 히스토그램과 상자그림을 동시에 그리기

#히스토그램과 박스 플롯을 여러개를 동시에 그릴 수도 있다.
#norm = 노말 즉 정규분포이고 r은 랜덤이다.
#즉 표준 정규분포를 따르는 난수 100개를 뽑아내자는 뜻이다.
#시드는 아마 랜덤 시드를 잡아주는 함수인듯 하다.
#그리고 simple.hist.and.boxplot(X)를 하면 히스토 그램과 박스플롯이 동시에 나온다.

set.seed(1)
X = rnorm(100)                     # 표준정규분포를 따르는 난수 100개 추출
simple.hist.and.boxplot(X)         # X의 히스토그램 및 상자그림을 동시에 나타낸다.


#4.3. 돗수다각형(Frequency Polygon)

#돗수 다각형은 그냥 그 선도 이어서 표현해준 것이다.
#코드 한번 보고 또 어떻게 사용하는지 확인 해보자.

set.seed(1)
X= rnorm(100)  
temp = hist(X)                      # store the results
lines(c(min(temp$breaks), temp$mids, max(temp$breaks)), c(0, temp$counts, 0), type="l")
simple.freqpoly(X)   # 위의 결과와 동일함


#4.4. 확률밀도

#prob = T는 확률로 하라 이고 , braks를 = 이름 해주면 그 사람이 만든 방식으로
#브레이크로 잘라라 라는 뜻이다.
#라인 함수는 라인 그리는 건데 거글 덴시티 즉 밀도함수 펑션으로 그릴 수 있다.
#이럽션은 페이트풀 안의 데이터 이다.

#nclass는 그 사람들이 자른 것들이 몇개로 잘랐냐를 확인 할 수 있다.
#아래의 예시로 보면 10 6 5 인듯 한데 데이터 셋의 특성에 따라서 사용하면
#될 것이다. 덴시티의 옵션에는 색도 넣을 수 있다.

#par은 판넬의 개념이다. 즉 그림을 4개 그리고 싶어요 하면 판넬을 4개로 잘라서
#그림 그리겠다 그런 뜻이다. 판넬 개념은 실행 해보면 어떤 느낌인지 바로 온다.
#덴시티의 옵션으로 bw 즉 밴드위드 옵션도 있다. 밴드위드도 넓게 좁게 조정해보며
#어떻게 해야 데이터의 특징을 잘 보여주는지 볼 수 있다.
#라인과 레전드 같은 아래쪽의 내용은 또 따로 검색해보자.
#그리고 bw 밴드위드도 이름으로 지정하는 사람들이 만들어 놓은 세팅 값들이 있다.

data(faithful)
attach(faithful) 		                  # 자료를 준비시킨다.
hist(eruptions, breaks = "Sturges", prob=T) 	     # 상대도수의 히스토그램을 작성한다.
lines(density(eruptions)) 	            # 밀도함수 곡선을 그린다.

hist(eruptions, prob=T) 	    
hist(eruptions, 10, prob=T) 
hist(eruptions, 20, prob=T) 
hist(eruptions, 30, prob=T) 
hist(eruptions, 8, prob=T) 
hist(eruptions, 5, prob=T) 
hist(eruptions, 4, prob=T) 
hist(eruptions, 3, prob=T) 
hist(eruptions, 2, prob=T) 

nclass.Sturges(eruptions)
nclass.scott(eruptions)
nclass.FD(eruptions)

hist(eruptions, 15, prob=T)	
lines(density(eruptions, bw="SJ"), col='red')   # “SJ” 방법으로 띠너비 결정 

par(mfrow=c(1,3))　　　　　　      　           # 그래프 3개를 한 행에 그릴 때 사용
hist(eruptions,15,prob=T, main="bw=0.01")
lines(density(eruptions, bw=0.01))              # 띠너비를 0.01로 할 때, 
hist(eruptions, 15, prob=T, main="bw=1")
lines(density(eruptions, bw=1))                 # 띠너비를 1로 할 때, 
hist(eruptions, 15, prob=T, main="bw=0.1")
lines(density(eruptions, bw=0.1))               # 띠너비를 0.1로 할 때, 
par(mfrow=c(1,1))

require(graphics)
plot(density(eruptions), xlim=c(0,7), ylim=c(0,0.7))
rug(eruptions)
lines(density(eruptions, bw = "nrd"), col = 2)
lines(density(eruptions, bw = "ucv"), col = 3)
lines(density(eruptions, bw = "bcv"), col = 4)
lines(density(eruptions, bw = "SJ-ste"), col = 5)
lines(density(eruptions, bw = "SJ-dpi"), col = 6)
legend(5.5, 0.7, legend = c("nrd0", "nrd", "ucv", "bcv", "SJ-ste", "SJ-dpi"), 
       col = 1:6, lty = 1)



#5. 다변량 자료의 요약 방법들
#5.1 표를 이용한 자료의 요약

#df 즉 데이터 프레임을 만드는 함수이다. 이처럼 각 칼럼들을 모아
#이름을 붙이고 종합적인 데이터 프레임을 만들 수 있다.
#그래서 판다스 처럼 df 를 실행해보면 판다스처럼 표로 이루어진
#데이터 프레임이 나오는 것을 알 수 있다.
#데이터가 적어서 다 보이는데 데이터가 많다면 str을 붙야서 하면
#데이터 프레임에 대한 다양한 정보를 알려주게 된다.

#테이블에서 보게 되면 Df 데이터 프레임 이름을 테이블안에 넣어서
#달러표시 넣어서 체크하게 되면 어떻게 구별되는지 이런 부분에 대해서
#종합적으로 표로 알려주게 된다. 
#dnn을 넣어서 하면 로우와 칼럼이 어떤 것인지 레이블을 붙일 수 있다.
#table이 아니라 xtabs도 있는데 약간 비슷한데 약간 다르다.
#마진 개념이 또 있다.
#마진은 주변 끝자락이라는 의미가 있다. 1은 행 , 2는 열인데
#해당되는 합을 더해서 데이터프레임을 추가해주는 것 이다.
#아래의 예시에서는 1이면 헤어 , 2면 아이가 나오게 될 것이다.
#만약 1 , 2를 쓰지 않는다면 전체 데이터에 대해서 나오게 될 것이다.
#테이블에 addmargin을 하면 이제 비로소 뒤쪽에 sum이 된 새로운
#테이블이 만들어 지게 되는 것이다.

#옵션스의 digits는 소수점 옵션이다. 어느 소수점까지 나오게 할 것인가 이다.
#그래서 prob으로 돌려서 분포 확률을 보면 3자리까지 나오는 것을 알 수 있다.
#이후에 add마진을 해도 그냥 같은 형태로 나오게 되는 것이다.


Df <- data.frame( Sex = c("M","M","F","F","F","M","M","M","M","F"),
     Grade = c(1,2,3,1,2,3,1,2,3,1),
     Blood = c("A","O","B","AB","B","B","AB","A","A","O"),
     IQ = c(145,147,135,150,155,135,127,138,140,133),
     Hair = c("Black","Brown","Black","Blond","Red","Brown","Red","Brown","Black","Blond"),
     Eye = c("Brown","Blue","Hazel","Green","Brown","Blue","Hazel","Green","Brown","Blue"))
Df
str(Df)

table(Df$Grade)
table(Df$Sex, Df$Grade) 
table(Df$Hair, Df$Eye)
table(Df$Hair, Df$Eye, dnn=c("Hair","Eye"))
xtabs( ~ Df$Hair + Df$Eye, data=Df)
margin.table(table(Df$Hair, Df$Eye, dnn=c("Hair","Eye")),1)
margin.table(xtabs( ~ Df$Hair + Df$Eye, data=Df),1)
margin.table(xtabs( ~ Df$Hair + Df$Eye, data=Df),2)
margin.table(xtabs( ~ Df$Hair + Df$Eye, data=Df))
addmargins(table(Df$Hair, Df$Eye))

options(digits=3)                       # 기본은 7로 되어 있다.
prop.table(xtabs( ~ Df$Hair + Df$Eye, data=Df),1)
addmargins(prop.table(xtabs( ~ Df$Hair + Df$Eye, data=Df),1),2)

prop.table(xtabs( ~ Df$Hair + Df$Eye, data=Df),2)
addmargins(prop.table(xtabs( ~ Df$Hair + Df$Eye, data=Df),2),1)

prop.table(xtabs( ~ Df$Hair + Df$Eye, data=Df))
addmargins(prop.table(xtabs( ~ Df$Hair + Df$Eye, data=Df)))


# 배열 자료의 표만들기 및 예제 함수 ftable() 추가

#행렬은 2차원 이다. 그 이상의 3 , 4 차원을 만드는 것은 다른 것이다.
#그래서 3개의 데이터를 만들었다.
#아래의 Aye은 yes , si , oui 3개를 중복허용해서 177개를 뽑아 만드는
#데이터 셋이라는 의미이다. 아래의 데이터 셋들도 보면 다 이해 가능하다.
#sample 함수는 랜덤 추출이라 할 때마다 다르다. 만약 시드를 넣고 하면
#같게 만들수는 있다. 아무튼 그에 대한 table을 만들고 add마진 하면
#변수가 3개라 그런지 평면에 표현하는 표현상으로 표현이 불가하다.
#그래서 3개의 표가 나오게 되버렸다. 즉 하나의 기준에 대해서 
#2차원 표를 3개 보여준 것이다.

#이렇게 보면 상당히 길게 된다. 그러면 이 변수에 대해서 층을 내는 것 보다는
#원래 있던 표처럼 보고 싶다. 그러면 어떤 것에 대해서 눌러버린다는 것이다.
#그런데 그냥 누르면 안보이니까 경사있게 누른다는 것이다.
#그래서 이걸 flat을 붙여 ftable 이라 한다.
#위에서 봤던 4줄 2차원 표가 한줄로 가버렸다. 헤석이 어려울 수 있겠지만
#그래도 한눈에 볼 수 있다.
#여기에 add마진을 한다면 각 변수에 대한 sum이 모두 나오게 된다.
#만약 옵션이 1이라면 첫번째 a에 대한 sum이 나오게 되고 2라면
#2번째 b변수 , 3번째 c변수에 대해서 모두 나오게 되는 것이다.
#그래서 ftalbe에서 옵션을 준 add마진은 각 변수 번호에 따라서
#마진합을 구하게 된다.

Aye <- sample(c("Yes", "Si", "Oui"), 177, replace = TRUE)
Bee <- sample(c("Hum", "Buzz"), 177, replace = TRUE)
Sea <- sample(c("White", "Black", "Red", "Dead"), 177, replace = TRUE)
A <- table(Aye, Bee, Sea)
addmargins(A)

ftable(A)
ftable(addmargins(A))
ftable(addmargins(A,1))
ftable(addmargins(A,2))
ftable(addmargins(A,3))
ftable(addmargins(A, c(1, 3)))

## Zero.Printing table+margins:

#1 ~ 7 까지 20개를 뽑아서 x와 y를 뽑아낸다. 그래서 테이블 x,y에 대해서
#add마진을 해보면 나오게 된다. 아래는 tx를 프린트 하는데 zero.print 즉 
#0이라는 수는 . 으로 나오게 한다. 이 0이라는 값은 언제는 쓸모 있을 수 있지만
#언제는 쓸모 없다. 만약 우리가 평균을 구한다고 하면 0떄문에 평균값에 영향이
#받을 수 있다. 즉 관측치의 값이 0이라는 의미가 아니고 관측치가 없다 즉 결측치
#일수도 있다는 것이다. 그런 값들을 바꾸어 주기 위해서 zero.print = "."을 통해
#모든 제로를 . 으로 바꿔버릴 수 있다. 나중에 연산법에 따라서 아래쪽이 더
#편하게 쓸 수 있는 경우도 많다.

set.seed(1)
x <- sample( 1:7, 20, replace = TRUE)
y <- sample( 1:7, 20, replace = TRUE)
tx <- addmargins( table(x, y) )
print(tx, zero.print = ".")



#5.2. 그래프를 이용한 자료의 요약
#5.2.1. 히스토그램: (함수 hist()사용)

#히스토그램 이라는 명령어를 쓸 것이다. 에어퀄리티라는 변수를 사용할 것이다.
#뉴옥의 공기 질 데이터 이다. 오존농도/도수와 밀도로 히스토그램을 나오게 
#만들었다. 그리고 팔레트는 언제나 사용하고 1.1 로 세팅해서 돌려놔야한다.

par(mfrow = c(1, 2))
hist(airquality$Ozone, main="오존농도/도수")
hist(airquality$Ozone, main="오존농도/밀도", probability=TRUE)
par(mfrow = c(1, 1))


#5.2.2. 상자그림: (함수 bolplot()사용)

#home도 기본적으로 제공하는 데이터 이다. 그냥 박스플롯을 그린 것과 스케일을
#통해서 표준화를 진행한 후 박스플롯을 그린 것과의 차이가 있다.
#아까 보았던 str()이라는 명령어는 structure의 약어였다.
#이것도 해보면 dataFrame이고 old와 new는 numberic 변수 였다.
#스케일을 사용하게 되면 old가 new에 비해서 상당히 작아서 보기가 어렵다.
#즉 모양새를 보고 싶기 떄문에 스케일을 사용하면 두개를 표준화 해서 보여주게
#된다. 즉 각각이 평균치에 대해서 어떻게 변화하는지 보여주는 것이다.
#두개의 데이터에 있어서 같이 볼것인데 값의 차이가 크다면 이런식으로
#세팅해서 볼 수 잇는 것이다. 그래서 결과에 대해서 조금 보면 old는 평균
#에 비해 new 보다 조금더 높은 경우가 있을 수 있는 거구나 할 수 있다.

library("UsingR")
par(mfrow = c(1, 2))
data(home) 
names(home)
boxplot(data.frame(home))
boxplot(data.frame(scale(home)))   # ”scale”함수 이용,  표준화 진행한 후 상자그림.


#5.2.3. 산점도: (함수 plot())사용)

#두개의 변수인 x와 y가 있다면 산점도 관계가 있는지 즉 증가 , 감소 등등을 볼 수
#있다. plot 즉 그림을 그릴 수 있는 함수를 사용한다.
#plot(wind, ozone) 하면 x축은 윈드 y축은 오존이라고 상상하면 된다.
#그래서 실행해보면 산점도가 나오고 대략적인 경향을 볼 수 있다.
#with라는 함수는 어떤 것에 대해서 어떤 작업을 할 것이냐를 묶어서 보여줄 수 
#있다. 위쪽의 어태치 , 플롯 해서 2줄 쓰던것을 한줄로 묶은 것이다.

data(airquality)
attach(airquality)
par(mfrow = c(1, 1))
plot(Wind, Ozone)
with(airquality, plot(Wind, Ozone))

# 제목 및 범례

#그래서 with로는 플롯을 해서 그리고 메인으로 이름 붙이고 x축과 y축에
#레이블로 이름을 붙이고 xlim , ylim으로 x축과 y축의 범위도 정할 수 있다.
#legned 함수로는 우리가 그래프의 빈공간에 원하는 문구를 써 넣을 수도 있다.

with(home, plot(scale(old),scale(new), main="제목: 주택 가격 비교",
 xlab="x축이름:과거(표준화)", ylab="y축이름:현재(표준화)",
 xlim=c(-2,2), ylim=c(-2,2)))                # 축이름 및 축의 범위 설정
legend("bottomright", "우측하단");      
legend("bottom", "중앙하단")
legend("bottomleft", "좌측하단")
legend("topright", "우측상단")
legend("top", "중앙상단")
legend("topleft", "좌측상단")
legend("right", "우측중앙")
legend("left", "죄측중앙")
legend("center", "중앙")
legend(0.5,1.3, "좌표값  (0.5,1.3)")


# (1) 그림 자체에 관련된 파라미터

#pch는 점의 크기 , 라인타입 , 라인 두께 , 타입 , 컬러 , 표식자의 크기는 어떻게 
#할 것인지 이런 옵션이 있다. 이것 저것 해보는게 제일 좋다.

with(airquality, plot(Wind, Ozone, pch=10, lty=1, lwd=2, type="b", col="blue", cex=1.5))


# (2) 그림 주변과 관련된 파리미터

#2 바이 2 로 그려주었다. las가 0 1 2 3 에 따라서 그렸다. 라스는 해보면 알겠
#지만 x , y 축에 대해서 글자를 세로로 쓸 것인지 가로로 쓸 것인지에 대한 옵션이다.

par(mfrow=c(2,2), mar=c(2.5,2.5,2.5,2.5))
with(airquality, plot(Wind, Ozone, las=0))
with(airquality, plot(Wind, Ozone, las=1))
with(airquality, plot(Wind, Ozone, las=2))
with(airquality, plot(Wind, Ozone, las=3))


# (3) 그림을 보조하는 명령어들 (a) text(그래프내 문자 추가)

#아래의 text와 pos를 하면 측정된 순서에 따라서 숫자를 옆에 붙여주게 된다.

par(mfrow=c(1,1))
with(home, plot(home, cex=1.5))
text(home, pos = 4)

# (3) 그림을 보조하는 명령어들 (b) identify(그래프내 자료 정보 추가)

# 아이덴티파이는 내가 옆의 플롯을 그리고 위치를 찍으면 근처에 포인트가 있는지
#아래 콘솔창에서 알려주게 된다. 이후 esc를 누르면 내가 몇번째 것을 마킹했다
#라는 것이 나오게 된다.

with(home, plot(home, cex=1.5))
identify(home)

# (4) 그림 추가  (a) points

#그림에 점 , 라인 , 추세선 , 커브를 추가할 수 있다. 다양한 경우에 대해 그림
#을 그릴 수 있다. 한번씩 구현 해보면서 공부 해보자.

data(home)
plot(home, pch=1, cex=2)
points(home, pch=20, cex=1)

# (4) 그림 추가   b) lines
x = seq(-pi, 3.14, 0.1)
y = cos(x)
plot(x,y, pch=1, cex=1.5)
lines(x,y, lty=1, lwd=2)

# (4) 그림 추가   (c) abline
with(home, plot(home, cex=1.5))
abline(a=-20000, b=6.9, col="red")

# (4) 그림 추가   (d) curve
x = seq(-pi, pi, 0.1)
y = sin(x)
plot(x,y, pch=1, cex=1.5)
curve(cos, -3.14, 3.14, add=TRUE, lty=2, lwd=2)

# (4) 그림 추가   (e) polygon
n <- 3
x <- c(0:n, n:0)
y <- c(c(0, rnorm(n)), c(0, rnorm(n)))
plot   (x, y, type = "p")
polygon(x, y, border = "red")
text(x,y, pos=4, cex=1.5)


# 행렬 자료의 산점도

#seq는 시퀀스는 -2 ~ 2 사이에 값들을 0.01씩 증가 시키겠다는 것이다.
#그럼 400개가 넘는 데이터가 될 것이다. 이후 y는 메트릭스 값인데 처음은 
#하이퍼코사인 사인 같은 값이다. 칼럼은 3개이다.
#y 데이터는 만든 x 데이터를 넣어서 결과를 만들고 보여준다.
#실행해서 보면 적당히 끊어서 대략적인 데이터를 보여준다.
#그럼 x하나에 y값이 3개 즉 4차원 그래프이다. 그럼 4차원 그래프로 그리지 
#말고 2차원으로 그릴 것이다. 그럼 matplot에 lwd 라인 두께 , c는 컬러로
#색을 각각 지정해준다.

x <- seq(-2, 2, 0.01)
y <- matrix( c(cosh(x),sinh(x),tanh(x)),ncol=3)
matplot(x,y, main="쌍곡선 함수(cosh, sinh, tanh)", type='l', 
lwd=c(3,3,5),col=c("black", "blue", "red"))
abline(h=0, v=0)

# Scatterplot matrix#

#x는 var인데 1에서 20까지에 + 랜덤넘버 20 표준편차는 3인것 해서 데이터를
#만들게 된다. 이렇게 해서 플롯을 ,1:3 으로 해서 그리면
#x , y , z 끼리 2개씩 묶은 결과를 보여주게 된다.

set.seed(1)
# Make some noisily increasing data
Df <- data.frame(xvar = 1:20 + rnorm(20,sd=3),
                 yvar = 1:20 + rnorm(20,sd=3),
                 zvar = 1:20 + rnorm(20,sd=3))
Df
# A scatterplot matrix
plot(Df[,1:3])

#install.packages("car")

#scatterplotMatrix는 다르게 나오게 만든다. 추세선과 신뢰구간에 따른 구간 등등
#을 주게 된다. 스무드를 끄게 되면 가쪽의 신뢰구간이 사라지는 것 같다.
#나중에 더 살펴보도록 하자.

library(car)
scatterplotMatrix(Df[,1:3])
scatterplotMatrix(Df[,1:3],  smooth=FALSE )



#6.Lattice 

#격자구조 형태이다. 데이터는 Car93 이라는 데이터를 사용한다. 1993에 
#미국에서 판매된 93개의 차량에 대한 정보이다. 아무튼 이 정보를 이용해서
#살펴본다. 프라이스와 실린더에 대한 정보를 볼 것인데 , 
#~ Price | Cylinders 이런 식으로 하면 가격을 보고 싶다는 뜻이다.
#뭐로 구분해서? 실린더 수로 구분해서 그럼 실린더가 8개일때 , 5개일때
#등등해서 그래프가 총 실린더 종류 개수만큼 나오게 될 것이다.

#xy플롯 말고 박스플롯으로도 볼 수 있다.
#그래서 이렇게 나오는 형태를 격자구조로 본다고 한다.

#판넬 함수는 데이터를 잘 표현하는 선의 형태라고 하셨다. 아마 리니어 리그레션
#이 아닌 가 싶다. 나중에 더 찾아보자.

#클라우드는 3차원 박스를 만들고 그에 대해서 표현한다. 한번 해보고 찾아보자.

#splom도 해보면 격자구조 이다. 보게 되면 요소중 2개씩 뽑아서 보여주고 있음을
#알 수 있다. 사용법에 대해서는 한번더 찾아보고 정리 해보자.

#데이터 프레임을 사용하는 것중에서 [,1:4] 이런것은 데이터의 1 ~ 4 열을
#가져와라 이런 뜻이다. 그러면 [2,3] 은 2행 3열을 가져와라 이런 뜻이다.
#즉 아무것도 안넣으면 전체 범위를 의미한다고 보면 된다.

#xyplot
library(lattice)
library(MASS)
histogram( ~ Price | Cylinders, data=Cars93)

#bwplot
bwplot( ~ Price | Cylinders, data=Cars93)

# xyplot
with(Cars93, xyplot( MPG.highway ~ Fuel.tank.capacity | Type))

# Panel함수 이용
plot.regression = function(x,y) { panel.xyplot(x,y)+ panel.lmline(x,y, col=2) }
with(Cars93, xyplot(MPG.highway ~ Fuel.tank.capacity | Type, panel=plot.regression ))

#cloud
cloud(Sepal.Length ~ Petal.Length * Petal.Width | Species, data = iris,
      screen = list(x = -90, y = 70), distance = .4, zoom = .6 )

#splom
super.sym <- trellis.par.get("superpose.symbol")
splom(~iris[1:4], groups = Species, data = iris,
      panel = panel.superpose,
      key = list(title = "Three Varieties of Iris",
                 columns = 3, 
                 points = list(pch = super.sym$pch[1:3],
                               col = super.sym$col[1:3]),
                 text = list(c("Setosa", "Versicolor", "Virginica"))))

# Scatterplot matrices; 패키지 "car"에 있는 함수
library(car)
scatterplotMatrix(iris[,1:4],smooth=FALSE)