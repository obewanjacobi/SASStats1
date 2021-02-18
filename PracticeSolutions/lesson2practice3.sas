****************************************************************;
* Lesson 2 - Practice 2
* Using PROC CORR to Describe the Relationship between Continuous Variables
*
* Prompt in pdf in this directory because it was really long.
****************************************************************;

/*Check out the data*/
proc print data=stat1.bodyfat2;
run;

/*part a*/
%let interval = Age Weight Height Neck Chest Abdomen Hip 
				Thigh Knee Ankle Biceps Forearm Wrist;

ods graphics / reset=all imagemap;
proc corr data=stat1.bodyfat2 rank
          plots(only)=scatter(nvar=all ellipse=none);
   var &interval;
   with PctBodyFat2;
   id Case;
   title "Correlations and Scatter Plots with Percent Body Fat";
run;


%let interval=Biceps Forearm Wrist;

ods graphics / reset=all imagemap;
proc corr data=stat1.bodyfat2 rank
          plots(only)=scatter(nvar=all ellipse=none);
   var &interval;
   with PctBodyFat2;
   id Case;
   title "Correlations and Scatter Plots with Percent Body Fat";
run;

title;

/*part b*/
* Yes, for all variables except height, age, and ankle. Otherwise trends
* seem to show.
*;

/*part c*/
* The ankle data definitely shows outliers, as well as some for biceps,
* thigh, hip, abdomen, neck, and weight.
*;

/*part d*/
* Abdomen;

/*part e*/
* p < .0001;

/*part f*/
ods graphics off;
%let interval = Age Weight Height Neck Chest Abdomen Hip 
				Thigh Knee Ankle Biceps Forearm Wrist;

proc corr data=stat1.bodyfat2 
          best=5
          out=pearson;
   var &interval;
   title "Correlations of Predictors";
run;

/*part g*/
* Yes, quite a few. Weight correlates well to all variables, and correlations
* for hip, thigh, and knee seem to be very high.
*;