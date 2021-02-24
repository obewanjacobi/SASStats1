****************************************************************;
* Lesson 6 - Practice 2
* Scoring Using the SCORE Statement in PROC GLMSELECT
*
* You want to re-create the model that was built in the previous 
* practice (based on stat1.ameshousing3), create an item store, 
* and then use the item store to score the new cases in 
* stat1.ameshousing4. You'll score the data in two ways (using 
* PROC GLMSELECT and PROC PLM) and compare the results.
*
* 1)	Open the solution program from the previous practice, 
*		st106s01.sas. There is no need to examine the results, 
*		so make the following changes to the code:
*		a)	Remove the PLOTS= option.
*		b)	Add the NOPRINT option to the PROC GLMSELECT 
*			statement.
*		c)	Remove the TITLE statement
*
* 2)	In the PROC GLMSELECT step,
*		a)	Add a STORE statement to create an item store named 
*			store1, and a SCORE statement to score the data in 
*			stat1.ameshousing4.
*		b)	Add a PROC PLM step that uses the item store, store1, 
*			to score the data in stat1.ameshousing4.
*			Note: Be sure to use different names for the two 
*			scored data sets.
*		c)	Add a PROC COMPARE step to compare the scoring 
*			results from PROC GLMSELECT and PROC PLM.
*		d)	Submit the code and examine the results.
*
* 3)	Does the PROC COMPARE output indicate any differences 
*		between the predictions produced by the two scoring methods?
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

/*part 1-2*/
ods graphics;

proc glmselect data=stat1.ameshousing3
			   noprint 
			   seed=8675309;
    class &categorical / param=glm ref=first;
    model SalePrice=&categorical &interval / 
               selection=stepwise
               select=aic 
               choose=validate
			   showpvalues;
	partition fraction(validate = .333333); 
	score data=stat1.ameshousing4 out=score1;
	store out=store1;		

proc plm restore=store1;
    score data=STAT1.ameshousing4 out=scored;
run;	

proc compare base=score1 compare=scored criterion=0.0001;
    var P_SalePrice;
    with Predicted;
run;

/*part 3*/
* The two scoring methods seem to give the same predictions.
*;
