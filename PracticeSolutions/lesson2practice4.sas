****************************************************************;
* Lesson 2 - Practice 2
* Using PROC REG to Fit a Simple Linear Regression Model
*
* Using the bodyfat2 data set, perform a simple linear regression 
* model.
*
* a)	Perform a simple linear regression model with 
* 		PctBodyFat2 as the response variable and Weight as the 
*		predictor.
*
* b)	What is the value of the F statistic and the associated 
*		p-value? How would you interpret this in connection with 
*		the null hypothesis?
*
* c)	Write the predicted regression equation.
*
* d)	What is the value of R-square? How would you interpret 
*		this?
****************************************************************;

/*Check out the data*/
proc print data=stat1.bodyfat2;
run;

/*part a*/
ods graphics;

proc reg data=stat1.bodyfat2;
    model PctBodyFat2=Weight;
    title "Predicting Body Fat Percentage by Weight";
run;
quit;

title;

/*part b*/
* F Value is 150.03 and p value is <.0001. Thus we can reject the hypothesis
* that there is no relationship between weight and percent body fat. 
*;

/*part c*/
* PctBodyFat2 = -12.05158 + 0.17439 * Weight
*;

/*part d*/
* R-squared is 0.3751, so 37% of he variability in Percent Body fat can be 
* explained by the weight variable. 
*;