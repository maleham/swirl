"""
Slides at https://github.com/DataScienceSpecialization/courses/

########################################################################

1. PRINCIPLES OF ANALYTIC GRAPHS
This lesson corresponds to 
04_ExploratoryAnalysis/Principles_of_Analytic_Graphics

How to desplay results in order to make them more meaningful and convincing.
These principleas are cribbed from E. Tufte's book, Beautiful Evidence. 
www.edwardtufte.com

- 1st principle of analytic graphs is to show COMPARISON
    - Controls (lowest box plots) normally go on the left of the figure
- 2nd principle is to show causality or a MECHANISM of how our theory
  of the data works. This explanation or systematic structure shows the 
  causal framework for thinking about the question we're answering
  e.g. in air-cleaner increasing days of no symptoms in asthmatic patients,
  show as well a box plot with the reduction of air pollution when using        
  the air cleaner. This way, you explain with graphs the theory of why
  I think that the air cleaner increases the number of symptom-free days
- 3rd principle: to show MULTIVARIATE DATA
- 4th principle: involves INTEGRATING EVIDENCE, i.e. not limiting yourself 
  to one form of representation
- 5th principle: describing and documenting evidence with sources and
  labels and scales
- 6th principle: CONTENT IS KING

- SIMPSON'S PARADOX (Yule-Simpson Effect): paradox in probability and
  statistics in which a trend that appears in different groups of data 
  disappears when these groups are combined. 
  e.g. mortality/pollution data (increase in pollution results in decrease
  of mortality, but we would see different trends if we divided this data
  into the four seasons
  http://en.wikipedia.org/wiki/Simpson%27s_paradox

########################################################################

2. EXPLORATORY GRAPHS
04_ExploratoryAnalysis/exploratoryGraphs

- Exploratory graphs help us to find patterns in data and understand its
  properties. They suggest modeling strategies and help to debug analyses
- Exploratory graphs are NOT used to communicate results, they are initial 
  step in an investigation ("quick and dirty" tool used to point the data
  in a fruitful direction)

- In boxplots, whiskers are drawn to be a length of range*IQR or 1.5*IQR
  This shows roughly how many, if any, data points are outliers
- abline() = to add one or more straight lines through the current plot
  e.g. abline(v=median(ppm),col='magenta',lwd=4) #lwd=line width
- rug() = 1D plot with grayscale representation. If included in a histogram,
  gives more detailed information about how many datapoints are in each         
  bucket and where they lie within the bucket. 
  rug() automatically adjusts its pocket size to that of last plot plotted
- breaks = argument in hist() that specifies the number of buckets to
  split the data into
  **bucket==bin in python??
- REMEMBER! names() = gives names of columns (variables) of dataset
- barplot()
- We use the R formula y ~ x to show that y depends on x. If both variables
  come from the same df, no need to type pollution%pm25 or pollution%region 
  when typing the formula y~x as arg inside, e.g., a boxplot function. I can
  specify the data=pollution after: 
                     boxplot(pm25~region, data=pollution, col='red')
                     2 pm25 25boxplots, one for each region
- par() = to specify margins and how we want to lay out the plots
          OR to find out the values that are already set
            PAR GIVES ACCESS TO 72 PARAMETERS! --> see > names(par())
  par(mfrow=c(2,1),mar=c(4,4,2,1)) -->
    mfrow: vector of form x(nr,nc) --> subsequent figures will be 
           drawn in an nr-by-nc array on the device by rows
           (if mfcol, plots are filled col by col), see section 5
    mar: set up margins, vector with form c(bottom,left,top,right)
         default is x(5,6,6,2) + 0.1
    Other examples:
    -- pch: plot character, default is the open circle (all characters
            are associated to integers)
            http://www.endmemo.com/program/R/pchsymbols.php
    -- lwd: line width
    -- lty: line type (dashed, etc, associated to integer too)
            BUT can be also specified as string, the same as color (col)
- subset() to pull off data that we further want to plot
  e.g. to pull off the EASTERN counties in the "region" column from the 
       pollution dataset --> subset(pollution, region=="east")
       (I only get the info of the EASTERN counties)
  (After par() and dividing area of plotting figures in 2rows+1col: 
  hist(subset(pollution,region=='east')$pm25, col='green')
  hist(subset(pollution,region=='west')$pm25, col='green') )

NICE EXAMPLES IN THE TUTORIAL (from ~76% on): 

  | We've seen that we can use a function call as an argument when 
  | calling another function. We'll do this again when we call plot 
  | with the arguments latitude and pm25 which are both from 
  | our data frame pollution. We'll call plot from inside the R 
  | command with which evaluates "an R expression in an environment
  | constructed from data". We'll use pollution as the first argument
  | to with and the call to plot as the second. This allows us to
  | avoid typing "pollution$" before the arguents to plot, so it 
  | saves us some typing and adds to your base of R knowledge. Try this now.
  > with(pollution,plot(pm25~latitude))
    To sabe some typing from what would be the same:
    plot(pollution$latitude, pollution$pm25)
  > abline(h=12,lwd=2,lty=2) #lty makes the line dashed


  | Imagine now I want to plot pm25 vs latitude again but I want to
  | distinguish between counties from EAST and WEST (pollution$region):
  > plot(pollution$latitude,ppm,col=pollution$region)
    Result is two colors on map to distinguish eastern/western counties
  | Which counties, E/W, have more extreme latitudes?
  > west <- subset(pollution, region=="west")
  > summary(west) --> I see that max and min from "west" data correspond
                       to the most extreme points in the figure :)


  | But which region, E/W, is worse in terms of pollution (pm25>12)?
  | Plot 2 scatterplots distinguished by region: side by side 
  | (2col, 1row) and margins=c(5,4,2,1).
  | 1st scatterplot (left): latitudes and pm25 W
  > west <- subset(pollution, region=="west")
  > plot(west$latitude,west$pm25,main="West")
  > east <- subset(pollution, region=="east")
  > plot(east$latitude,east$pm25,main="East")

########################################################################

3. GRAPHICS DEVICES IN R
04_ExploratoryAnalysis/Graphics_Devices_in_R

- Graphics device: something where you can make a plot appear
  (screen device, FILE DEVICE (pdf, etc))
  When you make a plot in R, it has to be "sent" to a specific graphics 
  device (usually the screen, when doing exploratory work, but also to 
  files, when publishing a report e.g.)
- How to access screen device:
  Windows: windows()
  Unix/Linux: x11()

- ?Devices to see what graphics devices are available on my system
- title() = In case you forgot to add a title as an argument inside
  a plot() function, you are safe! --> title() function adds labels
  to plots

- dev.cur() = shows the current plotting device
              useful to check if I did dev.off() or not

- You can explicitly launch a graphics device:
  pdf(file="myplot.pdf") launches the file device and creates pdf file
  myplot.pdf in my working directory (no plot appears on the screen)
  
  pdf(file="") opens a pdf file where I can now plot whatever I want
  (it won't appear on the screen) and annotate what I want too. When
  plotting to a file device, the device must be closed with 
  > dev.off() --> now we are able to se the pdf on the computer

- TYPES OF FILE DEVICES:
  it is possible to open multiple graphic devices (screen, file or both)
  but plotting can only occur on one graphics device at a time

  -- VECTOR DEVICES: good for line drawings and plots with solid colors
     using a modest number of points
     VECTOR FORMATS:
          --- pdf: useful for line-type graphics and papers
          --- svg: XML-based, supports animation and interactivity
          --- win.metafile: Windows-only metafile format
          --- ps: postscript

  -- BITMAP DEVICES: good for plots with a large number of points, natural
     scenes, web-based plots...
     BITMAP FORMATS:
          --- png: line drawings or images with solid colors
                   does not resize well
          --- jpeg: good for photos, not good for line drawings
                    does not resize well
          --- tiff
          --- bmp

- dev.copy() = to save (COPY is a more appropriate word) the plot on 
  screen device to a file device, e.g., png:
  > with(faithful,plot(eruptions,waiting))
  > title(main="Old Faithful Geyser data")
  > dev.copy(png,file="geyserplot.png")   # NOTE QUOTATION MARKS!
  > dev.off()
          
########################################################################

4. PLOTTING SYSTEMS: Base Plotting System, 
04_ExploratoryAnalysis/PlottingSystems

A. BASE PLOTTING SYSTEM: old, you start with blank canvas and build plot 
   from there, step by step
   - Typically you start with a plot() function (or similar) and then
     you use annotation funtions to add to/modify plot
     -- Annotating functions: text(), lines(), points(), axis()
   - BUT you can't go back once a plot has started :(

B. LATTICE SYSTEM:
   - Plots are created with a single function call (although sometimes it
     is awkwars to specify an entire plot ina single function call)
   - Useful for conditioning types of plots (e.g. how y changes with x
     across levels of z)
   - margins'spacing set automatically (because entire plot is specified
     at once)
   - Good for puting many plots on a screen
   - Annotation in plot is not especially intuitive
   - Can't add once the plot is created

   - library(lattice) to import library (like import numpy)
 ### TUTORIAL IS NOT WORKING ANY MORE IN R AND I DON'T UNDERSTAND
     LATTICE/GGPLOT2 IN THE SLIDES FROM GITHUB, CHECK ANOTHER TUTORIAL

C. GGPLOT2 SYSTEM:
   - Splits the difference between base and lattice
   - Deals with spacings, text, titles
   - Allows you to annotate by "adding" to a plot
   - ~ to lattice but generally easier and more intuitive to use
   - Default mode makes many choices for you (but I can customize it)

   - library(ggplot2) to import library

########################################################################

5. BASE PLOTTING SYSTEM
04_ExploratoryAnalysis/PlottingBase

- Core plotting and graphics engine in R is encapsulated in 2 packages:
  -- GRAPHIC PACKAGE: contains functions for "base" system (plot, boxplot...)
  -- grDevices: contains the code implementing the various graphics devices,
                including X11, PDF, PNG, etc.

- You cannot go backwards if you need to readjust margins of have 
  misspelled a caption
- Most base plotting functions have many arguments. Some of the parameters
  can be set when you call the function of they can be added later in a 
  separate function call

- na.rm --> http://www.statmethods.net/input/missingdata.html
  (to exclude NA from a count or an analysis I guess)

- xlab/ylab = arguments inside plotting functions to label axes
- col.axis/col.lab = args inside plotting functions to color the numbers
                     of the axis or the label of the axis, respectively
- main = arg inside plotting functions to put title on a plot
       == title(main="...")

- SEE par() SECTION IN "2. EXPLORATORY GRAPHS"
  dev.off() or plot.new() to reset parameters in par() to defaults
- mfrow vs. mfcol: mfrow fills the rows first, mfcol fills cols first

- You can add TEXT, TITLE, POINTS, LINES to an existing plot.
  -- lines() = To add LINES, you give a vector of x values and a 
               corresponding vector of y values (or a 2col matrix) --> 
               the function lines() just connects the dots
  -- text() = adds text labels to a plot using specified x and y
              coordinates
  -- title() = to add annotations: xlabel, y label, title, subtitle, 
               outer margin...
  -- mtext() = adds arbitrary text to either outer or inner margins of 
               plot
  -- axis() = adds axis ticks and labels
  -- legend() = explains to the reader what the symbols of the plot mean

        EXAMPLE:
        > legend("topright",pch=c(17,8),col=c("blue","red"), \
                 legend=c("May","Other Months"))
                 # So the pch=17 (triangle) is blue and corresponds to May
                 # legend in right top corner :-)
        > abline(v=median(airquality$Wind), lty=2, lwd=2)
        > I canNOT add other plots with par() after this!!!! :-(
        > mtext("Ozone and Weather in New York City", outer=TRUE)
          # outer == use of outer margins, if available (default=FALSE)

- plot(x,equal='n',y) = tells T to set up the plot but not to put the 
                        data in it

########################################################################

6. LATTICE PLOTTING SYSTEM
04_ExploratoryAnalysis/PlottingLattice

- An add-on package, it has to be explicitly loaded with a call to the R
  function library
- Implemented using 2 packages:
  -- LATTICE: contains code for producing Trellis graphics, i.e., eht ones
              that the user would call. e.g. xyplot, bwplot, levelplot,
              histogram, stripplot, dotplot, splom...
              https://en.wikipedia.org/wiki/Trellis_%28graph%29
              http://www.statmethods.net/advgraphs/trellis.html
                xyplot == scatterplot
                bwplot == box and whisker plot
                histogram == histogram
  -- GRID: contains the low-level functions upon which the lattice package
           is built. The user rarely calls functions from this package
- No "two-phase" aspect with separate plotting+annotation. All done at once
  with a single function call

- Lattice functions generally take:
  -- A FORMULA as 1st arg, usually in the form of y~x, indicating that 
     y depends on x
        > xyplot(y ~ x | f * g, data=)
          --- f and g represent the optional conditioning variables
              f=cols, g=rows
          --- * represents the interaction between them (table, e.g.)
  -- 2nd arg: DATAFRAME or LIST from which the variables in the formula 
     should be looked up. If no df or list is passed, the parent frame is
     used and if no other args are passed, the default values are used
     (xyplot looks in the environment and see x and y that were previously
     generated)
  -- Extra arguments: examples:
     --- layout = c()  --> you provide vector that corresponds to the 
         display you want of figures, e.g. layout=c(2,1) == 2cols,1row
     --- strip=TRUE/FALSE: if false, strips are not drawn (default=TRUE)
- Multipanel plots are easily generated with lattice

EXAMPLE: > xyplot(Ozone~Wind,airquality)
         Lattice labels automatically axes for me. I can use some graphical
         parameters from the base package in calls to lattice functions
         e.g. pch, col

         > xyplot(Ozone~Wind | as.factor(Month), airquality, layout=c(5,1))
        -- as.factor() = displays and labels each subplot with the month's 
                       integer, and organizes it in layout=5col,1row
        -- Month is a named column in airquality df, so we had to tell R
           to treat it as a factor

- An important difference between lattice and base graphics is that,
  whereas base graphics functions plot data directly to the graphics
  device (screen, file...), lattice graphics return an object of
  class TRELLIS. They return "plot objects" that can be stored (but it
  is usually better to just save code and data). On the command line, 
  trellis objects are autoprinted so that it appears the function is
  plotting data

  > p <- xyplot(Ozone~Wind,data=airquality)     #p is a trellis object
  Now I can type p or print(p) to see the plot!
  > mynames <- names(p)
  > myfull <- TRUE for nonnull entries of p 
    I would know how to code this in python, but not sure here
  > mynames[myfull] = to see which entries are not NULL in p
  > p[["formula"]] = formula is an entry of p, so this way I see
                     the valur of the "formula" arg in p
                     -- NOTE! double square brackets + quotes

- Lattice's PANEL FUNCTIONS control what happens inside each panel of 
  the plot

  plot1.R :
  p <- xyplot(y ~ x | f, panel=function(x,y,...){
    panel.xyplot(x,y,...) ## Call the default panel function for 'xyplot'
    panel.abline(h=median(y),lty=2) ## Add horizontal line at median
  })
  print(p)
  invisible()

  p2 <- xyplot(y ~ x | f, panel=function(x,y,...){
    panel.xyplot(x,y,...) ## Call the default panel function for 'xyplot'
    panel.lmline(x,y,col=2) ## Custom panel specifies a col argument
                               so regression lines (lmline) will be red (2)
  })
  print(p)
  invisible()

  ### The panel function has 3 args: x, y and ... . This las one stands for all       other arguments (Such as graphical parameters) one might want to
      include. There are 2 lines in the panel function: each invokes a
      panel method:
      1. The first to plot the data in each panel (panel.xyplot)
      2. The second to draw a horizontal line in each panel (panel.abline)
  
- source() = causes R to accept its input from the named file
             Input is read and parsed from that file until the
             end of the file is reached
  > source(pathtofile("plot1.R"),local=TRUE)
    # I guess pathtofile has to be a function
    # FALSE (the default) corresponds to the user's workspace (the global
      environment) and TRUE to the environment from which source is called. 

- myedit() = opens editor and displays R code in it, e.g. myedit("plot2.R")

EXAMPLE
> myedit("myLabels.R")
  [miLabels.R:
   myxlab <- "Carat"
   myylab <- "Price"
   mymain <- "Diamonds are sparkly!"
> xyplot(price~carat | color*cut, diamonds, strip=FALSE, pch=20, \
    xlab=myxlab, ylab=myylab, main=mymain)
  --> output is 35 panels, one for each combination of color and cut
      The dots (pch=20) show how prices for the diamonds in each category 
      (panel) vary depending on carat
  --> without setting strip=FALSE, strip=TRUE is used by default. With 
      strip=TRUE we see that the strip function LABELS EACH PANEL

- A characteristic that does NOT apply to lattice is "you can always add to
  the plot once it is created". So in other words, you can NOT add to the plot
  once it is created.

########################################################################

7. WORKING WITH COLORS
04_ExploratoryAnalysis/Colors

- OJO! Primary colors in R = primary LIGHT colors == red,blue,green

A. grDevices PACKAGE
  -- colors() = lists 657 predefined colors
                > sample(colors(),10) --> to get 10 random colors, some of
                which are followed by numbers, indicating there are multiple
                forms of that particular color

  -- colorRamp() = takes color names as arguments and uses them as "palettes"
                   i.e., the argument colors are blended in different 
                   proportions to form new colors
                   RETURNS A FUNCTION THAT TAKES VALUES BETWEEN 0 AND 1 AS
                   ARGS. 0 AND 1 CORRESPOND TO EXTREMES OF THE COLOR PALETTE,
                   ARGUMENTS BETWEEN 0 AND 1 RETURN BLENDS OF THESE EXTREMS
                   > pal <- colorRamp(c("red","blue"))
                   > pal(0) #the max arg that pal() takes is 1
                        [,1] [,2] [,3]
                   [1,]  255    0    0
                        #col2 would be green but it will never take green 
                         because we didn't gill it in the palette when we
                         called colorRamp
                   pal() = can take more than one argument:
                           > pal(seq(0,1,len=6))
                                  [,1] [,2] [,3]
                             [1,]  255    0    0
                             [2,]  204    0   51
                             [3,]  153    0  102
                             [4,]  102    0  153
                             [5,]   51    0  204
                             [6,]    0    0  255
                           pal() creates colors using the palette we 
                           spacified when we called colorRamp

  -- colorRampPalette() = takes color names as args and uses them as palletes,
                    the same as colorRamp.
                    Takes a palette of colors and returns a function that,
                    in contrast to colorRamp, takes integer arguments 
                    (instead of numbers between 0 and 1) and returns a vector
                    of colors, each of chich is a blend of colors of
                    the original palette
                    The argument you passed to the returned function 
                    specifies the number of colors you want returned.
                    Each element of the returned vector is a 24 bit number,
                    represented as 6 hexadecimal characters, which range from
                    0 to F. This set of 6 hex characters represents the
                    intensities of red, green and blue, 2 characters/color
                    > p1 <- colorRampPalette(c("red","blue"))
                    > p1(2)
                    [1] "#FF0000" "#0000FF"
                    # Returns a 2-long vector where FF0000==red (FF is
                    hexadecimal for 255, the same value returned by pal(0)
                    The second entry 0000FF represents blue, also with 
                    intensity=255
                    OJO! The colors don't always perfectly match the colors 
                    from colorRamp but differences are minimum
                    > showMe(p1(20)) = to show display of colors: 20 cols
                                       between red and blue (included)
                                       showMe(p1(2)) would only return red
                                       and blue
                      #showMe is a function they created that takes a color
                       vector as arg (color vector is, as we know, returned
                       by p1()


                    **NOTE! to see equivalent of hex number but in decimal
                    format, type 0x__, e.g., 0xFF

- rgb = color specification function used to produce any color with red,
        green and blue proportions
        -- maxColorValue=1 (by default), so if we called rgb with values for
           red, green and blue, we would specify numbers at most 1. 
        -- maximum number of arguments rgb can have is 4: red, green, blue
           AND ALPHA --> alpha is TRUE/FALSE/numerical value: DETERMINES
           TRANSPARENCY :-) (used to clarify plots with many points)

B. RColorBrewer PACKAGE
- Contains 3 types of palettes: 
  -- SEQUENTIAL: colors ordered from light to dark
  -- DIVERGENT: neutral color=white, as you move to the ends of each palette,
                the colors increase in intensity
  -- QUALITATIVE: ~ to collections of random colors --> useful to 
                  distinguish factors in data
- colorBrewer palettes can be used in conjunction with colorRamp/Palette()
  > brewer.pal(arg1,arg2): arg1=# of colors arg2=type of palette, 
                           e.g.: cols <- brewer.pal(3,"BuGn")
                                 showMe(cols)
                                 pal <- colorRampPalette(cols)
                                 showMe(pal(20))

########################################################################

8. GGPLOT2 PART 1 (QPLOT)
04_ExploratoryAnalysis/ggplot2

- add-on package available from CRAN (https://cran.r-project.org/) via
  install.packages()
- Implementation of The Grammar of Graphics, an abstract concept invented
  by L. Wilkinson --> check http://ggplot2.org 
- Cool features:
  -- Automatically deals with spacings, text, titles
  -- Allows you to annotate (not lattice)
  -- Allows for multipanels more easily and intuitively
  -- Default mode makes many choices you but you can always customize

- Workhorse functions:
  -- qplot = basic function (quick plot): --> focus of this lesson
     --- works like the plot function in the base graphics system: 
     --- can produce many types of plots (scatter, hists,
         box and whisker...) while hiding tedious details from the user.
     --- Similar to lattice, looks for data in a df or parent environment
  -- ggplot = more advanced function
     --- can be customized for doing things qplot cannot do

A. We want to see relation of highway miles per gallon and engine 
   displacement:
   > qplot(displ,hwy,data=mpg) # arg1=x, arg2=y, arg3=dataset where ggplot2
                                 must take the variables from (like lattice)
B. Now we want to do the same plot but using different colors to 
   distinguish between the 3 factors (subsets) of different types of drive 
   in the data (mpg): front/rear/4-wheel
   > qplot(displ,hwy,data=mpg,color=drv)
   * qplot supplied a very helpful legend!!! :-D
C. Now we want to add a second GEOM (points, lines, bars) to the default 
   points. E.g. a smoothing function to produce trend lines, one for 
   each color
   > qplot(displ, hwy, data = mpg, color = drv, geom=c("point","smooth"))
   # geom takes string for a value
   # point refers to the datapoints, smooth refers to the trend lines 
     (these trend lines indicate the 95% confidence interval for the lines)

D. What does this show?: qplot(y=hwy, data = mpg, color = drv)
   Each point = one of the hwy values (indicated in y axis)
   When y is the only parameter specified (without an x) we end up with a
   plot of the y argument in the order in which they occur in the data

E. To create box and whisker plots:
   qplot (arg1, arg2, arg3, arg4)
          # arg1 = variable by which the data will be split into (drv)
          # arg2 = variable which wants to be examines (hwy)
          # arg3 = data
          # arg4 = the geom --> geom="boxplot"
                   Default of geom if only x is specified = histogram
                   Default of geom if x&y or only y is specified = scatterplot
          # arg5 = can be color, to separate different observations with 
                   different colors (e.g. by manufacturer)
    > qplot(drv, hwy, data=mpg, geom='boxplot')
    > qplot(drv, hwy, data=mpg, geom='boxplot', color=manufacturer)
      ## Still 3 regions of plot (determined by drv), each of which are 
         subdivided into several boxes depicting different manufacturers

F. Now let's plot a histogram with hwy data from the mpg dataset, but we 
   would like to distinguish between the different tupes of drive (rear, front
   of 4-wheel)
   > qplot(hwy, data=mpg, fill=drv)

G. However, some people might find this multicolor histogram hard to
   interpret, so let's use facets/panels instead of colors and make 3 subplots
     *NOTE: facets is the name for ggplot2, panels is for lattice
   > qplot(displ,hwy,data=mpg,facets=.~drv) --> scatter plot (1rowx3cols)
     #facets-arg: has the shape of rows~cols
                  e.g.: .~drv == single row X #of drv factors (3cols)
   > qplot(hwy,data=mpg,facets=drv~.,binwidth=2) --> histograms (3rowsx1col)

########################################################################

9. GGPLOT2 PART 2 (understand default components of package for customization)
04_ExploratoryAnalysis/ggplot2

- Basic components of ggplots2 plots:
  -- DATA FRAME
  -- AESTHETIC MAPPINGS: determine how data are mapped to color, size...
  -- GEOMS (geometric objects): what you see in the plot (points, lines...)
  -- FACETS: panels used in conditional plots
  -- STATS: statistical transformations that are applied to data
            e.g. binning, quantiles, smoothing...
  -- SCALES: show what coding an aesthetic map uses (e.g. male=red, female-blue)
  -- COORDINATE SYSTEM: where plots are depicted

- ggplot2 builds up plots in LAYERS (like base plotting system, contrast to
  lattice), maybe in several steps --> you can plot the data and then overlay
  a summary (e.g. regression line, smoother) and then add any metadata and
  annotations that might be needed

- Tutorial seems to be older than my version of ggplot2 so I can't continue
  at some point. Check:
  https://github.com/DataScienceSpecialization/courses/blob/master/
  04_ExploratoryAnalysis/ggplot2/ppt/ggplot2.pdf

  ## To see more details about customizing the plot and adding layer with 
     ggplot (see webpage mentioned above)
      
     -- Note that the gplot2 theme can be changed and get rid of the grey 
        background

- ggplot2 is very powerful and flexible if you learn the grammar and the
  various elements that can be tuned/modified

########################################################################

10. GGPLOT2 EXTRAS

########################################################################

11. HIERARCHICAL CLUSTERING

########################################################################

12. K MEANS CLUSTERING

########################################################################

13. DIMENSION REDUCTION

########################################################################

14. CLUSTERING EXAMPLE

########################################################################

15. CASESTUDY 

########################################################################

cool reminders
- annotate is to add to plot, if necessary
- boxplot()
- abline()
- rug()
- barplot()
- table() / names()
  # with table() I can construct tables very easily as I want, e.g.
    table(diamonds$color,diamonds$cut) sets color as rows and cut as cols
    and organizes data inside the cells :-)
- y~x 
- par() to specify multiplots/figure, margins, etc or find out set settings
  -- oma-arg of par() seems useful although don't really understand its role
- pdf(file=".pdf")/dev.copy(format,file=".format") + dev.off()
- library(datasets) + data(loaddatahere)
- xlab/ylab as arguments in plotting functions to label axes
- myedit()

"""
