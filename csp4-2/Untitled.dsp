.section/dm vars;
.var n = 53;   
.var a = 13;      
.var z = 0;       
.var x1 = 0;
.var x2 = 0;   
.var q = 0;        
.var result = 0;   

.section/pm program;
jump start;

start:  
    ena m_mode;   
    
    // x2 = 0, x1 = 1
    ax0 = 0;
    dm(x2) = ax0;
    ax0 = 1;
    dm(x1) = ax0;

    ax0 = dm(n);
    dm(z) = ax0;

poisk:
    ax0 = dm(a);
    ar = pass ax0;
    if le jump poisk_end; 

    mx0 = 1;
    my0 = dm(n);
    mr = mx0 * my0 (uu); 
    ax0 = dm(a);
    call delen;
    dm(q) = ay0;
    
    ay1 = mr0;
    mr = 0;
    mr0 = dm(x2);
    mx0 = dm(x1);
    my0 = dm(q);
    
    mr = mr - mx0 * my0 (uu);
   
    ax0 = dm(x1);
    dm(x2) = ax0; 
    dm(x1) = mr0;

    ax0 = dm(a);
    dm(n) = ax0;
    dm(a) = ay1;

    jump poisk;

poisk_end:
 	ax0 = dm(n); // NOD(a,n)=n 
    ay0 = 1; 
    ar = ax0 - ay0; 
    if ne jump no_solution; // NOD != 1

    mx0 = 1;
    my0 = dm(x2);      
    mr = mx0 * my0 (ss); // x
    ax0 = dm(z);
    call delen; // x mod z
    ar = pass mr0;
    if ge jump res;
   
    ay0 = dm(z);
    ar = ar + ay0; // x = x + z

res:
    dm(result) = ar;
    jump program_end;

no_solution:

    ax0 = 0;
    dm(result) = ax0;

program_end:
    nop;
    jump program_end;


delen:
    nop;
    af = pass mr1;
    ay0 = mr0;
    ar = pass ax0;
    if gt jump tttt;
llll: 
    if lt jump rrrr;
    astat = 4;
    rts;
tttt: 
    astat = 0;

    divq ax0; divq ax0; divq ax0; divq ax0;
    divq ax0; divq ax0; divq ax0; divq ax0;
    divq ax0; divq ax0; divq ax0; divq ax0;
    divq ax0; divq ax0; divq ax0; divq ax0;
    divq ax0;

    mr2 = 0;
    my0 = ax0, ar = pass ay0;
    mr = mr - ar * my0 (uu);
    rts;

rrrr: 
    sr1 = ax0;
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
