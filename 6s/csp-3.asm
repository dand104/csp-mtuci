.section/dm vars;



.var/circ X[5] = 1620, 1322, 346, 39, 35;
.var/circ K[5] = 2245, 1322, 1620, 914, 18;

.var Z[5]; // modul ot deleniya
.var/circ Y[5]; // xor A, B
.var M[5]; //  xor resultat B
.var p = 2267; // delitel 

.section/pm program;

jump start;



start:
		ena m_mode;
		
		/*
		ena ar_sat;
		ax0 = 0xAB54;
		ax1 = 0xFFFF;
		ar = pass ax0;
		af = pass ax1;
		ar = ar + af; 
		*/
		
		M0 = 1; M4 = 1;
		// nastroika registrov dlya massivov
		I0 = X; L0 = length(X);
		I1 = K; L1 = length(K);
		I2 = Z; L2 = 0; // L=5
		I3 = Y; L3 = length(Y);// L=5
		I4 = M; L4 = 0;
		
		call mod;
		call xor_1;
		call xor_2;			
end: jump end;


delen_p: 
			af = pass mr1;
			ay0 = mr0;
			ax0 = dm(p);
			astat = 0;
			ar = pass ax0;
			if ne jump deli_condition;
			astat = 4;
			rts;
	deli_condition:
			ar = pass ax0;
			if gt jump deli_p;
			if lt jump deli_n;
	deli_p:
			divq ax0; divq ax0;
			divq ax0; divq ax0;
			divq ax0; divq ax0;
			divq ax0; divq ax0;
			divq ax0; divq ax0;
			divq ax0; divq ax0;
			divq ax0; divq ax0;
			divq ax0; divq ax0;
			divq ax0;
			mr2 = 0;
			my0 = ax0;
			ar = pass ay0;
			mr = mr - ar * my0 (ss);
			rts;
	deli_n:
			sr1 = ax0;
			sr = lshift sr1 by -1 (hi);
			divq sr1; divq sr1;
			divq sr1; divq sr1;
			divq sr1; divq sr1;
			divq sr1; divq sr1;
			divq sr1; divq sr1;
			divq sr1; divq sr1;
			divq sr1; divq sr1;
			divq sr1; divq sr1;
			ar = pass ay0;
			if eq jump equ_zero;
			af = tstbit 0 of ax0;
			if ne ar = ar - 1;
		equ_zero: 
			mr2 = 0;
			my0 = ax0;
			mr = mr - ar * my0 (ss);
			rts;

mod:	CNTR = 5;
		do end_mod until CE;
		mx0 = dm(I0, M0);
		my0 = dm(I1, M0);
		mr = mx0 * my0 (uu);
		call delen_p;
	end_mod:dm(I2, M0) = mr0;
		rts;

	
xor_1:	CNTR = 5;
		do end_xor_1 until CE;
		ax0 = dm(I0, M0);
		ay0 = dm(I1, M0);
		ar = ax0 xor ay0;
		dm(I3, M0) = ar;
	end_xor_1:ar = 0;
		rts;

		
xor_2:	CNTR = 5;
		do end_xor_2 until CE;
		ax0 = dm(I3, M0);
		ay0 = dm(I1, M0);
		ar = ax0 xor ay0;
		dm(I4, M4) = ar;
	end_xor_2:ar = 0;
		rts;
