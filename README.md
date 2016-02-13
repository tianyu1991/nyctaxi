# nyctaxi
NYC TAXI
database: 2013 new york city taxi database 
operation system: MAC 

In this project, I’m trying to predict the most suitable location for taxi drivers to go in order to find the passenger quickly and without wasting too much time in traffic jam. Taxi is one of the most important transportation methods in NYC, finding the best route to go when no passenger is on board is of great value to both drivers and passengers. In this project,I will calculate the most suitable way based on trip distance, trip time and the amount of passages.  
At first I got 2013 NYC  taxi trip data from online.(http://chriswhong.com/open-data/foil_nyc_taxi/). Then, I discretized continuous longitude and latitude into discrete small blocks since taxi drivers usually do not need a  precise longitude and latitude, using blocks will be more practical.After that I calculate the amount of passages at each location at each hour. I upload the plot of the amount of taxi passages at NYC at 6pm as my first plot.  Next, I calculated the speed of trip based on trip time and trip distanced. I notice some speed of trip is abnormally large or corresponding trip data to calculate, so I get rid of those outliers. The plot of average speed of taxis from different pick up locations at 6PM is used as my second plot. Finally, I will build a model to combined those data together, or even build a model based on taxi driver’s requirement, whether they to find near passage, a quick trip with less travel jam or a trip with long distance.     




![bestpickup500](https://cloud.githubusercontent.com/assets/8493530/13025315/65ab9b4a-d1d2-11e5-82a0-ce655714a078.png)
![bestpickup1000](https://cloud.githubusercontent.com/assets/8493530/13025316/6751cc4e-d1d2-11e5-8062-25d3119d5596.png)
![bestpickup5002](https://cloud.githubusercontent.com/assets/8493530/13025318/690d7c54-d1d2-11e5-8cce-1e0ef6e71f69.png)
![bestpickup10002](https://cloud.githubusercontent.com/assets/8493530/13025320/6b6ea518-d1d2-11e5-87a0-e8b32dc11c55.png)
![bestpickupcount](https://cloud.githubusercontent.com/assets/8493530/13025322/73e48942-d1d2-11e5-9ae8-b5acb33d5c55.png)

![mostpickuplocationeachhour](https://cloud.githubusercontent.com/assets/8493530/13025326/a2ae90c4-d1d2-11e5-98e3-a53743afc294.png)
![pickuplocationeachhour](https://cloud.githubusercontent.com/assets/8493530/13025327/a6bf9596-d1d2-11e5-98e4-261853fe3474.png)
