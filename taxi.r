setwd("/Users/appletree/Documents")
rowdata<-read.csv("trip_data_1.csv",header=TRUE)
data<-data.frame(pickup_datetime=rowdata$pickup_datetime,trip_time_in_secs=rowdata$trip_time_in_secs,trip_distance=rowdata$trip_distance,pickup_longitude=rowdata$pickup_longitude,pickup_latitude=rowdata$pickup_latitude)

#library(lubridate)
#b<-ymd_hms(a$pickup_datetime)

rowdata<-read.csv("trip_data_2.csv",header=TRUE)
data2<-data.frame(pickup_datetime=rowdata$pickup_datetime,trip_time_in_secs=rowdata$trip_time_in_secs,trip_distance=rowdata$trip_distance,pickup_longitude=rowdata$pickup_longitude,pickup_latitude=rowdata$pickup_latitude)

data<-rbind(data,data2)

pickup_hour<-strftime(data$pickup_datetime,"%H")
data<-cbind(data,pickup_hour)
la_mean<-mean(data$pickup_latitude)
pickup_latitude_num<-as.integer((data$pickup_latitude-la_mean)/0.0003)
lo_mean<-mean(data$pickup_longitude)
pickup_longitude_num<-as.integer((data$pickup_longitude-lo_mean)/0.0002)
pickup_location<-paste(as.character(pickup_longitude_num)," ",as.character(pickup_latitude_num))
data<-cbind(data,pickup_location)

library(dplyr)
data2<-group_by(data,pickup_hour)
data3<-summarise(data2,count=n(),mean_longitude=mean(pickup_longitude),mean_latitude=mean(pickup_latitude))
library(ggplot2)
ggplot(data3,aes(mean_longitude,mean_latitude))+geom_point(aes(size=count,colour=factor(pickup_hour)),alpha=1/2)+scale_size_area()+ggtitle("NYC taxi pick up location")

char_i="00"
pickup_hour2<-as.numeric(data$pickup_hour)-1
data<-cbind(data,pickup_hour2)

location2<-data.frame(hour=c(0:23),count=rep(0,24),mean_longitude=rep(0,24),mean_latitude=rep(0,24))
for(i in 0:23){
	sub_data<-data[pickup_hour2==i,]
	s2<-group_by(sub_data,pickup_location)
	s3<-		summarise(s2,count=n(),mean_longitude=mean(pickup_longitude),mean_latitude=mean(pickup_latitude))
	location2[i+1,c(2,3,4)]<-arrange(s3,desc(count))[c(2),c(2,3,4)]
}
ggplot(location2,aes(mean_longitude,mean_latitude))+geom_point(aes(size=count,colour=factor(hour)),alpha=1/4)+scale_size_area()+ggtitle("NYC taxi pick up location2")

sub_data<-data[pickup_hour2==18,]
velocity<-sub_data$trip_distance/sub_data$trip_time_in_secs*360
velocity[is.na(velocity)|is.infinite(velocity)]<-0
velocity[velocity>quantile(velocity, 0.999)]<-0
velocity[velocity==0]<-NA
sub_data$velocity<-velocity

sub_data<-cbind(sub_data,velocity)


s2<-group_by(sub_data,pickup_location)
s3<-		summarise(s2,count=n(),mean_longitude=mean(pickup_longitude),mean_latitude=mean(pickup_latitude),mean_velocity=mean(velocity,na.rm=TRUE))

lo_q<-quantile(s3$mean_longitude, c(.05, .95)) 	
la_q<-quantile(s3$mean_latitude, c(.05, .95)) 	

s4<-
s3[(s3$mean_longitude>lo_q[1])&(s3$mean_longitude<lo_q[2])&(s3$mean_latitude>la_q[1])&(s3$mean_latitude<la_q[2]),]

ggplot(s4,aes(mean_longitude,mean_latitude))+geom_point(aes(colour=count),size=0.2,alpha=1/3)+scale_size_area()+ggtitle("NYC taxi pick up nums at 6pm ")+xlab("longitude")+ylab("latitude")

ggplot(s4,aes(mean_longitude,mean_latitude))+geom_point(aes(colour=mean_velocity),size=0.2,alpha=1/3)+scale_size_area()+ggtitle("average speed of trip with different pick up location at 6pm ")+xlab("longitude")+ylab("latitude")
