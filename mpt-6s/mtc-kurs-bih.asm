.section/PM varsp;
.var/circ z1[2] = 0, 0;
.var/circ zz1[2] = 0, 0;

.var/circ z2[2] = 0, 0;
.var/circ zz2[2] = 0, 0;

.var/circ z3[2] = 0, 0;
.var/circ zz3[2] = 0, 0;

.var/circ z4[2] = 0, 0;
.var/circ zz4[2] = 0, 0;

.var/circ z5[2] = 0, 0;
.var/circ zz5[2] = 0, 0;

.section/DM vars;
.var/circ ab1[5] = 32768, 52863, 32768, 53281, -32477 ;
.var/circ ab2[5] =  32768, 56969, 32768,56267, -32513;
.var/circ ab3[5] =  32768 ,51656, 32768, 53039, -31676;
.var/circ ab4[5] = 32768, 57744, 32768, 55302, -31772;
.var/circ ab5[5] = 32768, 0, 32768, 53684, -31086;

.var/circ gain[5] = 1254, 13310, 13310, 19460,19460;

// pointers
.var Iz1 = z1;
.var Izz1 = zz1;
.var Iz2 = z2;
.var Izz2 = zz2;
.var Iz3 = z3;
.var Izz3 = zz3;
.var Iz4 = z4;
.var Izz4 = zz4;
.var Iz5 = z5;
.var Izz5 = zz5;

.section/PM program;

  jump init; rti; rti; rti;
  rti; rti; rti; rti;
  rti; rti; rti; rti;
  rti; rti; rti; rti;
  rti; rti; rti; rti;
  rti; rti; rti; rti; 
  rti; rti; rti; rti; 
  rti; rti; rti; rti;
  rti; rti; rti; rti; 
  rti; rti; rti; rti; 
  jump iir; rti; rti; rti;
  rti; rti; rti; rti;
  
init:
    M0 = 1; M1 = 0; //  (Coeffs, Gain)
    M4 = 1; M5 = 0; // (I4, I5)
    L0 = 0; L1 = 0; L2 = 0; L3 = 0; L4 = 0; L5 = 0;
    // timer init
    AR = 0; dm(0x3FFB) = AR;
    AR = 4; dm(0x3FFC) = AR; dm(0x3FFD) = AR; 
    IFC = 0x00FF; nop; ena timer; imask = 0x0001; nop;
