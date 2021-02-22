****************************************************************;
* Lesson 3 - Practice 1
* Performing a Two-Way ANOVA Using PROC GLM
*
* Data were collected to determine whether different dosage 
* levels of a drug have an effect on blood pressure for people 
* with one of three types of heart disease. The data are in the 
* stat1.drug data set.
*
* a)	Examine the data with a vertical line plot. Put BloodP 
*		on the Y axis, and DrugDose on the X axis, and then 
*		stratify by Disease.
*
* b)	What information can you obtain by looking at the data?
*
* c)	Test the hypothesis that the means are equal. Be sure to 
*		include an interaction term if the graphical analysis that 
*		you performed indicates that would be advisable.
*
* d)	What conclusions can you reach at this point?
*
* e)	To investigate the interaction effect between the two 
*		factors, include the SLICE option by manually editing 
*		the generated code or you can write the code directly.
*
* f)	Is the effect of DrugDose significant?
****************************************************************;

/*Check out the data*/
proc print data=stat1.drug;
run;

/*part a*/
proc sgplot data=stat1.drug; 
   vline DrugDose / group=Disease 
					stat=mean 
					response=BloodP 
					markers; 
run;

/*part b*/
* Drug Dose does seem to affect blood pressure but is affected differently
* for difference disease options. Disease C seemed to have the smallest 
* effect.
*;

/*part c*/
ods graphics on;
proc glm data=stat1.drug plots(only)=intplot;
   class DrugDose Disease;
   model BloodP=DrugDose*Disease;
   lsmeans DrugDose*Disease;
run;
quit;

/*part d*/
* The F test shows that there is a statistically significant difference
* across the groupings. The R-squared value tells us that %34.792 of the 
* variation in our predicted values is due to the predictor variables. 
*;

/*part e*/
ods graphics on;
proc glm data=stat1.drug plots(only)=intplot;
   class DrugDose Disease;
   model BloodP=DrugDose*Disease;
   lsmeans DrugDose*Disease / slice=Disease;
run;
quit;

/*part f*/
* Yes Drug Dose is significant for Disease A and B, but not so much C.
*;