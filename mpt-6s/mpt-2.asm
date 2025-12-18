
.Section/DM vars;
.SECTION/PM program;



jump start;
	
mpos:
	
	nosync:
			ar = 0x 0001;
			
			dis ar_sat; 
			do next until forever;
			ay0 = b#1000000000000000;
			ay1 = b#0100001101110111; 
			af = pass ar;
			ar = ar + af;
			none = ar and ay0;
			if ne ar = ar xor ay1;
		next:		io(0) = ar;
			rts;
	 	   
	 	   
	sync:
		ar = b#0000000000000001;
			do next2 until forever;
			af = pass ar;
			ar = ar + af;
			af = tstbit 0xF of ar;
			if ne ar = tglbit 0 of ar;
			af = tstbit 0xE of ar;
			if ne ar = tglbit 0 of ar;
		next2:		io(0) = ar;
			rts;
			
start: nop;
call mpos;


end: nop;
