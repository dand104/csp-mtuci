.section/dm vars;
.var p = 36001; // delit
.var A = 100; //delim 0-16b
.var B = 200; //edlim 16-32b
.var R; // resultat



.section/pm program;
jump start;

delen_p:
af = pass mr1;
ay0 = mr0;
ax0 = dm(p);
astat = 0;
ar = pass ax0;
if ne jump condition_delen;
astat = 4;
rts;

condition_delen:
ar = pass ax0;
if gt jump bo0;
if lt jump me0;

bo0:
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
mr = mr - ar * my0 (uu);
rts;
me0:
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
mr = mr - ar * my0 (uu);
rts;

start:
ena m_mode;
mx0 = dm(A);
my0 = dm(B);
mr = mx0 * my0 (uu);
call delen_p;
if av jump end_av;
dm(R) = mr0;
end: jump end;

end_av: jump end_av;
