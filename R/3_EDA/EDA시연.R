#install.packages("ggplot2")
library(ggplot2)
str(diamonds)
#¸·´ë±×·¡ÇÁ
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))

# Âü°í(1) ¼öÁØ(level) ÆÄ¾Ç ¹× º¯°æ
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
#µµ¼ö ÆÄ¾Ç
diamonds %>% group_by(cut) %>% tally
diamonds %>% group_by(color) %>% tally
diamonds %>% group_by(clarity) %>% tally
diamonds %>% group_by(cut, color) %>% tally


# È÷½ºÅä±×·¥
ggplot(data = diamonds) + geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

# µµ¼ö Ãâ·Â
diamonds %>% count(cut_width(carat, 0.5))


# È÷½ºÅä±×·¥ ÁßÃ¸ ½Ã°¢È­
ggplot(data = diamonds, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)



# ¿¹Á¦: ÀÌ»óÄ¡(Outlier) ÆÇº° ¹× Ã³¸®
ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)

# yº¯¼ö°ª ´ëºÎºÐÀº 3ÀÌ»ó 10(¶Ç´Â 20)ÀÌÇÏ¿¡ Á¸Àç,
# ÃàÀÇ °ªÀº 0ºÐÅÍ 60±îÁö ­ŒÇö
# ¿À·ùÀÎÁö ÀÌ»óÄ¡ÀÎÁö ÆÇ´Ü ÇÊ¿ä
diamonds %>% dplyr::filter(y < 3 | y > 20) %>% arrange(y)


## y°ªÀÌ 3 ÀÌÇÏ ÀÌ°Å³ª 20 ÀÌ»óµÇ´Â °ÍÀº ºñÁ¤»óÀû »óÈ² ==> ÀÌ¸¦ º°µµÀÇ ¸é¹ÐÇÑ Á¶»ç ÇÊ¿ä.
## ÀÌ»ó°ªÀÇ (1) Á¦°Å or (2) À¯Áö(Ã³¸®)??

#(1) ÀÌ»óÄ¡¸¦ Á¦°ÅÇÏ´Â ¹æ¹ý 
Diamonds2 <-diamonds %>% filter(between(y, 3, 20))
ggplot(Diamonds2) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)

#(2) ÀÌ»ó°ªÀ» °áÃø°ªÀ¸·Î Ä¡È¯ÇÏ´Â ¹æ¹ý
Diamonds3 <- diamonds %>% mutate(y = ifelse(y < 3 | y > 20, NA, y))
ggplot(Diamonds3) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)
Diamonds3 %>% dplyr::filter(y < 3 | y > 20) %>% arrange(y)


# µÎº¯¼ö ÀÌ»ó °øº¯µ¿(Covariation)

## ¹üÁÖÇü°ú ¿¬¼ÓÇüÀ» ½Ã°¢È­ÇØ¼­ °øº¯µ¿À» È®ÀÎÇÒ °æ¿ì 
## density plot, boxplot »ç¿ë. 
## Æ¯È÷ ¹üÁÖ¿¡ ¼ø¼­°¡ ÀÖ´Â °æ¿ì, ¼ø¼­Çü ¹üÁÖ°ªÀ» ¹Ý¿µÇÏ¿© ½Ã°¢È­ ±ÇÀå.
ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) +
  geom_freqpoly(mapping = aes(colour = cut), binwidth =500)


# reorder()ÇÔ¼ö »ç¿ë
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

# reorder()ÇÔ¼ö ¹Ì»ç¿ë
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = class, y = hwy))


# µÎº¯¼ö°¡ ¸ðµÎ ¹üÁÖÇüÀÏ °æ¿ì geom_count() »ç¿ë
ggplot(data = diamonds) + geom_count(mapping = aes(x = cut, y = color))

# dplyr;  count() & geom_tile()
diamonds %>%  count(color, cut)

diamonds %>%
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) + geom_tile(mapping = aes(fill = n))


# µÎ ¿¬¼ÓÇü º¯¼ö 
ggplot(data = diamonds) + geom_point(mapping = aes(x = carat, y = price))

# Åõ¸íµµ µµÀÔ
ggplot(data = diamonds) + geom_point(mapping = aes(x = carat, y = price), alpha = 1/100)

# Á÷»ç°¢Çü ±¸°£  
ggplot(data = diamonds) + geom_bin2d(mapping = aes(x = carat, y = price))

# À°°¢Çü ±¸°£
#install.packages("hexbin")
library(hexbin)
ggplot(data = diamonds) + geom_hex(mapping = aes(x = carat, y = price))  

# ¿¬¼ÓÇü º¯¼ö¸¦ ¹üÁÖÈ­ÇÏ¿© »óÀÚ±×¸²À¸·Î ½Ã°¢È­ÇÏ´Â ¹æ¹ý
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))