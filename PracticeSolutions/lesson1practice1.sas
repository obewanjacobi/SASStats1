*******************************************************;
* Lesson 1 - Practice 1
* Using PROC TTEST to Perform a One-Sample t Test
*
* The data in stat1.normtemp come from an article in 
* the Journal of Statistics Education by Dr. Allen 
* L. Shoemaker from the Psychology Department at 
* Calvin College. The data are based on an article 
* in a 1992 edition of JAMA (Journal of the American 
* Medical Association). The notion that the true 
* mean body temperature is 98.6 is questioned. There 
* are 65 males and 65 females. There is also some 
* doubt about whether mean body temperatures for 
* women are the same as for men.
*
*  A)	Look at the distribution of the continuous 
* 		variables in the stat1.normtemp data set.
*		Use PROC UNIVARIATE to produce histograms 
*		and insets with means, standard deviations, 
*		and sample size.
*
*  B)	What are the means and standard deviations 
*		for each continuous variable?
*
*  C)	Perform a one-sample t test to determine 
*		whether the mean of body temperatures is 98.6. 
*		Produce a confidence interval plot of BodyTemp. 
*		Use the value 98.6 as a reference.
*
*  D)	What is the value of the t statistic and the 
*		corresponding p-value?
*
*  E)	Do you reject or fail to reject the null 
*		hypothesis at the 0.05 level that the average 
*		temperature is 98.6 degrees?
*******************************************************;

/*Pregame: Let's look at the data:*/
proc print data=stat1.normtemp;
run;

* So ID is kinda useless here, it directly reflects our observation number.
* We can ignore if for the time being. BodyTemp and HeartRate are continuous
* variables, and Gender is categorical. So we will organize them as such.;

%let interval=BodyTemp HeartRate;
%let categorical=Gender;

/*Part A*/

* since our variables are already organized, we can just reuse the code from
* the 1st demonstration.;
ods graphics;
ods select histogram;
proc univariate data=stat1.normtemp noprint;
    var &interval;
    histogram &interval / normal kernel;
    inset n mean std / position=ne;
    title "Interval Variable Distribution Analysis";
run;

/*Part B*/
* The mean for BodyTemp is 98.24923 and the sd is 0.733183.
* The mean for HeartRate is 73.76154 and the sd is 7.062077.
* These values can be seen in our nice little histograms.
*;

/*Part C*/

proc ttest data=stat1.normtemp 
           plots(shownull)=interval
           H0=98.6;
    var BodyTemp;
    title "One-Sample t-test testing whether mean BodyTemp=98.6";
run;

/*Part D*/
* We got a t value of -5.45 and a P vale of <.0001.
*;

/*Part E*/
* Yes, given this t test we can feasibly reject the null hypothesis.
*;

title;