loop_: jump loop_;
// Filter (timer int)
iir:
    I2 = gain; L2 = length(gain); 
    MX1 = IO(0);   
      
    // Cascade 1
    I4 = dm(Iz1); L4 = length(z1); I5 = dm(Izz1); L5 = length(zz1); I0 = ab1; L0 = length(ab1);
    MR = 0;
    MY0 = dm(I0, M0);
    // FIR
    MR = MX1 * MY0 (SU), MX0 = dm(I0, M0), MY0 = pm(I4, M4);
    MR = MR - MX0 * MY0 (US), MX0 = dm(I0, M0); MY0 = pm(I4, M5);
    MR = MR + MX0 * MY0 (US),  MX0 = dm(I0, M0), MY0 = pm(I5, M4); 
    pm(I4, M5) = MX1; dm(Iz1) = I4;          
                     
    // IIR
    MR = MR + MX0 * MY0 (US), MX0 = dm(I0, M0); MY0 = pm(I5, M5); 
    MR = MR + MX0 * MY0 (SS); 
    MR = MR (rnd); if MV sat MR;
    
    pm(I5, M5) = MR1; dm(Izz1) = I5;           
    MY1 = dm(I2, M0); MR = MR1 * MY1 (rnd);
    MX1 = MR1; 

    // Cascade 2
    I4 = dm(Iz2); L4 = length(z2); I5 = dm(Izz2); L5 = length(zz2); I0 = ab2; L0 = length(ab2);
    MR = 0,MY0 = dm(I0, M0);
    MR = MX1 * MY0 (SU), MX0 = dm(I0, M0), MY0 = pm(I4, M4);
    MR = MR - MX0 * MY0 (US), MX0 = dm(I0, M0); MY0 = pm(I4, M5);
    MR = MR + MX0 * MY0 (US),  MX0 = dm(I0, M0), MY0 = pm(I5, M4); 
    pm(I4, M5) = MX1; dm(Iz2) = I4;          
                     
    // IIR
    MR = MR + MX0 * MY0 (US), MX0 = dm(I0, M0); MY0 = pm(I5, M5); 
    MR = MR + MX0 * MY0 (SS); 
    MR = MR (rnd); if MV sat MR;
    
    pm(I5, M5) = MR1; dm(Izz2) = I5;           
    MY1 = dm(I2, M0); MR = MR1 * MY1 (rnd);
    MX1 = MR1; 

    // Cascade 3
    I4 = dm(Iz3); L4 = length(z3); I5 = dm(Izz3); L5 = length(zz3); I0 = ab3; L0 = length(ab3);
    MR = 0,MY0 = dm(I0, M0);
    MR = MX1 * MY0 (SU), MX0 = dm(I0, M0), MY0 = pm(I4, M4);
    MR = MR - MX0 * MY0 (US), MX0 = dm(I0, M0); MY0 = pm(I4, M5);
    MR = MR + MX0 * MY0 (US),  MX0 = dm(I0, M0), MY0 = pm(I5, M4); 
    pm(I4, M5) = MX1; dm(Iz3) = I4;          
                     
    // IIR
    MR = MR + MX0 * MY0 (US), MX0 = dm(I0, M0); MY0 = pm(I5, M5); 
    MR = MR + MX0 * MY0 (SS); 
    MR = MR (rnd); if MV sat MR;
    
    pm(I5, M5) = MR1; dm(Izz3) = I5;           
    MY1 = dm(I2, M0); MR = MR1 * MY1 (rnd);
    MX1 = MR1; 


    // Cascade 4
    I4 = dm(Iz4); L4 = length(z4); I5 = dm(Izz4); L5 = length(zz4); I0 = ab4; L0 = length(ab4);
    MR = 0,MY0 = dm(I0, M0);
    MR = MX1 * MY0 (SU), MX0 = dm(I0, M0), MY0 = pm(I4, M4);
    MR = MR - MX0 * MY0 (US), MX0 = dm(I0, M0); MY0 = pm(I4, M5);
    MR = MR + MX0 * MY0 (US),  MX0 = dm(I0, M0), MY0 = pm(I5, M4); 
    pm(I4, M5) = MX1; dm(Iz4) = I4;          
                     
    // IIR
    MR = MR + MX0 * MY0 (US), MX0 = dm(I0, M0); MY0 = pm(I5, M5); 
    MR = MR + MX0 * MY0 (SS); 
    MR = MR (rnd); if MV sat MR;
    
    pm(I5, M5) = MR1; dm(Izz4) = I5;           
    MY1 = dm(I2, M0); MR = MR1 * MY1 (rnd);
    MX1 = MR1; 


    // Cascade 5
    I4 = dm(Iz5); L4 = length(z5); I5 = dm(Izz5); L5 = length(zz5); I0 = ab5; L0 = length(ab5);
    MR = 0,MY0 = dm(I0, M0);
    MR = MX1 * MY0 (SU), MX0 = dm(I0, M0), MY0 = pm(I4, M4);
    MR = MR + MX0 * MY0 (SS), MX0 = dm(I0, M0); MY0 = pm(I4, M5);
    MR = MR - MX0 * MY0 (US),  MX0 = dm(I0, M0), MY0 = pm(I5, M4); 
    pm(I4, M5) = MX1; dm(Iz5) = I4;          
                     
    // IIR
    MR = MR + MX0 * MY0 (US), MX0 = dm(I0, M0); MY0 = pm(I5, M5); 
    MR = MR + MX0 * MY0 (SS); 
    MR = MR (rnd); if MV sat MR;
    
    pm(I5, M5) = MR1; dm(Izz5) = I5;           
    MY1 = dm(I2, M0); MR = MR1 * MY1 (rnd);
    MX1 = MR1; 

  
    IO(1) = MX1; // final
    rti;

