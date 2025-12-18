.section/dm vars;
.section/pm program;
/*
// 1.1
ax0 = -0.4r;
ay0 = -0.4r;

ar = ax0 + ay0;

// 1.2

ax0 = -0.5r;
ay0 = -0.5r;
ena ar_sat;
ar = ax0 + ay0;

// 1.3

mx0 = -0.2r;
my0 = -2 ^ (-15);

mr = mx0 * my0 (SU);



// 1.4
mx0 = -0.2r;
my0 = -2 ^ (-15);

mr = mx0 * my0 (SU);
mr = mr (rnd);
if MV sat MR;



// 1.5

label:
my0 = 12;
mx0 = 3;
ena m_mode;
mr = mx0*my0(su);
/*
*/
// 2.1/2
ena m_mode;
mx0 = 0xABCD;
my0= -12;
mr = mx0 * my0 (sS);

/*
// 2.3/4
dis m_mode;
if mv sat mr;
do label2 until forever;
mx0 = io(0);
my0 = -2 ^ (-15);

mr = mx0 * my0 (SU);
label2: io(1) = mr0;


// 3.1 (rnd)
ml: ena m_mode;
	do m until forever;
	mx0 = io(0);
	my0 = 655;
	mr = mx0 * my0 (ss);
	mr = mr (rnd);
	my0 = 100;
	mx0 = mr1;
	mr = mx0*my0 (ss);
	m: io(1) = mr0;
// 3.2 

ml2: ena m_mode;
	do mk2 until forever;
	mx0 = io(0);
	my0 = 655;
	mr = mx0 * my0 (ss);
	my0 = 100;
	mx0 = mr1;
	mr = mx0 * my0 (ss);
	mk2: io(1) = mr0;
*/
