/*
// Module: ALU_16bit_tb.v
// Description: test bench to verify the 16bits ALU  //
// Version : 1.0
// Date : August 2022
// --------------------------- */


module ALU_16bit_tb ()
`timescale 1us/1us ;
parameter   WIDTH =   16; 
parameter   WFUN  =   4;
parameter   WFLAG =   4;

//all design inputs in testbench are defined in reg
//all design outpute in testbench are defined in wire

reg       [WIDTH-1:0]      A_tb ;
reg       [WIDTH-1:0]      B_tb ;
reg       [WFUN-1:0]       ALU_FUN_tb;
reg                        CLK_tb;
wire                       Arith_Flag_tb;
wire                       Logic_Flag_tb;
wire                       CMP_Flag_tb;
wire                       Shift_Flag_tb;
wire      [WIDTH-1:0]      ALU_OUT_tb;
wire      [WFLAG-1:0]      Flags_out_tb;
 

//////////// initial block 
 initial begin
$dumpfile("ALU_16bit.vcd") ;
$dumpvars;

//////////// given inital values
   A_tb = 16'd10 ;
   B_tb = 16'd5 ;
   ALU_FUN_tb= 4'b0000;
   CLK_tb=1'b0;

// testing arthimatic block



// testing logic block
    $display("Test Case 2");
#5
   ALU_FUN_tb= 4'b0101;
#10

   if (ALU_OUT_tb == 16'd15) 
      begin
            $display(" Test Case  2 succed ");
      end
   else 
      begin
            $display(" Test Case 2 failed ");
      end

// testing comparison block
    $display("Test Case 3");
#6
   ALU_FUN_tb= 4'b1011;
#12
   if (ALU_OUT_tb == 16'd2) 
      begin
            $display("Test Case  3 succed");
      end
   else 
      begin
            $display("Test Case 3 failed");
      end

// testing shift block
#7
    ALU_FUN_tb=4'b1110;
#14
     if (ALU_OUT_tb == 16'd40)
      begin
           $display("Test Case  4 succed");
      end
    else 
      begin
           $display("Test Case 4 failed");
       end

  
  #100
  $finish;

 end 














 // clock generator 
 always #5 CLK_tb = ! CLK_tb ;

 //DUT instantation 
ALU_16bit DUT3 (
.A(A_tb),
.B(B_tb),
.CLK(CLK_tb),
.ALU_FUN(ALU_FUN_tb),
.Arith_Flag(Arith_Flag_tb),
.Logic_Flag(Logic_Flag_tb),
.CMP_Flag(CMP_Flag_tb),
.Shift_Flag(Shift_Flag_tb),
.ALU_OUT(ALU_OUT_tb),
.Flags_out(Flags_out_tb)
);



    
endmodule