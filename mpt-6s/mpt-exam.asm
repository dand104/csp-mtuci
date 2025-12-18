.section/dm vars;

.var/circ buffer[64] = 0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0;
.var/circ pcm[64] = 0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0;
.var prev_sample = 0;
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
		jump interupt; rti; rti; rti; // timer
		rti; rti; rti; rti; 

start:
	i0=buffer; l0=length(buffer);
	i2=pcm;l2=length(pcm);
	m0=0;
	m1=1;
	ar = 0;
	dm(prev_sample) = ar;
	ena ar_sat;
	
	ar= 4;
	dm(0x3ffb) = ar; // TSCALE
	//T = 125 mks
	ar=4;
	dm(0x3ffc) = ar; // TCOUNT
	dm(0x3ffd) = ar; // TPERIOD
		
	ifc = 0x00ff; nop;
		
	ena timer;
	imask = b#0000000001; nop;
cycle: 
	jump cycle;

interupt: ax0=io(0);
		  dm(i0,m1) = ax0;
		  ay0 = dm(prev_sample);
		   ar = ax0 - ay0;
		   dm(prev_sample) = ar;
		   dm(i2,m1) = ar;
		   io(1) = ar;
		  rti;
