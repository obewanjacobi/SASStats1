****************************************************************;
* Lesson 5 - Practice 1
* Using PROC REG to Examine Residuals
*
* Run a regression on PctBodyFat2 in the stat1.bodyfat2 data set 
* to examine residuals.
*
* a)	Use PROC REG to run a regression model of PctBodyFat2 on 
*		Abdomen, Weight, Wrist, and Forearm. Create plots of the 
*		residuals by the four regressors and by the predicted 
*		values, and a normal Q-Q plot. Submit the code and view 
*		the results.
*
* b)	Do the residual plots indicate any problems with the 
*		constant variance assumption?
*
* c)	Are there any outliers indicated by the evidence in any 
*		of the residual plots?
*
* d)	Does the Q-Q plot indicate any problems with the 
*		normality assumption?
****************************************************************;

/*checking out the data*/
proc print data=stat1.bodyfat2(obs=10);
run;

%let interval=Abdomen Weight Wrist Forearm;

/*part a*/
ods graphics on;
proc reg data=stat1.bodyfat2;
    model PctBodyFat2 = &interval;
    title 'PctBodyFat2 Model - Plots of Diagnostic Statistics';
run;
quit;

/*part b*/
* No, they don't seem to indicate any problems.
*;

/*part c*/
* All variables seem to have outliers, especially Abdomen and Weight.
*;

/*part d*/
* Nope
*;