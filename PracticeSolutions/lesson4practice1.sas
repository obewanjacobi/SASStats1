****************************************************************;
* Lesson 4 - Practice 1
* Using PROC GLMSELECT to Perform Stepwise Selection
*
*	Use the stat1.bodyfat2 data set to identify a set of "best" 
*	models. Use significance-level model selection techniques.
*
* a)	With the SELECTION=STEPWISE option, use SELECT=SL in 
*		PROC GLMSELECT to identify a set of candidate models that 
*		predict PctBodyFat2 as a function of the variables Age, 
*		Weight, Height, Neck, Chest, Abdomen, Hip, Thigh, Knee, 
*		Ankle, Biceps, Forearm, and Wrist. Use the default values 
*		for SLENTRY= and SLSTAY=. Submit the code and view the results.
*
* b)	Modify the code to specify the forward selection process 
*		(FORWARD). Submit the code and view the results.
*
* c)	How many variables would result from a model using 
*		forward selection and a significance-level-for-entry 
*		criterion of 0.05, instead of the default SLENTRY= value, 
*		0.50? Modify and submit the code, and view the results.
****************************************************************;

/*Checking out the data*/
proc print data=stat1.bodyfat2(obs=20);
run;

%let interval=Age Weight Height Neck Chest Abdomen Hip Thigh Knee 
			  Ankle Biceps Forearm Wrist;

/*part a*/
ods graphics on; 
proc glmselect data=stat1.bodyfat2 plots=all;
	model PctBodyFat2  = &interval / selection=stepwise 
	details=steps select=SL showpvalues;* slstay=0.05 slentry=0.05;
	title "Stepwise Model Selection for PctBodyFat2";
run;

/*part b*/
ods graphics on; 
proc glmselect data=stat1.bodyfat2 plots=all;
	model PctBodyFat2  = &interval / selection=forward 
	details=steps select=SL showpvalues;* slstay=0.05 slentry=0.05;
	title "Forward Model Selection for PctBodyFat2";
run;

/*part c*/
ods graphics on; 
proc glmselect data=stat1.bodyfat2 plots=all;
	model PctBodyFat2  = &interval / selection=forward 
	details=steps select=SL showpvalues slentry=0.05;* slstay=0.05;
	title "Forward Model Selection for PctBodyFat2  - SL 0.05";
run;
* The number of effects in the final model is down to 5 with the intercept,
* vs the 11 from the model selected in part b.
*;