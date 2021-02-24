****************************************************************;
* Lesson 7 - Practice 1
* Using PROC FREQ to Examine Distributions
*
* An insurance company wants to relate the safety of vehicles 
* to several other variables. A score was given to each vehicle 
* model, using the frequency of insurance claims as a basis. 
* The stat1.safety data set contains the data about vehicle 
* safety.
*
* a)	Use PROC FREQ to create one-way frequency tables for 
*		the categorical variables Unsafe, Type, Region, and 
*		Size. Submit the code and view the results.
*
* b)	What is the measurement scale of each of the four 
*		variables?
*
* c)	Do the variables Unsafe, Type, Region, and Size have any 
*		unusual values that warrant further investigation?
****************************************************************;

/*checking out the data*/
proc print data=stat1.safety(obs=10);
run;

/*part a*/
proc freq data=stat1.safety;
    tables Unsafe Type Region Size /
    plots(only)=freqplot(scale=percent);
	title "Safety Frequencies";
run;

/*part b*/
* I wasn't quite sure what this question meant, but after looking at the 
* solutions it made sense. Unsafe is binary, Type and Region are nominal,
* size is ordinal, and weight is a continuous variable. This is something we
* would normally be aware of though as soon as we start a problem. 
*;

/*part c*/
* no, it doesn't seem so;

title;