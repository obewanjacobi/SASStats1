****************************************************************;
* Lesson 7 - Practice 5
* Using PROC LOGISTIC to Perform Backward Elimination - Using 
* PROC PLM to Generate Predictions
*
* The insurance company wants to model the relationship between 
* three of a car's characteristics, weight, size, and region of 
* manufacture, and its safety rating. Run PROC LOGISTIC and use 
* backward elimination. Start with a model using only main 
* effects. The stat1.safety data set contains the data about 
* vehicle safety.
*
* a)Use PROC LOGISTIC to fit a multiple logistic regression 
*	model with Unsafe as the response variable and Weight, Size, 
*	and Region as the predictor variables.
*	1)	Use the EVENT= option to model the probability of Below 
*		Average safety scores.
*	2)	Apply the SIZEFMT. format to the variable Size.
*	3)	Specify Region and Size as classification variables and 
*		use reference cell coding. Specify Asia as the reference 
*		level for Region, and 1 (small cars) as the reference '
*		level for Size.
*	4)	Add a UNITS statement with -1 as the unit for Weight so 
*		that you can see the odds ratio for lighter cars over 
*		heavier cars.
*	5)	Add a STORE statement to save the analysis results as isSafe.
*	6)	Request any relevant plots.
*	7)	Submit the code and view the results.
*
* b)Which terms appear in the final model?
*
* c)If you compare these results with those from the previous 
*	practice (a model fit with only one variable, Region), do you 
*	think that this is a better model?
*
* d)Using the final model that was chosen by backward elimination, 
*	and using the STORE statement, generate predictive probabilities 
*	for the cars in the following DATA step:				;
/*data checkSafety;
   length Region $9.;
   input Weight Size Region $ 5-13;
   datalines;
   4 1 N America
   3 1 Asia     
   5 3 Asia     
   5 2 N America
	 ;
run;*/

****************************************************************;
ods select all;
data checkSafety;
   length Region $9.;
   input Weight Size Region $ 5-13;
   datalines;
   4 1 N America
   3 1 Asia     
   5 3 Asia     
   5 2 N America
	 ;
run;

/*checking out the data*/
proc print data=stat1.safety(obs=10);
run;

proc format; 
   value sizefmt 1='Small'
                 2='Medium'
				 3='Biggum';
run;

/*part a*/
ods graphics on;
proc logistic data=stat1.safety plots(only)=(effect oddsratio);
    class Region (param=ref ref='Asia')
          Size (param=ref ref='Small');
    model Unsafe(event='1')=Weight Region Size / clodds=pl
											     selection=backward;
	units Weight = -1;
	store isSafe;
	format Size sizefmt.;
    title 'LOGISTIC MODEL (2):Unsafe';
run;

/*part b*/
* As expected from previous practices, size is the only effect in the final
* model. 
*;

/*part c*/
* Not sure what this question is hitting at, the previous practice also
* showed size as more significant than region. Went and checked again, 
* no errors appear. 
*;

/*part d*/
proc plm restore=isSafe;
	score data=checkSafety out=scored / ILINK;
	title 'Predictions using PROC PLM';
run;

proc print data=scored;
run;

title;