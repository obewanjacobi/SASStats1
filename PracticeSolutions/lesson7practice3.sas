****************************************************************;
* Lesson 7 - Practice 3
* Using PROC LOGISTIC to Perform a Binary Logistic Regression Analysis
*
* The insurance company wants to characterize the relationship 
* between a vehicle's weight and its safety rating. The 
* stat1.safety data set contains the data about vehicle safety.
*
* a)	Use PROC LOGISTIC to fit a simple logistic regression 
*		model with Unsafe as the response variable and Weight as 
*		the predictor variable. Use the EVENT= option to model the 
*		probability of Below Average safety scores. Request profile 
*		likelihood confidence limits, an odds ratio plot, and an 
*		effect plot. Submit the code and view the results.
*
* b)	Do you reject or fail to reject the null hypothesis that 
*		all regression coefficients of the model are 0?
* 
* c)	Write the logistic regression equation.
*
* d) 	Interpret the odds ratio for Weight.
****************************************************************;

/*checking out the data*/
proc print data=stat1.safety(obs=10);
run;

/*part a*/
ods graphics on;
proc logistic data=stat1.safety plots(only)=(effect oddsratio);
   model Unsafe(event='1')=Weight / clodds=pl;
   title 'LOGISTIC MODEL (1):Unsafe=Weight';
run;

/*part b*/
* The p value is lower than our threshold of .05 (it's <.0001), so the null
* hypothesis is rejected.
*;

/*part c*/
* Logit(Unsafe) = 3.5422-1.3901*Weight
*;

/*part d*/
* The odds ratio for Weight syss tat the odds for being unsafe are 75.1%
* lower for each thousand pound increase in weight.
* The confidence interval (0.102 , 0.517) does not contain 1,which tells us
* that the odds ratio is statistically significant.
*;