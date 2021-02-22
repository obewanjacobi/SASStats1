****************************************************************;
* Lesson 5 - Practice 2
* Using PROC REG to Generate Potential Outliers
*
* Generate statistics for potential outliers in the 
* stat1.bodyfat2 data set. Write this data to an output data set, 
* and print your results.
*
* a)	Use PROC REG to run a regression model of PctBodyFat2 on 
*		Abdomen, Weight, Wrist, and Forearm. Create plots to 
*		identify potential influential observations that are 
*		based on the suggested cutoff values. Submit the code 
*		and view the results.
* b) 	Write the residuals output to a data set named 
*		influential, subset the data to select only observations 
*		that are potentially influential outliers, and print 
*		your results. Submit the code and view the results.
****************************************************************;

/*checking out the data*/
proc print data=stat1.bodyfat2(obs=10);
run;

%let interval=Abdomen Weight Wrist Forearm;

/*part a*/
ods graphics on;
ods output RSTUDENTBYPREDICTED=Rstud 
           COOKSDPLOT=Cook
           DFFITSPLOT=Dffits 
           DFBETASPANEL=Dfbs;
proc reg data=stat1.bodyfat2 
         plots(only label)=
              (RSTUDENTBYPREDICTED 
               COOKSD 
               DFFITS 
               DFBETAS);
    model PctBodyFat2  = &interval; 
    title 'Forward Model - Plots of Diagnostic Statistics';
run;
quit;

/*part b*/
data influential;
/*  Merge datasets from above.*/
    merge Rstud
          Cook 
          Dffits
		  Dfbs;
    by observation;

/*  Flag observations that have exceeded at least one cutpoint;*/
    if (ABS(Rstudent)>3) or (Cooksdlabel ne ' ') or Dffitsout then flag=1;
    array dfbetas{*} _dfbetasout: ;
    do i=2 to dim(dfbetas);
         if dfbetas{i} then flag=1;
    end;

/*  Set to missing values of influence statistics for those*/
/*  that have not exceeded cutpoints;*/
    if ABS(Rstudent)<=3 then RStudent=.;
    if Cooksdlabel eq ' ' then CooksD=.;

/*  Subset only observations that have been flagged.*/
    if flag=1;
    drop i flag;
run;

title;
proc print data=influential;
    id observation;
    var Rstudent CooksD Dffitsout _dfbetasout:; 
run;