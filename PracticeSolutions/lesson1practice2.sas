*******************************************************;
* Lesson 1 - Practice 2
* Using PROC TTEST to Compare Groups
* Elli Sagerman, a Masters of Education candidate in 
* German Education at the University of North Carolina 
* at Chapel Hill in 2000, collected data for a study. 
* She looked at the effectiveness of a new type of 
* foreign language teaching technique on grammar 
* skills. She selected 30 students to receive tutoring. 
* Fifteen received the new type of training during the 
* tutorials and 15 received standard tutoring. Two 
* students moved from the district before completing 
* the study. Scores on a standardized German grammar 
* test were recorded immediately before the 12-week 
* tutorials and again 12 weeks later at the end of the 
* trial. Sagerman wanted to see the effect of the new 
* technique on grammar skills.
* 
* A)	Using PROC TTEST, analyze the stat1.german data 
*		set. Assess whether the treatment group 
*		improved more than the control group.
* B) 	Do the two groups seem to be approximately 
* 		normally distributed?
* C) 	Do the two groups have approximately equal 
*		variances?
* D) 	Does the new teaching technique seem to result 
*		in significantly different scores compared with 
*		the standard technique?
*******************************************************;

/*Pregame: Let's look at the data:*/
proc print data=stat1.german;
run;

* First things to note, for this project, the main things we will need
* are the change in each student's score (labelled Change), and the group
* that they were a part of (Group - Treatment vs Control). For this project
* we are ignoring the gender aspect of the data, though I'm sure that would
* be interesting to study as well. 
*;

/*Part A*/

ods graphics;

proc ttest data=stat1.german plots(shownull)=interval;
    class Group;
    var Change;
    title "Two-Sample t-test Comparing German Test and Control Groups";
run;

/*Part B*/
* Sort of, while the histogram for Treatment does not appear very normal,
* it's kernel density plot does line up relatively well to the ideal normal
* distribution. This ugliness is likely just due to our lack of data though.
*;

/*Part C*/
* The P value for the quality of variance test is above our threshold of
* 0.05. Thus we cannot reject the null hypothesis, and we cannot reject that
* the variances are equal. So it is possible, yes. 
*;

/*Part D*/
* When looking at the p value for the Pooled t-test method (since our
* variances have the possibility of being equal), the p value is quite a bit
* higher than our threshold of 0.05. Thus we cannot reject the null
* hypothesis, and the difference between the means is not statistically 
* significantly diffeent. So we do not have strong enough evidence to say 
* that the new method is better than the old method.
*;

title;