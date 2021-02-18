*******************************************************;
* Lesson 2 - Practice 1
* Using PROC GLM to Perform a One-Way ANOVA
*
* Montana Gourmet Garlic is a company that uses organic 
* methods to grow garlic. It specializes in hardneck 
* varieties. Knowing a little about experimental methods, 
* the owners design an experiment to test whether growth 
* of the garlic is affected by the type of fertilizer. 
* They limit the experimentation to a Rocambole variety 
* named Spanish Roja, and test three organic fertilizers 
* and one chemical fertilizer (as a control). They 
* "blind" themselves to the fertilizer by using 
* containers with numbers 1 through 4. (In other words, 
* they design the experiment in such a way that they do 
* not know which fertilizer is in which container.) One 
* acre of farmland is set aside for the experiment. The 
* land is divided into 32 beds, and they randomly assign 
* fertilizers to the beds. At harvest, they calculate 
* the average weight of garlic bulbs in each of the beds. 
* The data are in the stat1.garlic data set.
*
* Consider an experiment to study four types of 
* fertilizer, labeled 1, 2, 3, and 4. One fertilizer is 
* chemical and the rest are organic. You want to see 
* whether the average weights of the garlic bulbs are 
* significantly different for plants in beds that use 
* different fertilizers.
* a) 	Test the hypothesis that the means are equal. Use 
*		PROC MEANS to generate descriptive statistics for 
*		the four groups, and use PROC SGPLOT to produce 
*		box plots of bulb weight for the four groups. 
*		Submit the code and view the results.
*
* b) 	Which fertilizer has the highest mean?
*
* c) 	Perform a one-way ANOVA using PROC GLM. Be sure 
*		to check that the assumptions of the analysis method 
*		that you choose are met. Submit the code and view the 
*		results.
*
* d)	What conclusions can you reach at this point in your 
*		analysis?
*******************************************************;

proc print data=stat1.garlic;
run;

/*part a*/
proc means data=stat1.garlic; 
   var BulbWt;
   class Fertilizer;
   title 'Descriptive Statistics of BulbWt by Fertilizer';
run;

proc sgplot data=stat1.garlic;
    vbox BulbWt / category=Fertilizer 
                  connect=mean;
    title "Bulb Weight Differences across Fertilizers";
run;

title;

/*part b*/
* Fertilizer 3 has the highest mean of 0.2424075.
*;

/*part c*/
ods graphics;

proc glm data=stat1.garlic plots=diagnostics;
    class Fertilizer;
    model BulbWt=Fertilizer;
    means Fertilizer / hovtest=levene;
    title "One-Way ANOVA with Fertilizer as Predictor";
run;
quit;
* Not sure why, but I'm receiving an error here saying the following:
* ERROR: SAS option SVGTITLE requires an option value that contains 
* a maximum of 256 character(s).
* I got this when running the demo as well, so I'm not confident of my
* answer. The worst part is that I can't find any documentation on what this
* error has to do with. 
*;


title;

/*part d*/