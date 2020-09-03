# IST 707: Data Analytics
## Randall Scott Taylor

965757884

rstaylor@syr.edu

randallscott25@gmail.com

## Description

# IST 652: Scripting For Data Analysis
## Randall Scott Taylor

965757884

rstaylor@syr.edu

randallscott25@gmail.com

## Description
# **Covid Project ETL and EDA**

MEMBERS OF THE TEAM | CONTRIBUTION 
------------------- | -------------
Randall Scott Taylor | Utilizing New York Times Covid-19 Data and CDC CHSI data can we predict whether a county is more at risk for Covid-19 infection? Can this be clustered and analyzed geospatially? 

**Task Lists**

 - [x] ETL
 - [x] EDA
 - [X] kmeans
 - [ ] linear modeling
 - [x] interactive plotting 
 
There are data sets that exist on the New York Times website, and git repository at:

https://github.com/nytimes/covid-19-data/


_"The New York Times is releasing a series of data files with cumulative counts of coronavirus cases in the United States, at the state and county level, over time. We are compiling this time series data from state and local governments and health departments in an attempt to provide a complete record of the ongoing outbreak._

_Since late January, The Times has tracked cases of coronavirus in real time as they were identified after testing. Because of the widespread shortage of testing, however, the data is necessarily limited in the picture it presents of the outbreak._

_We have used this data to power our maps and reporting tracking the outbreak, and it is now being made available to the public in response to requests from researchers, scientists and government officials who would like access to the data to better understand the outbreak._

**The data begins with the first reported coronavirus case in Washington State on Jan. 21, 2020. We will publish regular updates to the data in this repository.**

_Live and Historical Data_
_We are providing two sets of data with cumulative counts of coronavirus cases and deaths: one with our most current numbers for each geography and another with historical data showing the tally for each day for each geography._

_The historical data files are at the top level of the directory and contain data up to, but not including the current day. The live data files are in the live/ directory._

_A key difference between the historical and live files is that the numbers in the historical files are the final counts at the end of each day, while the live files have figures that may be a partial count released during the day but cannot necessarily be considered the final, end-of-day tally._

_The historical and live data are released in three files, one for each of these geographic levels: U.S., states and counties._

__Each row of data reports the cumulative number of coronavirus cases and deaths based on our best reporting up to the moment we publish an update. Our counts include both laboratory confirmed and probable cases using criteria that were developed by states and the federal government. Not all geographies are reporting probable cases and yet others are providing confirmed and probable as a single total. Please read here for a full discussion of this issue.__

_We do our best to revise earlier entries in the data when we receive new information. If a county is not listed for a date, then there were zero reported confirmed cases and deaths._

_State and county files contain FIPS codes, a standard geographic identifier, to make it easier for an analyst to combine this data with other data sets like a map file or population data"_ (New York Times).

## Required Tools

* python 3

* Google Colab

* scipy

* statsmodels

* sklearn

* all of the plotly packages, ff, px, go all with these pip install commands

!pip install autoplotter
!pip install addfips
!pip install fuzzywuzzy
!pip install python-Levenshtein
!pip install -q xlrd
!pip install geopandas
!apt install proj-bin libproj-dev libgeos-dev
!pip install ijson
!pip install plotly.geo 
!pip install plotly
!pip install geopandas
!pip install pyshp
!pip install shapely

!pip install --upgrade plotly
!pip install --upgrade geopandas
!pip install --upgrade pyshp
!pip install --upgrade shapely
!pip install heatmapz



## Table of Contents

1. README.md 
    - Overview Document detailing repository contents

2. [Data](https://github.com/randallscott25/MSADS_Portfolio/tree/master/IST718_BigData/data)
    - All data used in this project

3. [Scripts](https://github.com/randallscott25/MSADS_Portfolio/tree/master/IST718_BigData/scripts)
    - Scripts used to conduct analysis

4. [TAYLOR_PPT_IST707.pdf](forthcoming)
    - Project presentation
    
5. [TAYLOR_RPT_IST707.pdf](forthcoming)
    - Project report
  
6. [Project_Description.pdf](https://github.com/randallscott25/MSADS_Portfolio/blob/master/IST718_BigData/b.6.1_41469_final_project_report_clean.pdf)
    - Project description and guidelines


