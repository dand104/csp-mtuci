.section/dm vars;

.var A = 256;
.var B = 253;
.var m = 4335;
.var X_val = 0;

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
	dis ar_sat;
	ena m_mode;
	mx0 = dm(A);
	mr = 0;
	
_loop: 
	mr0 = dm(B);
	my0 = dm(X_val);
	mr = mr + mx0 * my0 (uu);

	ax0 = dm(m);
	call delen;
	
	dm(X_val) = mr0;
	io(0) = mr0;
	
	jump _loop;
