****************************************************************;
* Lesson 6 - Practice 1
* Building a Predictive Model Using PROC GLMSELECT
*
* Use the ameshousing3 data set to build a model that predicts 
* the sale prices of homes in Ames, Iowa, that are 1500 square 
* feet or below, based on various home characteristics.
*
* a) 	Write a PROC GLMSELECT step that predicts the values 
*		of SalePrice. Partition the stat1.ameshousing3 data set 
*		into a training data set of approximately 2/3 and a 
*		validation data set of approximately 1/3. Specify the 
*		seed 8675309. Define the Interval and Categorical macro 
*		variables as shown below, and use them to specify the 
*		inputs. Use stepwise regression as the selection method, 
*		Akaike's information criterion (AIC) to add and or 
*		remove effects, and average squared error for the 
*		validation data to select the best model. Add the 
*		REF=FIRST option in the CLASS statement. Submit the 
*		code and examine the results.
*
* b) 	Which model did PROC GLMSELECT choose?
*
* c)	Resubmit the PROC GLMSELECT step. Do not make any 
*		changes to it. Does it produce the same results as 
*		before?
*
* d) 	In the PROC GLMSELECT statement, change the value of 
*		SEED= and submit the modified code. Does it produce the 
*		same results as before?
****************************************************************;

/*checking out the data*/
proc print data=stat1.ameshousing3(obs=10);
run;

* this part was given to us in the project;
%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area 
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces 
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC 
         Masonry_Veneer Lot_Shape_2 Central_Air;

/*part a*/
ods graphics;

proc glmselect data=stat1.ameshousing3
               plots=all 
			   seed=8675309;
    class &categorical / param=glm ref=first;
    model SalePrice=&categorical &interval / 
               selection=stepwise
               select=aic 
               choose=validate
			   showpvalues;
	partition fraction(validate = .333333); *SAS won't let us put in 1/3;
    store out=STAT1.amesstore;				*which is stupid.;
    title "Selecting the Best Model using Honest Assessment";
run;

/*part b*/
* PROC GLMSELECT chose the model that uses the intercept, House_Style2,
* Overall_Qual2, Overall_Cond2, Fireplaces, Heating_QC, Gr_Liv_Area, 
* Basement_Area, Garage_Area, Deck_Porch_Area, and Age_Sold. This was the
* model at step 10. 
*;

/*part c*/
* It's the same because we set the seed for the model.
*;

/*part d*/
* I'm not gonna do this, it will be different if you change the seed (most
* likely).
*;

title;

