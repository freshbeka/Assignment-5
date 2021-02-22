#Load data
library(FSAdata)
library(tidyverse)

#Look at the siscowet data
head(SiscowetMI2004)

#I'm going to remove the data point of the heavy fish.
dat<-SiscowetMI2004 %>% filter(wgt <10000)

# Look at a few things
ggplot(dat, aes(x = locID)) + 
  geom_bar()

ggplot(dat, aes(x= len, y = wgt, color = locID)) +
  geom_point()

ggplot(dat, aes(x= len, y = pnldep, color = locID)) +
  geom_point()

ggplot(dat, aes(x= len, y = mesh, color = locID)) +
  geom_point()

ggplot(dat, aes(x= wgt, y = mesh, color = locID)) +
  geom_point()

##I'm drawn to the mesh size and the length, because the small
# mesh size is capturing so many lengths, that is interesting.
# I want to see if I can have box and whisker plots instead so 
# I can see if one location is driving that range, or if all locations have
# wide ranges of fish lengths.

#I want mesh to be a factor
datfac<-dat %>% mutate_at(vars(mesh), factor)

ggplot(datfac, aes(x= mesh, y = len, fill = locID)) +
  geom_boxplot() +
  coord_flip()

ggplot(dat, aes(x= len, y = mesh, color = locID)) +
  geom_point()

ggplot(dat, aes(x= len, y = wgt, color = mesh)) +
  geom_point()



  geom_jitter(position = position_jitter(0.01))


