#install.packages("ggplot2")
library(ggplot2)
str(diamonds)
#¸·´ë±×·¡ÇÁ

#GGPLOTÀÇ ´ÙÀÌ¾Æ¸óµå µ¥ÀÌÅÍ¸¦ °¡Áö°í ½Ç½ÀÀ» ÁøÇàÇÑ´Ù. 10°³ÀÇ º¯¼ö·Î ÀÖ°í
#°¡°İºÎÅÍ Ä³·µ µîµîÀÇ ¿ä¼ÒµéÀÌ Æ÷ÇÔµÈ µ¥ÀÌÅÍ ¼ÂÀÌ´Ù.
#STR Áï ½ºÆ®·°ÃÄ¸¦ º¸±â À§ÇØ ³Ö¾î¼­ ÇÑ¹ø »ìÆìº¼ ¼ö ÀÖ´Ù.
#ggplotÀº ggplot ÇÏ°í µÚ¿¡ ²Ù¹Ì´Â ¿É¼ÇÀ» »ç¿ëÇÑ´Ù. geom_bar´Ï±î ¹Ù ÇüÅÂ¸¦
#»ç¿ëÇÑ´Ù´Â ÀÇ¹ÌÀÌ´Ù.
#´ÙÀÌ¾Æ¸óµå µ¥ÀÌÅÍ¸¦ ¹Ù·Î ÇÒ°Çµ¥ ¸ÊÇÎÀ» aes x¿¡¼­ cutÀ¸·Î Ä¿Æ®ÇØ¼­ 
#Ä«¿îÆ®¸¦ º¸´Â °ÍÀÌ´Ù.

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))

# Âü°í(1) ¼öÁØ(level) ÆÄ¾Ç ¹× º¯°æ

#level ´ÙÀÌ¾Æ¸óµå ÄÆ ÇÏ¸é ´ÙÀÌ¾Æ¸óµå ÄÆ¿¡ ÀÖ´Â ·¹º§À» Áï ¿ä¼Ò¸¦ º¸¿©ÁÖ°Ô µÈ´Ù.
#·¹º§ ¼ø¼­¸¦ ¹Ù²Ù°í ½Í´Ù¸é ¾Æ·¡ ÁÙÃ³·³ Á÷Á¢ ·¹º§À» Ä®·³ÀÇ ÇüÅÂ·Î ÀÔ·ÂÇØÁÖ¸é
#µÈ´Ù. cutF¶ó´Â »õ·Î¿î º¯¼ö·Î ¸¸µé¾î¼­ ³Ö¾î³õÀº °ÍÀÌ´Ù.
#head´Â ¾ÕÀÇ ¸î°³¸¦ »ìÆìº¸´Â ÇÔ¼ö ¿´´Ù.
#cutF¸¦ ³Ö¾ú´Ù°¡ ¸»¾Ò´Ù°¡ ÇÏ´Â ¹æ¹ıÀº ´ÙÀÌ¾Æ¸óµåÀÇ cutF¶ó´Â Ä®·³À» ÇÏ³ª ´õ 
#³Ö¾ú¾ú´Âµ¥ ÀÌÈÄ cutF <- NULL À» ÇØÁÖ¸é ±× ºÎºĞÀ» NULL·Î ¾ø¾Ù ¼ö ÀÖ´Ù.
#±×·¡¼­ º¸¸é ¿ì¸®°¡ ¿øÇÏ´Â Ä®·³À» ¿øÇÏ´Â ÇüÅÂ·Î ³Ö°í •û°í ÇÒ ¼ö ÀÖ´Ù.

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

#µ¥ÀÌÅÍ ¿ä¾à¿¡ »ç¿ëµÇ´Â DPLYRÀ» »ç¿ëÇÏµµ·Ï ÇÑ´Ù. %±âÈ£·Î ÆÄÀÌÇÁ ±âÈ£·Î
#¸í·É¾î³ª °´Ã¼µé°£ÀÇ ¿¬°á°í¸®¸¦ ¸¸µé¾î ÁØ´Ù. µ¥ÀÌÅÍ ¸í¿¡ ´ëÇØ¼­ ¹º°¡¸¦ 
#ÇØÁà ÇÏ´Âµ¥ CUTÀ¸·Î ±×·ìÇÎÀ» ÇÏ°í TALLY´Â ±×°Å¿Í °ü·ÃµÈ ÀÚ·á¸¦ »Ì¾Æ³»´Â
#¸í·É¾î´Ù. ±×·¯¸é °¢ ¿ä¼ÒµéÀÌ ¸î°³ÀÎÁö ¾Ë·ÁÁÖ°Ô µÇ°í µ¥ÀÌÅÍ Å¸ÀÔ¿¡ ´ëÇØ¼­
#¾Ë·ÁÁÖ°Ô µÈ´Ù. ¸¸¾à ±×·ì¹ÙÀÌ¿¡ ¿ä¼Ò°¡ 2°³ÀÌ»ó µé¾î°¡°Ô µÈ´Ù¸é ±× ¿ä¼Òµé
#·Î ÀÌ·ç¾îÁö´Â ¸ğµç Á¶ÇÕÀÌ ¸î°³ÀÖ´ÂÁö È®ÀÎ °¡´ÉÇÏ´Ù.

