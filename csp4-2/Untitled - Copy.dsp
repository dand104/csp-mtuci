.section/dm vars;

.var n = 53;
.var a = 13;
.var z = 0;    
.var x1 = 0;
.var x2 = 0;
.var y1 = 0;
.var y2 = 0;


.var result = 0;

.section/pm program;

jump start;


delen:nop;
	
	af = pass mr1;
	ay0 = mr0;
	ar = pass ax0;
	
	if gt jump tttt;
	llll: if lt jump rrrr;
	astat = 4;
	rts;
	tttt: astat = 0;
	
	divq ax0; divq ax0; divq ax0; divq ax0;
	divq ax0; divq ax0; divq ax0; divq ax0;
	divq ax0; divq ax0; divq ax0; divq ax0;
	divq ax0; divq ax0; divq ax0; divq ax0;
	divq ax0;
	
	mr2 = 0;
	my0 = ax0, ar = pass ay0;
	mr = mr - ar * my0 (uu);
	rts;
	
	rrrr: sr1 = ax0;
	sr = lshift sr1 by -1(hi);
	astat = 0;
	divq sr1; divq sr1; divq sr1; divq sr1;
	divq sr1; divq sr1; divq sr1; divq sr1;
	divq sr1; divq sr1; divq sr1; divq sr1;
	divq sr1; divq sr1; divq sr1; divq sr1;
	mr2 = 0;
	my0 = ax0, ar = pass ay0;
	af = tstbit 0xf of sr0;
	if ne ar = ar - 1;
	ay0 = ar;
	mr = mr - ar * my0 (uu);
	rts;
start:
	nop;
	ena m_mode;
	ar = 1;
	dm(y2) = ar;
	ar = 0;
	dm(y1) = ar;
	
	
	ar = 0;
	dm(x2) = ar;
	ar = 1;
	dm(x1) = ar;
	
	// z = n
	ax0 = dm(n);
	dm(z) = ax0;
	
_loop: 
	ax0 = dm(a);
	if le jump _le_loop;
	mr = 0;
	ax0 = dm(n); 
	mr0 = ax0;
	ax0 = dm(a);
	call delen;     
	

	ay1 = ay0;
	ax1 = mr0; 


	// y = y2 - q * y1
	mx0 = ay1;
	my0 = dm(y1); 
	mr = mx0 * my0 (ss);
	ax0 = dm(y2);
	ay0 = mr0; 
	ar = ax0 - ay0;
	ay0 = ar;          

	// x = x2 - q * x1
	mx0 = ay1;
	my0 = dm(x1); 
	mr = mx0 * my0 (ss);
	ax0 = dm(x2);           
    ay1 = mr0;
	ar = ax0 - ay1;           
	ax0 = ar;          


	ar = dm(y1); dm(y2) = ar;
	ar = ay0;    dm(y1) = ar;

	ar = dm(x1); dm(x2) = ar;
	ar = ax0;    dm(x1) = ar;

	ar = dm(a);  dm(n) = ar;
	ar = ax1;    dm(a) = ar;
	jump _loop;
_le_loop:
	ax0 = dm(n); 
	ar = ax0 - 1;
	if ne jump _no_inv; 


	// x = x2 mod z
	ax0 = dm(x2);
    mr0 = ax0;
    ar = ax0;
    if lt jump _neg_sign;
    mr1 = 0;
    jump _do_mod;
_neg_sign:
    ar = -1;
    mr1 = ar;      
_do_mod:
    ax0 = dm(z);  
    call delen;      

  
    ax0 = mr0;
    if ge jump skip_correction;  
    
   
    ay1 = dm(z);
    ar = ax0 + ay1;  
    ax0 = ar;    
    
skip_correction:
    dm(result) = ax0;
    jump _end;

_no_inv:
    ar = 0;
    dm(result) = ar;

_end:
    jump _end;
