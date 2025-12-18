.section/dm vars;
//.var A = b#0011011000001110;
.var A = b#0100110000011110;
.section/pm program;

jump main;

main:
	ar = 0xABCD;
	se = 0xFD;
	sr = lshift ar (hi);
/*
    ax0 = dm(A);

    si = ax0;
    sr = lshift si by -1 (lo);
    ar = sr0;
    ay0 = b#0101010101010101;
    af = pass ay0;
    ar = ar AND af;
    ay1 = ar;

    ay0 = b#0101010101010101;
    af = pass ay0;
    ar = ax0 AND af;
    si = ar;
    sr = lshift si by 1 (lo);
    ar = sr0;

    ar = ar OR ay1;
    ax0 = ar;

    si = ax0;
    sr = lshift si by -2 (lo);
    ar = sr0;
    ay0 = b#0011001100110011;
    af = pass ay0;
    ar = ar AND af;
    ay1 = ar;

    ay0 = b#0011001100110011;
    af = pass ay0;
    ar = ax0 AND af;
    si = ar;
    sr = lshift si by 2 (lo);
    ar = sr0;

    ar = ar OR ay1;
*/

end:
    jump end;
