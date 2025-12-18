#define konst1 -2;
#define konst2 16384;
#define konst3 1024;


.section/dm vars;

.var/dm var1 = 25;

.section/pm program;

jump main;


main:
// x and y
	ax0=4;
	ay0=2;
	ar = ax0 and ay0;
	
	ay1=4;
	ar = ax0 and ay1;
	
	ay0=3;
	af = ax0 and ay0;
	
	ar = ax0 and af;
	
	ay0 = dm(var1);
	af = ax0 and ay0;
	
	ax0 = 0;
	ar = ar and ay0;
	
// x  + c
	ar = ax0 + konst1;
	af = ax0 + konst2;
	
	
// clrbit
	ax0 = b#1100; // 1100
	ar = CLRBIT 2 OF ax0;
	ar = ar + 1024;
	af = CLRBIT 0x1 OF ar;
// PASS Xop
	ax1 = 21;
	ar = PASS ax1;
	
	af = PASS konst3;
	ar = PASS af;
	
// mx0 * my0 (SU)
	mx0 = -3;
	my0 = 5;
	ena m_mode; // celie cisla
	mr = mx0 * my0 (SU);
	
// mx0 * my0 (SS)
	mx1 = 30;
	my1 = -120;
	mr = mx1 * my1 (SS);
	
	
	// dz
	dis m_mode;
	ena m_mode;
	mr = 0;
	mx0=0xABCD;
	my0=- 14;
	mr = mx0 * my0 (ss);
end:
	jump end;
