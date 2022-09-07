`timescale 1ns/1ps

module FSM_TB ();

parameter  CLK_PERIOD =20 ;
reg    CLK_TB;
reg    RST_TB;
reg    AC_TB;
reg    Up_Max_TB,Dn_Max_TB;

wire   UP_M_TB,Dn_M_TB;



initial 
begin
//initial values
AC_TB     =1'b0;
Up_Max_TB =1'b0;
Dn_Max_TB =1'b0;
CLK_TB    =1'b0;
RST_TB    =1'b1;

//Test RESET
#(CLK_PERIOD)
RST_TB  =1'b0;
#(CLK_PERIOD)
RST_TB  =1'b1;

//TESTING THE DOWN 
AC_TB = 1'b1;
Dn_Max_TB=1'b1;
Up_Max_TB=1'b0;
#(2*CLK_PERIOD)

if (Dn_M_TB ==1) 
begin
  $display(" Test is 10/10 ") ; 
end
else
begin
  $display(" Test is 0/10 "); 
end
end
// generate clk

always #(CLK_PERIOD/2) CLK_TB=~CLK_TB;


// generate DUT 

FSM DUT (
.Ac(AC_TB),
.Up_Max(Up_Max_TB),
.Dn_Max(Dn_Max_TB),
.RST(RST_TB),
.CLK(CLK_TB),
.UP_M(UP_M_TB),
.Dn_M(Dn_M_TB));



endmodule