**Overview of the project**

Data was taken from NASA about meteorites that have been found up to the year 2013. The project can be split up into 2 sections: data tidying up and analysis.
The analysis of csv file was performed using R.

**Data clean or preparation prior analysis**

	clean_meteorites_data.R

* Required libraries were loaded and data was briefly explored.
* Column names were changed following naming standards - "snake_case".
* GeoLocation column was split into latitude and longitude.
* Missing data of location was replaced with zeros.
* Small meteorites (less than 1000 g) were removed.
* The data was ordered by year of discovery. 
* Latitude and longitude columns were transferred to numeric class.
* Finally, assertive programming was set up for latitude and longitude columns.


**Meteorites data analysis**
	
	meteorites_data_analysis.Rmd

* Mostly using dplyr from tidyverse, the data was analysed.
* The names of 10 largest meteorites were found by year.
* Average mass of meteorites split up by their "fall" - found or fell.
* Total number of meteorites per year since 2000. 
* Biggest meteorite found per year. 
* Biggest meteorite fell per year.
* The 10 biggest meteorites over all the years.
* The 10 smalles meteorites over all the years.
* Median latitude and longitutde of all meteorites. 
* Mass of meteorites changed from grams to kilograms.


 