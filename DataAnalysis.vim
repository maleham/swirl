"""
2. DATA ANALYSIS

2.1. CENTRAL TENDENCY
*plotrix, openintro packages required and installed

- DATA (Wikipedia): values of qualitative or quantitative variables, belonging
    to a set of items (POPULATION)
- DATA ANALYSIS: involves studying a subset (SAMPLE) of a population, it always
    starts with a specific question of interest. We hope that our sample is
    REPRESENTATIVE of the entire population
  https://www.youtube.com/watch?v=sRArT81TVEM&feature=youtu.be
    NOTE that processed data containsone kind of observation per table/datafile
- INFERENCE: purpose of data analysis, to draw a conclusion about the
  population from which the sample was selected.
  Primary goal of INFERENTIAL STATISTICS
  To make inferences about population, we need to describe sample --> primary
  goal of DESCRIPTIVE ANALYSIS
- CENTRAL TENDENCY: good start in describing data is to find center, middle,
  the most common element in the data (MEAN, MEDIAN, MODE)
    MEAN
    MEDIAN: middle number (in case of even #, take avg of 2 middle #s)
    MODE: most common number
  https://www.youtube.com/watch?v=h8EYEJ32oQ8&feature=youtu.be

- dataset$variable notation = to extract/acces a variable from a dataset
- mean() = built-in function to calculate mean
- median() = built-in function, can be used to compare with mean and make 
  sure that no extreme outliers are influencing negatively our mean
- no built-in function for MODE, one has to e.g. create a table(var) to see
  which value is the most frequent one and thus the MODE (the value of the 
  variable that is most common, not the number of times it appears)

2.2. DISPERSION
- Measures of DISPERSION are importand to describe the SPREAD of data
- DISPERSION: degree to which the data values are scattered around
  and average value (same as variability, spread)

- RANGE: difference between max and min values of dataset
  range() = gives you the min and max (you would then have to compute the
            difference between both values)
- VARIANCE: represents total distance of the data from mean
  var(data) = variance of a particular set of data
- SD: sqrt(var), more conventional measure of variability because it 
  is expressed in the same units as the original data values
  Small SD indicate that datapoints are near mean value and viceversa
  https://www.youtube.com/watch?v=E4HAYd0QnRc&feature=youtu.be

- BOX PLOT == BOX-AND-WHISKER PLOT: represents min, Q1, median, Q3, median
  https://www.youtube.com/watch?v=BXq5TFLvsVw&feature=youtu.be
  to represent variability: middle 50% of data is represented inside box
  boxplot(data,col='blue')

  -- height of each box: INTERQUARTILE RANGE (IQR). The more variability
     within the data, the larger the IQR. IQR=Q3-Q1
     middle 50% of data represented inside the box (between Q1 and Q3). The
     rest of the data is represented in whiskers and stands for bottom and
     top 25% values
        --- quantile() = to see 0/25/50/75/100th percentile of data
  -- bottom of box: Q1 or 25th percentile 
                    (== median of first half of sorted data)
                    debatable whether median is included or not when 
                    calculating percentiles (typically it IS)
                    (see video youtube)
  -- top of box: Q3 or 75th percentile 
                 (== median of second half of sorted data)
  -- whiskers (lines) above and below each box: rough representation of the
     upper 25% and lower 25% of datapoints respectively (exception when there
     are outliers)
  -- circles: OUTLIERS = unusual/extreme observations relative to other
     values in the dataset. 

  -- NOTE!!!! summary(dataset$variable) returns values for the main    
     descriptive statistics represented in box plot (median, Q1, Q3)

2.3. DATA VISUALIZATION
- Useful to first visualize data before engaging in data analysis
- Organization of data to PLOTS enables to explore and summarize
  basic properties of the dataset. Quantitative description of main properties
  of a data set is DESCRIPTIVE STATISTICS

- DOT PLOT: particularly useful for small datasets
- HISTOGRAM: provide a view of the DATA DENSITY
             Useful in viewing and describing the shape of the distribution
             of data. Distribution of data may have left/right/no skew.
             SKEWNESS: extent to which distribution of data leans to one                               side or the other
             - Left-skewed distribution: mean<median
             - Right-skewed distribution: mean>median
             - No skew == tails on both sides of the mean balance out 
               (SYMMETRIC DISTRIBUTION): mean~median
- STEM-AND-LEAF PLOT: number of leaves==number of items in data set
  useful type of histogram
  https://www.youtube.com/watch?v=OaJXJduRiIE&feature=youtu.be
  - In STEM: most significant digits (e.g. in the video "tens digit") 
  - In LEAVES: you write the other digits that do not belong to STEM-digits
    (in our case, the units, since the tens are in the stem)
  - We see how numbers are distributed!!! We see where most numbers are 
    and where the lease abundant numbers are as well
- BOX PLOT: summarizes main descriptive statistics of a particular dataset
  and illustrates the concept of variability
"""