library(dplyr)
#µµ¼ö ÆÄ¾Ç
diamonds %>% group_by(cut) %>% tally
diamonds %>% group_by(color) %>% tally
diamonds %>% group_by(clarity) %>% tally
diamonds %>% group_by(cut, color) %>% tally


# È÷½ºÅä±×·¥

#È÷½ºÅä±×·¥ÀÌ¶ó´Â ¸í·É¾î¸¦ »ç¿ëÇÏ¸é À§ÂÊ°ú ´Ù¸£°Ô ¹Ù°¡ ¾Æ´Ñ È÷½ºÅä±×·¥À¸·Î
#³ª¿À´Â °ÍÀ» º¼ ¼ö ÀÖ´Ù. µµ¼ö Ãâ·ÂÀº ³»°¡ ¿øÇÏ´Â ¹üÀ§¾È¿¡ µ¥ÀÌÅÍ°¡ ¸î°³ ÀÖ´ÂÁö
#¾Ë¾Æº¼ ¼ö ÀÖ´Â ¹æ¹ıÀÌ´Ù. ÁßÃ¸ ½Ã°¢È­´Â ¼±ÀÇ »ö¿¡ ±¸º°¿¡ µû¶ó¼­ ±×‹š±×¶§¿¡
#Ä³·µ¿¡ ´ëÇØ¼­ ¿©·¯°³ÀÇ ±×·¡ÇÁ¸¦ °°ÀÌ ±×¸®´Â °ÍÀÌ´Ù. º¸¸é X´Â Ä³·µÀÌ°í
#Ä«¿îÆ®¸¦ º¸°í ÀÖ´Ù.

ggplot(data = diamonds) + geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

# µµ¼ö Ãâ·Â
diamonds %>% count(cut_width(carat, 0.5))


# È÷½ºÅä±×·¥ ÁßÃ¸ ½Ã°¢È­
ggplot(data = diamonds, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)



# ¿¹Á¦: ÀÌ»óÄ¡(Outlier) ÆÇº° ¹× Ã³¸®

#Áö±İ º¸¸é µ¥ÀÌÅÍµéÀº 10 ~ 20 ¾È¿¡ ÀÖ´Âµ¥ º¸¸é XÃàÀÌ 60±îÁö ³ª¿ÍÀÖ´Ù.
#±×·¯¸é 60±îÁö ¾Èº¸ÀÌ´Â °÷¿¡ ´Ù ¾Æ¿ô¶óÀÌ¾î°¡ ÀÖ´Ù´Â ¶æÀÌ µÈ´Ù.
#±×·¡¼­ ÀÌ·± ¾Æ¿ô¶óÀÌ¾î¸¦ Á¦°¡ÇÏ±â À§ÇØ¼­ ¾Æ·¡ÂÊÀÇ DPLYRÀÇ ÇÊÅÍ¸¦
#»ç¿ëÇÏµµ·Ï ÇÑ´Ù. ÇÊÅÍ¸¦ ÅëÇØ y°ª Áï ÃøÁ¤Ä¡°¡ 3 ~ 20 »çÀÌ¸¦ »ìÆìº¸µµ
#·Ï ÇÑ´Ù. ±×·³ ÀÌ°É º¸°í ¹ö¸±Áö º¸Á¤ÇÒÁö Á¤ÇÏ¸é µÈ´Ù.

ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)

# yº¯¼ö°ª ´ëºÎºĞÀº 3ÀÌ»ó 10(¶Ç´Â 20)ÀÌÇÏ¿¡ Á¸Àç,
# ÃàÀÇ °ªÀº 0ºĞÅÍ 60±îÁö ­ŒÇö
# ¿À·ùÀÎÁö ÀÌ»óÄ¡ÀÎÁö ÆÇ´Ü ÇÊ¿ä
diamonds %>% dplyr::filter(y < 3 | y > 20) %>% arrange(y)


