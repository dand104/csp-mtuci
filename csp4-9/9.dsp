.section/dm vars;
.var res = 0;

.section/pm program;
start:
    dis ar_sat;
    ay0 = 3264;
    ar = ay0;
    ay0 = 50;
    mr0 = ay0;
    ay1 = 0x0006;
    call umn_ab;
    dm(res) = ar;
end:
    jump end;

umn_ab:
    ay0 = 0;
    af = pass ay0;
    sr0 = 1;
    se = 1;
    ay0 = sr0;
    none = mr0 and ay0;
    if ne af = pass ar;
    cntr = 14;
    do loop until ce;
        sr = lshift sr0 (lo);
        ay0 = ar;
        ar = ar + ay0;
        if ac ar = ar xor ay1;
        ay0 = sr0;
        none = mr0 and ay0;
        if ne af = ar xor af;
    loop: nop;
    ar = pass af;
    rts;
