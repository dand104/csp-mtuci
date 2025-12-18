.section/dm vars;
.var a = 3264;
.var b = 50;
.var p = 32771;
.var se_var = 0;
.var res = 0;

.section/pm program;
start:
    dis ar_sat;
    ar = dm(a);
    mr0 = dm(b);
    mr1 = dm(p);
    se = exp mr1(hi);
   	dm(se_var) = se;
    ar = se;
   
    sr = norm mr1 (hi);
    mr1 = sr1;
    ar = dm(a);
    sr = norm ar (hi);
    ar = sr1;
    sr = norm mr0 (hi);
    mr0 = sr1;
    ay1 = 0x0006;
    call umn_n;
    se = dm(se_var);
    sr = lshift ar (hi);
    ar = sr1;
    dm(res) = ar;
end:
    jump end;

umn_n:
    ay0 = 0;
    af = pass ay0;
    sr0 = 1;
    se = 1;
    ay0 = sr0;
    none = mr0 and ay0;
    if ne af = pass ar;
    cntr = 14;
    do loop_n until ce;
        sr = lshift sr0 (lo);
        ay0 = ar;
        ar = ar + ay0;
        if ac ar = ar xor ay1;
        ay0 = sr0;
        none = mr0 and ay0;
        if ne af = ar xor af;
    loop_n: nop;
    ar = pass af;
    rts;