## y°ªÀÌ 3 ÀÌÇÏ ÀÌ°Å³ª 20 ÀÌ»óµÇ´Â °ÍÀº ºñÁ¤»óÀû »óÈ² ==> ÀÌ¸¦ º°µµÀÇ ¸é¹ĞÇÑ Á¶»ç ÇÊ¿ä.
## ÀÌ»ó°ªÀÇ (1) Á¦°Å or (2) À¯Áö(Ã³¸®)??

#(1) ÀÌ»óÄ¡¸¦ Á¦°ÅÇÏ´Â ¹æ¹ı 

#´ÙÀÌ¾Æ¸óµå¿¡¼­ 3 ~ 20 »çÀÌ°ª¸¸ ÇÊÅÍ¸µÇØ¼­ »õ·Î¿î ´ÙÀÌ¾Æ¸óµå2 ¿¡ ³Ö´Â ¹æ¹ı

Diamonds2 <-diamonds %>% filter(between(y, 3, 20))
ggplot(Diamonds2) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)

#(2) ÀÌ»ó°ªÀ» °áÃø°ªÀ¸·Î Ä¡È¯ÇÏ´Â ¹æ¹ı

#°áÃøÄ¡ Áï 3º¸´Ù ÀÛ°í 20º¸´Ù Å«°ªÀ» NA·Î Ã³¸®ÇÏ´Â ¹ıÀÌ´Ù.

Diamonds3 <- diamonds %>% mutate(y = ifelse(y < 3 | y > 20, NA, y))
ggplot(Diamonds3) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)
Diamonds3 %>% dplyr::filter(y < 3 | y > 20) %>% arrange(y)


# µÎº¯¼ö ÀÌ»ó °øº¯µ¿(Covariation)

## ¹üÁÖÇü°ú ¿¬¼ÓÇüÀ» ½Ã°¢È­ÇØ¼­ °øº¯µ¿À» È®ÀÎÇÒ °æ¿ì 
## density plot, boxplot »ç¿ë. 
## Æ¯È÷ ¹üÁÖ¿¡ ¼ø¼­°¡ ÀÖ´Â °æ¿ì, ¼ø¼­Çü ¹üÁÖ°ªÀ» ¹İ¿µÇÏ¿© ½Ã°¢È­ ±ÇÀå.

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) +
  geom_freqpoly(mapping = aes(colour = cut), binwidth =500)


# reorder()ÇÔ¼ö »ç¿ë

#reorder() ÇÔ¼ö´Â ÇØ´ç ¿ä¼Ò¿¡ ´ëÇØ¼­ Á¤·ÄÀ» ÇØÁÖ¾î Ä¿Á®°¡´Â ÇüÅÂ·Î º¸±â ÁÁ°Ô
#¹Ù²Ù¾î ÁÖ´Â ¿ªÇÒÀ» ÇÑ´Ù. ¾î¶»°Ô »ç¿ëµÇ´ÂÁö ½ÇÇàÇÏ°í È®ÀÎ ÇØº¸ÀÚ.

ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

# reorder()ÇÔ¼ö ¹Ì»ç¿ë
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = class, y = hwy))


# µÎº¯¼ö°¡ ¸ğµÎ ¹üÁÖÇüÀÏ °æ¿ì geom_count() »ç¿ë
ggplot(data = diamonds) + geom_count(mapping = aes(x = cut, y = color))

# dplyr;  count() & geom_tile()
diamonds %>%  count(color, cut)


#¾Æ·¡´Â È÷Æ®¸ÊÀ» ¸¸µå´Â ¹æ¹ıÀÌ°í geom_tile Áï Å¸ÀÏ·Î ¸¸µç´Ù.

diamonds %>%
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) + geom_tile(mapping = aes(fill = n))


# µÎ ¿¬¼ÓÇü º¯¼ö 

#Æ÷ÀÎÆ® Áï »êÁ¡µµ¸¦ µÎ°³ÀÇ ¿ä¼Ò¸¦ ±âÁØÀ¸·Î Ç¥ÇöÇÑ´Ù.

ggplot(data = diamonds) + geom_point(mapping = aes(x = carat, y = price))

# Åõ¸íµµ µµÀÔ
ggplot(data = diamonds) + geom_point(mapping = aes(x = carat, y = price), alpha = 1/100)

# Á÷»ç°¢Çü ±¸°£  
ggplot(data = diamonds) + geom_bin2d(mapping = aes(x = carat, y = price))

# À°°¢Çü ±¸°£
#install.packages("hexbin")
library(hexbin)
ggplot(data = diamonds) + geom_hex(mapping = aes(x = carat, y = price))  

# ¿¬¼ÓÇü º¯¼ö¸¦ ¹üÁÖÈ­ÇÏ¿© »óÀÚ±×¸²À¸·Î ½Ã°¢È­ÇÏ´Â ¹æ¹ı
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))