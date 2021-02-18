****************************************************************;
* Lesson 2 - Practice 2
* Using PROC GLM to Perform Post Hoc Pairwise Comparisons
*
*Consider the analysis of the garlic data set. In the previous 
* exercise, you used PROC GLM to perform one-way ANOVA, and 
* found that there was a statistically significant difference 
* among mean garlic bulb weights for the different fertilizers. 
* Now, perform a post hoc test to look at the individual 
* differences among means.
*
* a)	Use PROC GLM to conduct pairwise comparisons with an 
*		experimentwise error rate of a=0.05. (Use the Tukey 
*		adjustment.) Submit the code and view the results.
*
* b)	Which types of fertilizer are significantly different?
*
* c)	Use level 4 (the chemical fertilizer) as the control 
*		group and perform a Dunnett's comparison with the organic 
*		fertilizers to see whether they affected the average 
*		weights of garlic differently from the control fertilizer.
*
* d)	Which types of fertilizer are significantly different?
*
* e)	Perform unadjusted tests of all pairwise comparisons 
*		to see what would happen if the multi-test adjustments 
*		were not made.
*
* f)	How do the results compare to what you saw in the Tukey 
*		adjusted tests?
****************************************************************;

proc print data=stat1.garlic;
run;

/*part a*/
ods graphics;

ods select lsmeans diff diffplot controlplot;
proc glm data=stat1.garlic 
         plots(only)=(diffplot(center) controlplot);
   class Fertilizer;
   model BulbWt=Fertilizer;
   lsmeans Fertilizer / pdiff=all adjust=tukey;
   title "Post Hoc Pairwise Tukey Comparisons";
run;
quit;

title;

/*part b*/
* Fertilizers 3 and 1 are both significantly different from fertilizer 4.
*;

/*part c*/
ods graphics;

ods select lsmeans diff diffplot controlplot;
proc glm data=stat1.garlic 
         plots(only)=(diffplot(center) controlplot);
   class Fertilizer;
   model BulbWt=Fertilizer;
   lsmeans Fertilizer / pdiff=control('4') adjust=dunnett;
   title "Post Hoc Pairwise Dunnett Comparisons to Fert. 4";
run;
quit;

title;

/*part d*/
* The Dunnett method shows the same results but with slightly different
* p values.
*;

/*part e*/
ods graphics;

ods select lsmeans diff diffplot;
proc glm data=stat1.garlic 
         plots(only)=(diffplot(center));
   class Fertilizer;
   model BulbWt=Fertilizer;
   lsmeans Fertilizer / pdiff=all adjust=t;
   title "Post Hoc Pairwise Comparison, Unadjusted";
run;
quit;

title;
* got warnings about making a control plot, so I removed it from the code;

/*part f*/
* In this example we have one more statistically different pair, being 
* fertilizer 2 and 3. The p values are also all lower here compared to the 
* Tukey method, which we expected. 
*;