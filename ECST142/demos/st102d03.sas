/*st102d03.sas*/
proc print data=stat1.ameshousing3;
run;



ods graphics;

ods select lsmeans diff diffplot controlplot;
proc glm data=STAT1.ameshousing3 
         plots(only)=(diffplot(center) controlplot);
    class Heating_QC;
    model SalePrice=Heating_QC;
    lsmeans Heating_QC / pdiff=all 
                         adjust=tukey;
    lsmeans Heating_QC / pdiff=control('TA') /*They got this wrong in the*/
                         adjust=dunnett; 	 /*code they supplied to us...*/
    format Heating_QC $Heating_QC.;
    title "Post-Hoc Analysis of ANOVA - Heating Quality as Predictor";
run;
quit;

title;

* In the dunnett test, everything is compared to the 'TA' type of heating,
* otherwise known as "average/typical" in the course videos. Cool of them
* to label it wrong. 

* But the point of the tukey is to compare all means to each other, whereas
* the dunnet can be more specific and compare all means to one single 
* variable mean.

* So to explain these plots, the first one gives us lines of the confidence
* interval of the differences of the means. The means are not statistically
* different if the lines cross the diagonal "0" line, and those lines are 
* made red to show that. The 2nd plot using the dunnett method shows the 
* 95% confidence interval surrounding the mean of the variable you would like
* to test and compare against, in our case the "TA" heating value. If the
* mean difference line goes outside the shaded area, then the means are 
* statistically different. If the line is inside the shaded area, they are
* not. So in this example, "Gd" heating quality is not statistically 
* different from "TA" heating quality and we can't even see the line for it.
*;



