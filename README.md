# nyctaxi
NYC TAXI
database: 2013 new york city taxi database 
operation system: MAC 

In this project, I’m trying to predict the most suitable location for taxi drivers to go in order to find the passenger quickly and without wasting too much time in traffic jam. Taxi is one of the most important transportation methods in NYC, finding the best route to go when no passenger is on board is of great value to both drivers and passengers. In this project,I will calculate the most suitable way based on trip distance, trip time and the amount of passages.  
At first I got 2013 NYC  taxi trip data from online.(http://chriswhong.com/open-data/foil_nyc_taxi/). Then, I discretized continuous longitude and latitude into discrete small blocks since taxi drivers usually do not need a  precise longitude and latitude, using blocks will be more practical.After that I calculate the amount of passages at each location at each hour. I upload the plot of the amount of taxi passages at NYC at 6pm as my first plot.  Next, I calculated the speed of trip based on trip time and trip distanced. I notice some speed of trip is abnormally large or corresponding trip data to calculate, so I get rid of those outliers. The plot of average speed of taxis from different pick up locations at 6PM is used as my second plot. Finally, I will build a model to combined those data together, or even build a model based on taxi driver’s requirement, whether they to find near passage, a quick trip with less travel jam or a trip with long distance.     



the most frequent pick up location (except for airports) in each hour 

[nyctaxipickuplocation.pdf](https://github.com/tianyu1991/nyctaxi/files/116940/nyctaxipickuplocation.pdf)

the pick up frequency at 6pm 

[pick up at 6pm details2.pdf](https://github.com/tianyu1991/nyctaxi/files/116937/pick.up.at.6pm.details2.pdf)

the mean speed of taxis from each pick up location at 6pm 

[averagespeed.pdf](https://github.com/tianyu1991/nyctaxi/files/116945/averagespeed.pdf)
