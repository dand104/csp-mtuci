// kurs KIh filter
.section/dm vars;
.var/circ z[80] = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0; // filter signal buffer
.section/pm varsp;
.var/circ coeffs[80] = 6680, -1802, -4700, 2458, 2430, -745, -3139, 960, 3787, -1625, -2842, 251, 1435, 1577, -145, -2645, -835, 2678, 1786, -980, -2584, -606, 1889, 855, -791, -1350, -6, 2071, 2046, 162, -204, 1876, 1296, 1065, 121, -580, 235, 287, -123, -915, 229, -88, 418, -667, 354, 832, -453, -79, 117, -573, 112, 1413, -1655, -594, 1920, -937, -560, 1638, -986, -805, 2010, -1374, -1416, 3111, -842, -2232, 2108, -402, -1258, 2733, -1216, -2843, 3617, 502, -3384, 667, 2311, 1155, -4487, -1170;
.section/pm program;
		jump start; rti; rti; rti; // reset
		rti; rti; rti; rti; 
		rti; rti; rti; rti; 
		rti; rti; rti; rti; 
		rti; rti; rti; rti; 
		rti; rti; rti; rti; 
		rti; rti; rti; rti; 
		rti; rti; rti; rti; 
		rti; rti; rti; rti; 
		rti; rti; rti; rti; 
		jump filter; rti; rti; rti; // timer
		rti; rti; rti; rti; 
start:

		mr = 0;
		I0 = z; L0 = length(z);
		I4 = coeffs;L4 = length(coeffs);
		M0 = 1; M4 = 1;	M1 = 0;
		ar = 4; 
		dm(0x3ffb) = ar; // TSCALE
		//ar = 999; T = 125 mks
		dm(0x3ffc) = ar; // TCOUNT
		dm(0x3ffd) = ar; // TPERIOD
		
		ifc = 0x00ff; nop;
		
		ena timer;
		imask = b#0000000001; nop;
		 		
loop_: jump loop_; // loop

filter:	mr = 0; // timer int //
		mx0 = dm(I0, M0);
		my0 = pm(I4, M4);
		CNTR = 78;
		do cycle until CE;
 cycle: mr = mr + mx0 * my0 (ss),mx0 = dm(I0, M0), my0 = pm(I4, M4);
		mr = mr + mx0 * my0 (ss),mx0 = dm(I0, M1), my0 = pm(I4, M4);
		mr = mr + mx0 * my0 (ss);
		ax0 = IO(0);
		dm(I0, M1) = ax0;
		
		mr = mr (rnd);
		if mv sat mr;
		
		IO(1) = mr1;
		rti;
