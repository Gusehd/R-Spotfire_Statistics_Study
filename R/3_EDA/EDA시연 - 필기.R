#install.packages("ggplot2")
library(ggplot2)
str(diamonds)
#막대그래프

#GGPLOT의 다이아몬드 데이터를 가지고 실습을 진행한다. 10개의 변수로 있고
#가격부터 캐럿 등등의 요소들이 포함된 데이터 셋이다.
#STR 즉 스트럭쳐를 보기 위해 넣어서 한번 살펴볼 수 있다.
#ggplot은 ggplot 하고 뒤에 꾸미는 옵션을 사용한다. geom_bar니까 바 형태를
#사용한다는 의미이다.
#다이아몬드 데이터를 바로 할건데 맵핑을 aes x에서 cut으로 커트해서 
#카운트를 보는 것이다.

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))

# 참고(1) 수준(level) 파악 및 변경

#level 다이아몬드 컷 하면 다이아몬드 컷에 있는 레벨을 즉 요소를 보여주게 된다.
#레벨 순서를 바꾸고 싶다면 아래 줄처럼 직접 레벨을 칼럼의 형태로 입력해주면
#된다. cutF라는 새로운 변수로 만들어서 넣어놓은 것이다.
#head는 앞의 몇개를 살펴보는 함수 였다.
#cutF를 넣었다가 말았다가 하는 방법은 다이아몬드의 cutF라는 칼럼을 하나 더 
#넣었었는데 이후 cutF <- NULL 을 해주면 그 부분을 NULL로 없앨 수 있다.
#그래서 보면 우리가 원하는 칼럼을 원하는 형태로 넣고 뺴고 할 수 있다.

levels(diamonds$cut)

diamonds$cutF <- factor(diamonds$cut,
                        levels=c( "Ideal","Fair","Good","Very Good","Premium"))
levels(diamonds$cutF)

head(diamonds)

diamonds$cutF <- NULL
head(diamonds)


levels(diamonds$cut)
diamonds$cut <- factor(diamonds$cut,
                       levels=c( "Ideal","Fair","Good","Very Good","Premium"))
levels(diamonds$cut)
diamonds$cut <- factor(diamonds$cut,
                       levels=c("Fair","Good","Very Good","Premium","Ideal"))
levels(diamonds$cut)


#install.packages("dplyr")

#데이터 요약에 사용되는 DPLYR을 사용하도록 한다. %기호로 파이프 기호로
#명령어나 객체들간의 연결고리를 만들어 준다. 데이터 명에 대해서 뭔가를 
#해줘 하는데 CUT으로 그룹핑을 하고 TALLY는 그거와 관련된 자료를 뽑아내는
#명령어다. 그러면 각 요소들이 몇개인지 알려주게 되고 데이터 타입에 대해서
#알려주게 된다. 만약 그룹바이에 요소가 2개이상 들어가게 된다면 그 요소들
#로 이루어지는 모든 조합이 몇개있는지 확인 가능하다.

library(dplyr)
#도수 파악
diamonds %>% group_by(cut) %>% tally
diamonds %>% group_by(color) %>% tally
diamonds %>% group_by(clarity) %>% tally
diamonds %>% group_by(cut, color) %>% tally


# 히스토그램

#히스토그램이라는 명령어를 사용하면 위쪽과 다르게 바가 아닌 히스토그램으로
#나오는 것을 볼 수 있다. 도수 출력은 내가 원하는 범위안에 데이터가 몇개 있는지
#알아볼 수 있는 방법이다. 중첩 시각화는 선의 색에 구별에 따라서 그떄그때에
#캐럿에 대해서 여러개의 그래프를 같이 그리는 것이다. 보면 X는 캐럿이고
#카운트를 보고 있다.

ggplot(data = diamonds) + geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

# 도수 출력
diamonds %>% count(cut_width(carat, 0.5))


# 히스토그램 중첩 시각화
ggplot(data = diamonds, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)



# 예제: 이상치(Outlier) 판별 및 처리

#지금 보면 데이터들은 10 ~ 20 안에 있는데 보면 X축이 60까지 나와있다.
#그러면 60까지 안보이는 곳에 다 아웃라이어가 있다는 뜻이 된다.
#그래서 이런 아웃라이어를 제가하기 위해서 아래쪽의 DPLYR의 필터를
#사용하도록 한다. 필터를 통해 y값 즉 측정치가 3 ~ 20 사이를 살펴보도
#록 한다. 그럼 이걸 보고 버릴지 보정할지 정하면 된다.

ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)

# y변수값 대부분은 3이상 10(또는 20)이하에 존재,
# 축의 값은 0분터 60까지 춯현
# 오류인지 이상치인지 판단 필요
diamonds %>% dplyr::filter(y < 3 | y > 20) %>% arrange(y)


## y값이 3 이하 이거나 20 이상되는 것은 비정상적 상황 ==> 이를 별도의 면밀한 조사 필요.
## 이상값의 (1) 제거 or (2) 유지(처리)??

#(1) 이상치를 제거하는 방법 

#다이아몬드에서 3 ~ 20 사이값만 필터링해서 새로운 다이아몬드2 에 넣는 방법

Diamonds2 <-diamonds %>% filter(between(y, 3, 20))
ggplot(Diamonds2) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)

#(2) 이상값을 결측값으로 치환하는 방법

#결측치 즉 3보다 작고 20보다 큰값을 NA로 처리하는 법이다.

Diamonds3 <- diamonds %>% mutate(y = ifelse(y < 3 | y > 20, NA, y))
ggplot(Diamonds3) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)
Diamonds3 %>% dplyr::filter(y < 3 | y > 20) %>% arrange(y)


# 두변수 이상 공변동(Covariation)

## 범주형과 연속형을 시각화해서 공변동을 확인할 경우 
## density plot, boxplot 사용. 
## 특히 범주에 순서가 있는 경우, 순서형 범주값을 반영하여 시각화 권장.

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) +
  geom_freqpoly(mapping = aes(colour = cut), binwidth =500)


# reorder()함수 사용

#reorder() 함수는 해당 요소에 대해서 정렬을 해주어 커져가는 형태로 보기 좋게
#바꾸어 주는 역할을 한다. 어떻게 사용되는지 실행하고 확인 해보자.

ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

# reorder()함수 미사용
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = class, y = hwy))


# 두변수가 모두 범주형일 경우 geom_count() 사용
ggplot(data = diamonds) + geom_count(mapping = aes(x = cut, y = color))

# dplyr;  count() & geom_tile()
diamonds %>%  count(color, cut)


#아래는 히트맵을 만드는 방법이고 geom_tile 즉 타일로 만든다.

diamonds %>%
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) + geom_tile(mapping = aes(fill = n))


# 두 연속형 변수 

#포인트 즉 산점도를 두개의 요소를 기준으로 표현한다.

ggplot(data = diamonds) + geom_point(mapping = aes(x = carat, y = price))

# 투명도 도입
ggplot(data = diamonds) + geom_point(mapping = aes(x = carat, y = price), alpha = 1/100)

# 직사각형 구간  
ggplot(data = diamonds) + geom_bin2d(mapping = aes(x = carat, y = price))

# 육각형 구간
#install.packages("hexbin")
library(hexbin)
ggplot(data = diamonds) + geom_hex(mapping = aes(x = carat, y = price))  

# 연속형 변수를 범주화하여 상자그림으로 시각화하는 방법
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))