****************************************************************;
* Lesson 7 - Practice 2
* Using PROC FREQ to Perform Tests and Measures of Association
*
* The insurance company wants to determine whether a vehicle's 
* safety score is associated with either the region in which it 
* was manufactured or the vehicle's size. The stat1.safety data 
* set contains the data about vehicle safety.
*
* a)	Use PROC FREQ to create the crosstabulation of the 
*		variables Region by Unsafe. Along with the default 
*		output, generate the expected frequencies, the chi-square 
*		test of association, and the odds ratio. To clearly identify 
*		the values of Unsafe, create and apply a temporary format. 
*		Submit the code and view the results.
*
* b)	For the cars made in Asia, what percentage had a Below 
*		Average safety score?
*
* c)	For the cars with an Average or Above safety score, 
*		what percentage was made in North America?
*
* d)	Do you see a statistically significant (at the 0.05 level) 
*		association between Region and Unsafe?
* e)	What does the odds ratio compare? What does this suggest 
*		about the difference in odds between Asian and North 
*		American cars?
*
* f)	Write another PROC FREQ step to create the crosstabulation 
*		of the variables Size and Unsafe. Along with the default 
*		output, generate the measures of ordinal association. 
*		Format the values of Unsafe. Submit the code and view 
*		the results.
*
* g)	What statistic do you use to detect an ordinal association 
*		between Size and Unsafe?
*
* h)	Do you reject or fail to reject the null hypothesis at 
*		the 0.05 level?
*
* i)	What is the strength of the ordinal association between 
*		Size and Unsafe?
*
* j)	What is the 95% confidence interval around the statistic 
*		that measures the strength of the ordinal association?
****************************************************************;

/*checking out the data*/
proc print data=stat1.safety(obs=10);
run;

/*part a*/
proc format; 
   value safefmt 0='Average or Above'
                 1='Below Average';
run;

proc freq data=stat1.safety;
   tables Region*Unsafe / expected chisq relrisk;
   format Unsafe safefmt.;
   title "Association between Unsafe and Region";
run;

/*part b*/
* 42.86%
* We can see this cause region is a row variable, so look at the row pct
* number in the "Below Average" cell. 
*;

/*part c*/
* 69.7%
*;

/*part d*/
* The p value here is .0631, higher than our desired .05, so the association
* is not statistically significant.
*;

/*part e*/
* The odds ratio compares the odds of Below Average safety for North 
* America versus Asia. The odds ratio of 0.4348 means that cars made in 
* North America have 56.52% lower odds for being unsafe than cars made 
* in Asia.
*;

/*part f*/
proc freq data=stat1.safety;
   tables Size*Unsafe / chisq measures cl;
   format Unsafe safefmt.;
   title "Association between Unsafe and Size";
run;

/*part g*/
* The Mantel-Haenszel chi-square detects an ordinal association
*;

/*part h*/
* We reject the null hyp. at the .05 level.
*;

/*part i*/
* The Spearman Correlation is -0.5425
*;

/*part j*/
* The confidence interval is (-0.6932, -0.3917)
*;