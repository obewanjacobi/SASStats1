/*st107d03.sas*/
ods graphics off;
proc freq data=STAT1.ameshousing3;
    tables Fireplaces*Bonus / chisq measures cl;
    format Bonus bonusfmt.;
    title 'Ordinal Association between FIREPLACES and BONUS?';
run;

ods graphics on;

*
In this step, the TABLES statement specifies a crosstabulation table 
for Fireplaces by Bonus, as well as three options that generate 
various measures of association. The CHISQ option produces the 
Pearson chi-square, the likelihood-ratio chi-square, and the 
Mantel-Haenszel chi-square. It also produces measures of association 
based on chi-square statistics, such as the phi coefficient, the 
contingency coefficient, and Cramer's V. The MEASURES option produces 
the Spearman correlation statistic along with a few other measures of 
association. The CL option produces confidence limits for the statistics 
that the MEASURES option requests. 

Submit the code.

Review the output.

The first table is the same Fireplaces by Bonus crosstabulation table 
that was generated in the previous demonstration.

Let's look at the results of the Mantel-Haenszel chi-square test. 
Because the p-value is 0.0010, you can conclude at the 0.05 significance 
level that there is evidence of an ordinal association between Bonus 
and Fireplaces. There's a significant trend in the likelihood of being 
bonus eligible as the number of fireplaces increases.

The last table displays a variety of measures of association, including 
the Spearman correlation statistic and its 95% confidence limits. The 
Spearman correlation value of 0.2107 indicates that there’s a weak 
positive ordinal relationship between Fireplaces and Bonus. That is, as 
Fireplaces levels increase, Bonus tends to increase.

The ASE is the asymptotic standard error, and is only an appropriate 
measure of the standard error for relatively large samples.

Because the 95% confidence interval for the Spearman correlation 
statistic does not contain 0, the relationship is significant at the 0.05 
significance level. However, the confidence intervals are valid only if 
your sample size is large. A general guideline is to have a sample size 
of at least 25 for each degree of freedom in the Pearson chi-square 
statistic. Because we have a sample size of 300, our confidence intervals 
are valid.
*;