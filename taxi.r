setwd("/Users/appletree/Documents")
rowdata<-read.csv("trip_data_1.csv",header=TRUE)
data<-data.frame(pickup_datetime=rowdata$pickup_datetime,trip_time_in_secs=rowdata$trip_time_in_secs,trip_distance=rowdata$trip_distance,pickup_longitude=rowdata$pickup_longitude,pickup_latitude=rowdata$pickup_latitude)


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

png(file="PickuplocationEachHour.png",width=780,height=480)
ggplot(data3,aes(mean_longitude,mean_latitude))+geom_point(aes(size=count,colour=factor(pickup_hour)),alpha=1/2)+scale_size_area()+ggtitle("NYC taxi pick up location")+xlab("mean longitude")+ylab("mean latitude")
dev.off()

char_i="00"
pickup_hour2<-as.numeric(data$pickup_hour)-1
data<-cbind(data,pickup_hour2)

location2<-data.frame(hour=c(0:23),count=rep(0,24),mean_longitude=rep(0,24),mean_latitude=rep(0,24))
for(i in 0:23){
	sub_data<-data[pickup_hour2==i,]
	s2<-group_by(sub_data,pickup_location)
	s3<-		summarise(s2,count=n(),mean_longitude=mean(pickup_longitude),mean_latitude=mean(pickup_latitude))
	location2[i+1,c(2,3,4)]<-arrange(s3,desc(count))[c(1),c(2,3,4)]
}

png(file="MostPickuplocationEachHour.png",width=780,height=480)
ggplot(location2,aes(mean_longitude,mean_latitude))+geom_point(aes(size=count,colour=factor(hour)),alpha=1/4)+scale_size_area()+ggtitle("most frequent taxi pick up location")+xlab("mean longitude")+ylab("mean latitude")
dev.off()


sub_data<-data[pickup_hour2==18,]
velocity<-sub_data$trip_distance/sub_data$trip_time_in_secs*360
velocity[is.na(velocity)|is.infinite(velocity)]<-0
velocity[velocity>quantile(velocity, 0.999)]<-0
velocity[velocity==0]<-NA
mean<-mean(velocity[!is.na(velocity)])
sub_data$velocity<-velocity
velocity[!is.na(velocity)]<-velocity[!is.na(velocity)]/mean
sub_data<-cbind(sub_data,velocity_index=velocity)
distance_index<-sub_data$trip_distance/mean(sub_data$trip_distance)
sub_data<-cbind(sub_data,distance_index)
sub_data2<-sub_data[!is.na(sub_data$velocity),]

## set de index for velocity and trip_distance
##assume the index for velocity is 0.3
##assume the index for trip distance is 0.2
##assume 2,1 
##assume 
i_vel<-0.3
i_dis<-0.2

index<-sub_data2$velocity_index^i_vel*sub_data2$distance_index^i_dis
sub_data2<-cbind(sub_data2,index)

s2<-group_by(sub_data2,pickup_location)
s3<-		summarise(s2,score=sum(index),count=n(),mean_longitude=mean(pickup_longitude),mean_latitude=mean(pickup_latitude),mean_velocity=mean(velocity,na.rm=TRUE))

lo_q<-quantile(s3$mean_longitude, c(.05, .95)) 	
la_q<-quantile(s3$mean_latitude, c(.05, .95)) 	

s4<-
s3[(s3$mean_longitude>lo_q[1])&(s3$mean_longitude<lo_q[2])&(s3$mean_latitude>la_q[1])&(s3$mean_latitude<la_q[2]),]

png(file="bestpickupcount.png",width=780,height=480)
ggplot(s4,aes(mean_longitude,mean_latitude))+geom_point(aes(colour=count),size=0.2,alpha=1/3)+scale_size_area()+ggtitle("pick up counts at 6pm ")+xlab("longitude")+ylab("latitude")
dev.off()


png(file="bestpickup500.png",width=780,height=480)
ggplot(s4,aes(mean_longitude,mean_latitude))+geom_point(aes(colour=score),size=0.2,alpha=1/3)+scale_size_area()+ggtitle("best pick up location at 6pm (score range:0:500)")+xlab("longitude")+ylab("latitude")+scale_colour_gradient(limits=c(0, 500))
dev.off()

png(file="bestpickup1000.png",width=780,height=480)
ggplot(s4,aes(mean_longitude,mean_latitude))+geom_point(aes(colour=score),size=0.2,alpha=1/3)+scale_size_area()+ggtitle("best pick up location at 6pm (score range:0:1000)")+xlab("longitude")+ylab("latitude")+scale_colour_gradient(limits=c(0, 1000))
dev.off()
