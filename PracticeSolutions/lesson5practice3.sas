****************************************************************;
* Lesson 5 - Practice 3
* Using PROC REG to Assess Collinearity
*
* Run a regression of PctBodyFat2 on all the other numeric 
* variables in the data set stat1.bodyfat2.
*
* a)	Write a PROC REG step to determine whether a collinearity 
*		problem exists in your model. Submit the code and view the 
*		results.
*
* b)	If there is a collinearity problem, what would you like 
*		to do about it? Will you remove any variables? Why or 
*		why not?
****************************************************************;

/*checking out the data*/
proc print data=stat1.bodyfat2(obs=10);
run;

%let interval=Age Weight Height Neck Chest Abdomen Hip Thigh
              Knee Ankle Biceps Forearm Wrist;

/*part a*/
proc reg data=stat1.bodyfat2;
    model PctBodyFat2 = &interval / vif;
    title 'Collinearity Diagnostics';
run;
quit;

/*part b*/

%let interval=Age Height Neck Chest Abdomen Hip Thigh
              Knee Ankle Biceps Forearm Wrist;

proc reg data=stat1.bodyfat2;
    model PctBodyFat2 = &interval / vif;
    title 'Collinearity Diagnostics - Weight Removed';
run;
quit;

* The answer is not so easy. Weight is collinear with some of the other 
* variables, but as you saw before in your model-building process, Weight 
* is a relatively significant predictor in the "best" models. A 
* subject-matter expert should determine the answer. If you want to remove 
* Weight, simply run that model again without that variable.
*;