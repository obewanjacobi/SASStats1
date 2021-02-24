****************************************************************;
* Lesson 7 - Practice 4
* Using PROC LOGISTIC to Perform a Multiple Logistic Regression 
* Analysis with Categorical Variables
*
* The insurance company wants to model the relationship between 
* three of a car's characteristics, weight, size, and region of 
* manufacture, and its safety rating. The stat1.safety data set 
* contains the data about vehicle safety.
*
* a) Use PROC LOGISTIC to fit a multiple logistic regression 
*	 model with Unsafe as the response variable and Weight, Size, 
*	 and Region as the predictor variables.
*		1) Use the EVENT= option to model the probability of 
*		   Below Average safety scores.
*		2) Specify Region and Size as classification variables 
*		   and use reference cell coding. Specify Asia as the 
*		   reference level for Region, and 3 (large cars) as the 
*		   reference level for Size.
*		3) Request profile likelihood confidence limits, an odds 
*		   ratio plot, and the effect plot.
*		4) Submit the code and view the results.
*
* b) Do you reject or fail to reject the null hypothesis that all 
*	 regression coefficients of the model are 0?
*
* c) If you reject the global null hypothesis, then which 
*	 predictors significantly predict safety outcome?
*
* d) Interpret the odds ratio for significant predictors.
****************************************************************;

/*checking out the data*/
proc print data=stat1.safety(obs=10);
run;

/*part a*/
ods graphics on;
proc logistic data=stat1.safety plots(only)=(effect oddsratio);
    class Region (param=ref ref='Asia')
          Size (param=ref ref='3');
    model Unsafe(event='1')=Weight Region Size / clodds=pl;
    title 'LOGISTIC MODEL (2):Unsafe';
run;

/*part b*/
* The likelihood ratio test gives us a P value of <.0001, so we can reject
* the null hypothesis.
*;

/*part c*/
* Based on the ChiSq test, Size is the only significant predictor of
* the Unsafe term. 
*;

/*part d*/
* The odds ratio for significant predictors shows that Size 1 vs 3 is the
* only significant predictor for the value of Unsafe. This can be seen easily
* via the Odds ratio confidence limit plot. 
*;