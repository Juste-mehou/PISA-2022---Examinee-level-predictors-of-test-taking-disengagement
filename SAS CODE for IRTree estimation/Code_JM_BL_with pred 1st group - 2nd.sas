ods pdf file="C:\Users\mehoujm\OneDrive - James Madison University\My project\Predictors analysis\output.pdf";
ods html close;
libname out "C:\Users\mehoujm\OneDrive - James Madison University\My project\Predictors analysis";
proc import out = dataset
  datafile= "C:\Users\mehoujm\OneDrive - James Madison University\My project\Predictors analysis\pisa_usa_cog_predictors.csv"
  replace dbms=csv;
  guessingrows=max;
  Getnames=yes;
run;

%let n_RGs = 115; * Number of Rapid guess variables (total);
%let n_dichotomous = 105; * Number of dichotomous item responses;
%let n_polytomous = 10; *Number of polytomous item responses;

***Brian set missing to 9;
data pisa_nomiss;
	set dataset;
	array all{*} _numeric_;
	do j = 1 to dim(all);
		if all[j]=. then all[j]=9;
	end;
	drop j;
run;

proc mcmc 
	data= pisa_nomiss /*Brian changed to nomiss*/
	outpost = out.data_post
	nmc= 150000 /*As seen in Stone & Zhu*/
	nbi= 10000 /*As seen in Stone & Zhu*/
	thin = 5
	diagnostics= all /*Gweke and ESS were not populating as options*/
	plots= (trace autocorr)
	DIC
	maxtune=100
	nthreads=4
		;***Brian removed missing;

	*stage 1 items (RGs);
	array b1_[&n_RGs];  * array to reference array to reference treshold parameter;
	array RG[&n_RGs] RG1 - RG115;  * array to reference Rapid guessing responses;

	*stage 2 items;
		*dichotomous items;
		array b2_[&n_dichotomous]; * array to reference threshold parameter;
		array a2_[&n_dichotomous]; * array to reference slope parameter;
		array c2_[&n_dichotomous]; * array to reference guessing parameter;

		array I[&n_RGs] I1 - I115 ; * array to reference dichotomous item responses (I1 - I105) and polytomous items responses (I106 - I115 );
		
		*Polytomous items;
		array b_stp1_[&n_polytomous] b_stp1_106 - b_stp1_115; * array to reference threshold parameter step 1;
		array b_stp2_[&n_polytomous] b_stp2_106 - b_stp2_115; * array to reference threshold parameter step 2;
		array ap_2_[&n_polytomous]   ap_2_106 -  ap_2_115;  * array to reference slope parameter;

		



	* Parms initiation statements for RG (1ST STAGE) threshold parameter;

	parms b1_1 0;					parms b1_2 0; 					parms b1_3 0;
	parms b1_4 0;					parms b1_5 0;					parms b1_6 0;
	parms b1_7 0;					parms b1_8 0;					parms b1_9 0;
	parms b1_10 0;					parms b1_11 0;					parms b1_12 0;
	parms b1_13 0;					parms b1_14 0;					parms b1_15 0;
	parms b1_16 0;					parms b1_17 0;					parms b1_18 0;
	parms b1_19 0;					parms b1_20 0;					parms b1_21 0;
	parms b1_22 0;					parms b1_23 0;					parms b1_24 0;
	parms b1_25 0;					parms b1_26 0;					parms b1_27 0;
	parms b1_28 0;					parms b1_29 0;					parms b1_30 0;
	parms b1_31 0;					parms b1_32 0;					parms b1_33 0;					
	parms b1_34 0;					parms b1_35 0;					parms b1_36 0;					
	parms b1_37 0;					parms b1_38 0;					parms b1_39 0;					
	parms b1_40 0;					parms b1_41 0;					parms b1_42 0;					
	parms b1_43 0;					parms b1_44 0;					parms b1_45 0;					
	parms b1_46 0;					parms b1_47 0;					parms b1_48 0;					
	parms b1_49 0;					parms b1_50 0;					parms b1_51 0;					
	parms b1_52 0;					parms b1_53 0;					parms b1_54 0;					
	parms b1_55 0;					parms b1_56 0;					parms b1_57 0;					
	parms b1_58 0;					parms b1_59 0;					parms b1_60 0;
	parms b1_61 0;					parms b1_62 0;					parms b1_63 0;					
	parms b1_64 0;					parms b1_65 0;					parms b1_66 0;					
	parms b1_67 0;					parms b1_68 0;					parms b1_69 0;					
	parms b1_70 0;					parms b1_71 0;					parms b1_72 0;					
	parms b1_73 0;					parms b1_74 0;					parms b1_75 0;					
	parms b1_76 0;					parms b1_77 0;					parms b1_78 0;
	parms b1_79 0;					parms b1_80 0;					parms b1_81 0;
	parms b1_82 0;					parms b1_83 0;					parms b1_84 0;
	parms b1_85 0;					parms b1_86 0;					parms b1_87 0;
	parms b1_88 0;					parms b1_89 0;					parms b1_90 0;
	parms b1_91 0;					parms b1_92 0;					parms b1_93 0;
	parms b1_94 0;					parms b1_95 0;					parms b1_96 0;
	parms b1_97 0;					parms b1_98 0;					parms b1_99 0;
	parms b1_100 0;					parms b1_101 0;					parms b1_102 0;
	parms b1_103 0;					parms b1_104 0;					parms b1_105 0;
	parms b1_106 0;					parms b1_107 0;					parms b1_108 0;
	parms b1_109 0;					parms b1_110 0;					parms b1_111 0;
	parms b1_112 0;					parms b1_113 0;					parms b1_114 0;
	parms b1_115 0;
	* Parms initiation statement for RG (1ST STAGE) slope parameter;
	parms a1 1; *(because it is a 1PL );

	*parms initiation statement for predictors coefficients;
		*1st group;
		parms eta0 0;  *intercept;
		parms eta1 0;  *Female;
		parms eta2 0;  *LANG_of_test;
		parms eta3 0;  *ESCS ;
		*2nd group;


   * Parms initiation statements for dichotomous items (2nd STAGE);

	parms b2_1 0 a2_1 1 c2_1 .25;      	parms b2_2 0 a2_2 1 c2_2 .25;   	parms b2_3 0 a2_3 1 c2_3 .25;
	parms b2_4 0 a2_4 1 c2_4 .25;	    parms b2_5 0 a2_5 1 c2_5 .25;	    parms b2_6 0 a2_6 1 c2_6 .25;
	parms b2_7 0 a2_7 1 c2_7 .25;	    parms b2_8 0 a2_8 1 c2_8 .25;   	parms b2_9 0 a2_9 1 c2_9 .25;
	parms b2_10 0 a2_10 1 c2_10 .25;	parms b2_11 0 a2_11 1 c2_11 .25;	parms b2_12 0 a2_12 1 c2_12 .25;
	parms b2_13 0 a2_13 1 c2_13 .25;	parms b2_14 0 a2_14 1 c2_14 .25;	parms b2_15 0 a2_15 1 c2_15 .25;
	parms b2_16 0 a2_16 1 c2_16 .25;	parms b2_17 0 a2_17 1 c2_17 .25;	parms b2_18 0 a2_18 1 c2_18 .25;
	parms b2_19 0 a2_19 1 c2_19 .25;	parms b2_20 0 a2_20 1 c2_20 .25;	parms b2_21 0 a2_21 1 c2_21 .25;
	parms b2_22 0 a2_22 1 c2_22 .25;	parms b2_23 0 a2_23 1 c2_23 .25;	parms b2_24 0 a2_24 1 c2_24 .25;
	parms b2_25 0 a2_25 1 c2_25 .25;	parms b2_26 0 a2_26 1 c2_26 .25;	parms b2_27 0 a2_27 1 c2_27 .25;
	parms b2_28 0 a2_28 1 c2_28 .25;	parms b2_29 0 a2_29 1 c2_29 .25;	parms b2_30 0 a2_30 1 c2_30 .25;
	parms b2_31 0 a2_31 1 c2_31 .25;	parms b2_32 0 a2_32 1 c2_32 .25;	parms b2_33 0 a2_33 1 c2_33 .25;
	parms b2_34 0 a2_34 1 c2_34 .25;	parms b2_35 0 a2_35 1 c2_35 .25;	parms b2_36 0 a2_36 1 c2_36 .25;
	parms b2_37 0 a2_37 1 c2_37 .25;	parms b2_38 0 a2_38 1 c2_38 .25;	parms b2_39 0 a2_39 1 c2_39 .25;
	parms b2_40 0 a2_40 1 c2_40 .25;	parms b2_41 0 a2_41 1 c2_41 .25;	parms b2_42 0 a2_42 1 c2_42 .25;
	parms b2_43 0 a2_43 1 c2_43 .25;	parms b2_44 0 a2_44 1 c2_44 .25;	parms b2_45 0 a2_45 1 c2_45 .25;
	parms b2_46 0 a2_46 1 c2_46 .25;	parms b2_47 0 a2_47 1 c2_47 .25;	parms b2_48 0 a2_48 1 c2_48 .25;
	parms b2_49 0 a2_49 1 c2_49 .25;	parms b2_50 0 a2_50 1 c2_50 .25;	parms b2_51 0 a2_51 1 c2_51 .25;
	parms b2_52 0 a2_52 1 c2_52 .25;	parms b2_53 0 a2_53 1 c2_53 .25;	parms b2_54 0 a2_54 1 c2_54 .25;
	parms b2_55 0 a2_55 1 c2_55 .25;	parms b2_56 0 a2_56 1 c2_56 .25;	parms b2_57 0 a2_57 1 c2_57 .25;
	parms b2_58 0 a2_58 1 c2_58 .25;	parms b2_59 0 a2_59 1 c2_59 .25;	parms b2_60 0 a2_60 1 c2_60 .25;
	parms b2_61 0 a2_61 1 c2_61 .25;	parms b2_62 0 a2_62 1 c2_62 .25;	parms b2_63 0 a2_63 1 c2_63 .25;
	parms b2_64 0 a2_64 1 c2_64 .25;	parms b2_65 0 a2_65 1 c2_65 .25;	parms b2_66 0 a2_66 1 c2_66 .25;
	parms b2_67 0 a2_67 1 c2_67 .25;	parms b2_68 0 a2_68 1 c2_68 .25;	parms b2_69 0 a2_69 1 c2_69 .25;
	parms b2_70 0 a2_70 1 c2_70 .25;	parms b2_71 0 a2_71 1 c2_71 .25;	parms b2_72 0 a2_72 1 c2_72 .25;
	parms b2_73 0 a2_73 1 c2_73 .25;	parms b2_74 0 a2_74 1 c2_74 .25;	parms b2_75 0 a2_75 1 c2_75 .25;
	parms b2_76 0 a2_76 1 c2_76 .25;	parms b2_77 0 a2_77 1 c2_77 .25;	parms b2_78 0 a2_78 1 c2_78 .25;
	parms b2_79 0 a2_79 1 c2_79 .25;	parms b2_80 0 a2_80 1 c2_80 .25;	parms b2_81 0 a2_81 1 c2_81 .25;
	parms b2_82 0 a2_82 1 c2_82 .25;	parms b2_83 0 a2_83 1 c2_83 .25;	parms b2_84 0 a2_84 1 c2_84 .25;
	parms b2_85 0 a2_85 1 c2_85 .25;	parms b2_86 0 a2_86 1 c2_86 .25;	parms b2_87 0 a2_87 1 c2_87 .25;
	parms b2_88 0 a2_88 1 c2_88 .25;	parms b2_89 0 a2_89 1 c2_89 .25;	parms b2_90 0 a2_90 1 c2_90 .25;
	parms b2_91 0 a2_91 1 c2_91 .25;	parms b2_92 0 a2_92 1 c2_92 .25;	parms b2_93 0 a2_93 1 c2_93 .25;
	parms b2_94 0 a2_94 1 c2_94 .25;	parms b2_95 0 a2_95 1 c2_95 .25;	parms b2_96 0 a2_96 1 c2_96 .25;
	parms b2_97 0 a2_97 1 c2_97 .25;	parms b2_98 0 a2_98 1 c2_98 .25;	parms b2_99 0 a2_99 1 c2_99 .25;
	parms b2_100 0 a2_100 1 c2_100 .25;	parms b2_101 0 a2_101 1 c2_101 .25;	parms b2_102 0 a2_102 1 c2_102 .25;
	parms b2_103 0 a2_103 1 c2_103 .25;	parms b2_104 0 a2_104 1 c2_104 .25;	parms b2_105 0 a2_105 1 c2_105 .25;

	* Parms initiation statements for polytomous items (2nd STAGE);
	parms b_stp1_106 0 b_stp2_106 0 ap_2_106 1;       parms b_stp1_107 0 b_stp2_107 0 ap_2_107 1;    parms b_stp1_108 0 b_stp2_108 0 ap_2_108 1; 	
	parms b_stp1_109 0 b_stp2_109 0 ap_2_109 1;       parms b_stp1_110 0 b_stp2_110 0 ap_2_110 1;    parms b_stp1_111 0 b_stp2_111 0 ap_2_111 1;
    parms b_stp1_112 0 b_stp2_112 0 ap_2_112 1;       parms b_stp1_113 0 b_stp2_113 0 ap_2_113 1;    parms b_stp1_114 0 b_stp2_114 0 ap_2_114 1;
    parms b_stp1_115 0 b_stp2_115 0 ap_2_115 1;

	
	/*Priors related to item parameters*/
    prior b1: ~ normal (2, var=2);   *All parameters starting with a "b1" will follow this distribution;
	prior b2: ~ normal (0, var=5);   *All parameters starting with a "b2" will follow this distribution;
	prior b_stp: ~ normal (0, var=5);   *All parameters starting with a "b2" will follow this distribution;
    prior a: ~ lognormal (0, var=1); *All parameters starting with an "a" will follow this distribution;
    prior c: ~ normal (.25, var=.1, lower=0, upper=1); *All parameters starting with a "c" will follow this distribution;

	*All parameters starting with a "e" will follow this distribution;
	prior eta0 ~ normal (0, var=1);
	prior eta1 ~ normal (0, var=4);  *Female;
	prior eta2 ~ normal (0, var=4);  *LANG_of_test;
	prior eta3 ~ normal (0, var=4); *ESCS ;

    /*Priors related to ability parameters*/

 		array theta[2] TOI DISENG_RES;      *array to reference theta_TOI_residual and theta_Diseng;
		array mu{2} mu_TOI mu_DISENG_RES;   *array of the mean of the Multivariate_normal ( transprose of (mu_TOI_residual, mu_Diseng));
		array sigma[2,2];				*array of the variance of Multivariate normal distribution;

		*Define constants related to probability distribution of ability parameters;
		begincnst;
		mu_TOI = 0;     *mean of theta_TOI in joint probability distribution (Multivariate normal distribution);
		mu_DISENG_RES = 0;  *mean of theta_Disengagement residual in joint probability distribution (Multivariate normal distribution);
		sigma[1,1] = 1; * Covariance matrix of multivariate normal distribution (akin to variance if it were simply a normal distribution);
		sigma[2,2] = 1;
		*rho = sigma[1,2] = sigma[2,1] could have been set to constants even if we want to allow ability to be correlated with disengagement;
		* I guess we don't do it and specify a rho's hyperprior because we want the data to influence the rho's shrinkage and even more the multivariate;
		endcnst;

		*Define the probability density functions related to ability parameters;
		sigma[1,2]=rho;
		sigma[2,1]=rho;

		parms rho 0; 
		prior rho ~ normal(0, var=2, lower=-1, upper=1);     * hypereprior;
		random theta ~ mvn(mu, sigma) subject=_obs_;  *Multivariate normal distribution;
	llike=0; **BRIAN ADDED - THIS WAS MISSING;
	llike_dich = 0;
	do j= 1 to &n_dichotomous;
			p_RG = logistic (a1 * (eta0 + eta1*Female + eta2*LANG_of_test + eta3*ESCS + DISENG_RES - b1_[j])); *probability of RG (stage 1);
			p_NRG = (1 - p_RG); *probability of Non RG (stage 1);

			p_right = (c2_[j] + (1 - c2_[j]) * logistic (a2_[j] * (TOI - b2_[j]))); *probability of right answer item response = 1 (stage 2);
			p_false = (1 - p_right); *probability of right answer item response = 0 (stage 2);

			p_NRG_right = (p_NRG * p_right); *probability of right answer item response = 1  and Non RG (stage 1 * stage2);
			p_NRG_false = (p_NRG * p_false); *probability of wrong answer item response = 0  and Non RG (stage 1 * stage2);

			* p_RG + p_right_NRG + p_NRG_false = 1;


           *Now we have everything to compute loglikelihood for dichotomous items;
			if RG[j] = 1 then llike_dich = llike_dich + log(p_RG);
			else if RG[j] = 0 and I[j] = 0 then llike_dich = llike_dich + log(p_NRG_false);
			else if RG[j] = 0 and I[j] = 1 then llike_dich = llike_dich + log(p_NRG_right);
	end;

	llike_poly = 0;
	do j= 106 to 115;
			p_RG = logistic (a1 * (eta0 + eta1*Female + eta2*LANG_of_test + eta3*ESCS + DISENG_RES - b1_[j])); *probability of RG (stage 1);
			p_NRG = (1 - p_RG); *probability of Non RG (stage 1);
			


			***BRIAN WORK;
