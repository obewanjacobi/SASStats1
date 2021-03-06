/*st106s01.sas*/

%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area 
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces 
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC 
         Masonry_Veneer Lot_Shape_2 Central_Air;


/*In this example, the data set ameshousing3 is divided into */
/*training and validation using the PARTITION statement, */
/*along with the SEED= option in the PROC GLMSELECT statement.*/
proc glmselect data=STAT1.ameshousing3
               plots=all 
               seed=8675309;
    class &categorical / param=ref ref=first;
    model SalePrice=&categorical &interval / 
               selection=stepwise
               (select=aic 
               choose=validate) hierarchy=single;
    partition fraction(validate=0.3333);
    title "Selecting the Best Model using Honest Assessment";
run;

