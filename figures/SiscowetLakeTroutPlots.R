#Load libraries
library(FSAdata) #for data
library(tidyverse) #for cleaning and plotting
devtools::install_github("ciannabp/inauguration") #for testing a palent
library(inauguration)


#Look at the siscowet data (I did not see a CSV file, did I miss it?)
# I am just using the data from the library.
head(SiscowetMI2004)

#I'm going to remove the data point of the heavy fish.
dat<-SiscowetMI2004 %>% filter(wgt <10000)

# Look at a few things ####
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
ggplot(dat, aes(x= len, y = mesh, color = locID)) +
  geom_point()

ggplot(dat, aes(x= len, y = wgt, color = mesh)) +
  geom_point()


#BUILD EXPLORATORY ####
#I want mesh to be a factor
datfac<-dat %>% mutate_at(vars(mesh), factor)

#I need the whole numbers to be #.0, as it started in the original data
levels(datfac$mesh) <- c("2.0", "2.5", "3.0", "3.5",
                         "4.0", "4.5", "5.0", "5.5", "6.0")


#This is my final exploratory plot. I'm satisfying my curiousity about what
# what mesh sizes capture which lengths of fish.
explor<-ggplot(datfac, aes(x= mesh, y = len, fill = locID)) + #converted mesh to factor, now it must go on X axis
  geom_boxplot() +
  coord_flip() #I used this to return mesh size to 

explor
ggsave("figures/exploratory.jpg", width = 5, height = 5)

#BUILD EXPOSITORY ####
expos<-explor + 
  theme_minimal() +
  xlab("mesh size \n (cm)") +
  ylab("body length (mm)") +
  theme(axis.title.y = element_text(angle = 0, vjust = 0.5,size=10),
       axis.text = element_text(size=10)) +
  labs(fill="Capture Site") 

#I've never used a pallet before! Now to try...
ing_cols<-inauguration("inauguration_2021", 4)

#Do I prefer the legend on the bottom?
expos + scale_fill_manual(values = ing_cols) +
  theme(legend.position = "bottom") +
  guides(fill=guide_legend(nrow=2,byrow=TRUE))

#This is better, not the best, but enough.
ggsave("figures/expository.jpg", width = 5, height = 5)


  


