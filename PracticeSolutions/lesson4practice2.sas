****************************************************************;
* Lesson 4 - Practice 2
* Using PROC GLMSELECT to Perform Other 
* Model Selection Techniques
*
* Use the stat1.bodyfat2 data set to identify a set of "best" 
* models using other model selection techniques.
*
* a)	With the SELECTION=STEPWISE option, use SELECT=SBC in 
*		PROC GLMSELECT to identify a set of candidate models 
*		that predict PctBodyFat2 as a function of the variables 
*		Age, Weight, Height, Neck, Chest, Abdomen, Hip, Thigh, 
*		Knee, Ankle, Biceps, Forearm, and Wrist. Submit the code 
*		and view the results.
*
* b)	Modify the code to specify SELECT=AIC. Submit the code 
*		and view the results.
****************************************************************;

/*Checking out the data*/
proc print data=stat1.bodyfat2(obs=10);
run;

%let interval=Age Weight Height Neck Chest Abdomen Hip Thigh Knee 
			  Ankle Biceps Forearm Wrist;

/*part a*/
proc glmselect data=stat1.bodyfat2 plots=all;
	model PctBodyFat2 = &interval / selection=stepwise 
	details=steps select=SBC;
	title "Stepwise Model Selection for PctBodyFat2 - SBC";
run;

/*part b*/
proc glmselect data=stat1.bodyfat2 plots=all;
	model PctBodyFat2 = &interval / selection=stepwise 
	details=steps select=AIC;
	title "Stepwise Model Selection for PctBodyFat2 - AIC";
run;

title;