**Need to fix j's:;
			numerator0 	= exp(ap_2_[j-105]*(TOI));
			numerator1 	= exp(ap_2_[j-105]*(TOI)+ap_2_[j-105]*(TOI-b_stp1_[j-105]));
			numerator2	= exp(ap_2_[j-105]*(TOI)+ap_2_[j-105]*(TOI-b_stp1_[j-105])+ap_2_[j-105]*(TOI-b_stp2_[j-105]));
			denominator = numerator0+numerator1+numerator2;

			P_nocredit=numerator0/denominator;
			P_partialcredit=numerator1/denominator;
			p_fullcredit=numerator2/denominator;

/*********Juste work************/
/*			denom = 1 + (  exp(ap_2_[j - &n_dichotomous]*((TOI - b_stp1_[j - &n_dichotomous]) + */
/*								       (TOI - b_stp2_[j - &n_dichotomous]) */
/*								      )*/
/*						       )*/
/*						);  * Common denominator of the p's;*/
/**/
/**/
/*			p_nocredit = 1/denom ; *probability of getting a no-credit item response = 0 (stage 2) ;*/
/**/
/*			p_partialcredit = exp(ap_2_[j - &n_dichotomous]*(TOI - b_stp1_[j - &n_dichotomous])) / denom ; *probability of partial credit answer item response = 1 (stage 2);*/
/**/
/*			p_fullcredit = ( exp(ap_2_[j - &n_dichotomous]*((TOI - b_stp1_[j - &n_dichotomous]) + */
/*								         (TOI - b_stp2_[j - &n_dichotomous])*/
/*										)*/
/*								)*/
/*							) / denom ;    *probability of full credit answer item response = 2 (stage 2);*/
/**/

			p_NRG_nocredit = (p_NRG * p_nocredit); *probability of getting a no-credit item response = 0   and Non RG (stage 1 * stage2);
			p_NRG_partialcredit = (p_NRG * p_partialcredit); *probability of partial credit answer item response = 1 and Non RG (stage 1 * stage2);
			p_NRG_fullcredit = (p_NRG * p_fullcredit);       *probability of full credit answer item response = 2 and Non RG (stage 1 * stage2);


			* p_RG + p_NRG_nocredit + p_NRG_partialcredit + p_NRG_fullcredit = 1;

			*Now we have everything to compute loglikelihood for polytomous items;
			if RG[j] = 1 then llike_poly = llike_poly + log(p_RG);
			else if RG[j] = 0 and I[j] = 0 then llike_poly = llike_poly + log(p_NRG_nocredit);
			else if RG[j] = 0 and I[j] = 1 then llike_poly = llike_poly + log(p_NRG_partialcredit);
			else if RG[j] = 0 and I[j] = 2 then llike_poly = llike_poly + log(p_NRG_fullcredit);
    end;
	llike = llike_dich + llike_poly;
	model general(llike);
run;

ods pdf close;
