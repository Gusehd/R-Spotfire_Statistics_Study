#install.packages("ggplot2")
library(ggplot2)
str(diamonds)
#막대그래프
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))

# 참고(1) 수준(level) 파악 및 변경
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
library(dplyr)
#도수 파악
diamonds %>% group_by(cut) %>% tally
diamonds %>% group_by(color) %>% tally
diamonds %>% group_by(clarity) %>% tally
diamonds %>% group_by(cut, color) %>% tally


# 히스토그램
ggplot(data = diamonds) + geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

# 도수 출력
diamonds %>% count(cut_width(carat, 0.5))


# 히스토그램 중첩 시각화
ggplot(data = diamonds, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)



# 예제: 이상치(Outlier) 판별 및 처리
ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)

# y변수값 대부분은 3이상 10(또는 20)이하에 존재,
# 축의 값은 0분터 60까지 춯현
# 오류인지 이상치인지 판단 필요
diamonds %>% dplyr::filter(y < 3 | y > 20) %>% arrange(y)


## y값이 3 이하 이거나 20 이상되는 것은 비정상적 상황 ==> 이를 별도의 면밀한 조사 필요.
## 이상값의 (1) 제거 or (2) 유지(처리)??

#(1) 이상치를 제거하는 방법 
Diamonds2 <-diamonds %>% filter(between(y, 3, 20))
ggplot(Diamonds2) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)

#(2) 이상값을 결측값으로 치환하는 방법
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
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

# reorder()함수 미사용
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = class, y = hwy))


# 두변수가 모두 범주형일 경우 geom_count() 사용
ggplot(data = diamonds) + geom_count(mapping = aes(x = cut, y = color))

# dplyr;  count() & geom_tile()
diamonds %>%  count(color, cut)

diamonds %>%
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) + geom_tile(mapping = aes(fill = n))


# 두 연속형 변수 
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