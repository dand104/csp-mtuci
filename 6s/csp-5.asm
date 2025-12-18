.section/dm vars;
.var got_fl = 0;
//buff pr
.var/circ rx_buf[32] = 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0;

.var/circ tx_buf[32] = 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0;

.var/circ vhod[31] = 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0;

.var/circ vihod[31] =0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0;

.var i2_soh;

.var i3_soh;

.var l2_soh;

.var l3_soh;

.var ar_soh;
.SECTION/PM program;
	
	jump start; rti; rti; rti;  // RESET
	rti; rti; rti; rti; // IRQ2
	rti;rti; rti; rti; // IRQL1
	rti; rti; rti; rti; // IRQL0
	jump peredacha; rti; rti; rti; // SPORT0
	jump priem; rti; rti; rti; // SPORT0 
	rti; rti; rti; rti; // IRQE
	rti; rti; rti; rti; // BDMA
	rti; rti; rti; rti; // SPORT1 
	rti; rti; rti; rti; // SPORT1 
	rti; rti; rti; rti; // Timer
	rti; rti; rti; rti; // Power Down

start: 
	ar = dm(0x3fff);
	ar = clrbit 0xc of ar;
	dm(0x3fff) = ar;
	ar = B#001010000111;
	dm(0x3ff3) = ar;
	i0 = rx_buf;
	l0 = length(rx_buf);
	i1 = tx_buf;
	l1 = length(tx_buf);
	m1 = 1;
	ar = B#1000000100010111; // (0x8117) ITFS, SLEN=1 (2-bit), ISCLK=1, IRFS, LRFS, CKRE
	dm(0x3ff6) = ar;
	ar = 0xffff;
	dm(0x3ff7) = ar;
	dm(0x3ff8) = ar;
	dm(0x3ff9) = ar;
	ar = dm(0x3fff);
	ar = setbit 0xc of ar;
	dm(0x3fff) = ar;
	
	ifc = 0x00ff;
	
	nop;
	
	ar = dm(i1, m1);
	tx0 = ar;
	
	imask = B#0001100000;
	ena ints;
	nop;
	
	
zacycl:
    ar = dm(got_fl);
    ar = pass ar;
    if eq jump zacycl;

	ar = 0;
	dm(got_fl) = ar;
	jump zacycl;

peredacha:
    dm(i2_soh) = i2;
    dm(i3_soh) = i3;
    dm(l2_soh) = l2;
    dm(l3_soh) = l3;
    dm(ar_soh) = ar;

	i2 = tx_buf + 1;
	l2 = length(tx_buf);
	i3 = vihod;
	l3 = length(vihod);
	cntr = 31;
	do vic1 until ce;
	ar = dm(i3, m1);
vic1:   dm(i2, m1) = ar;

	ar = dm(ar_soh);
	i2 = dm(i2_soh);
	i3 = dm(i3_soh);
	l2 = dm(l2_soh);
	l3 = dm(l3_soh);
	
	rti;

priem:
    dm(i2_soh) = i2;
    dm(i3_soh) = i3;
    dm(l2_soh) = l2;
    dm(l3_soh) = l3;
    dm(ar_soh) = ar;

	i2 = rx_buf + 1;
	l2 = length(rx_buf);
	i3 = vhod;
	l3 = length(vhod);
	cntr = 31;
	do vic2 until ce;
	ar = dm(i2, m1);
	vic2:   dm(i3, m1) = ar;
	ar = dm(ar_soh);
	i2 = dm(i2_soh);
	i3 = dm(i3_soh);
	l2 = dm(l2_soh);
	l3 = dm(l3_soh);
	
	ar = 0x55;
	dm(got_fl) = ar;
	
	rti;
