.section/dm vars;
.var S1;
.var S0;

.section/pm program;

jump start;



start:
		MR1 = 0xC5DE;
	    MR0 = 0xCD6A;
	    SR = LSHIFT MR0 BY -7 (LO);
	    SR = SR OR LSHIFT MR1 BY -7 (HI);
	    SR = SR OR LSHIFT MR0 BY 9 (HI);
	    SR = SR OR LSHIFT MR1 BY 9 (LO);
	    dm(S0) = SR0;
	    dm(S1) = SR1;
		
