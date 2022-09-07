
module ALU_TOP_TB ();


parameter CLK_PERIOD = 10;


//********** internal wires **********\\ 
 reg                   CLK_TB;
 reg                   RST_TB;
 reg   [15:0]          A_TB;
 reg   [15:0]          B_TB;   
 reg   [3:0]           ALU_FUN_TB; 
 wire  [15:0]          Arith_Out_TB;
 wire  [15:0]          Logic_Out_TB;
 wire  [15:0]          CMP_Out_TB;
 wire  [15:0]          SHIFT_Out_TB;
 wire                  Carry_Out_TB;
 wire  [3:0]           flags_reg_TB;
 reg   [7:0]            counter ;
//********** initial Block  **********\\
initial
begin
$dumpfile("ALU_TOP.vcd");
$dumpvars ;
// initial values 
CLK_TB = 0;
RST_TB = 1; // ACTIVE LOW 
A_TB   = 'd0;
B_TB   = 'd0;
ALU_FUN_TB=0;
counter =0 ;

// Reset the output signals and flags
RST_TB = 0 ;
#(CLK_PERIOD)
RST_TB = 1 ;

//////////////////////~~~Testing~~~\\\\\\\\\\\\\\\\\\\\

//////////~~[1.1] Addition 
#(CLK_PERIOD/2)
$display ("*** TEST CASE 1 ~Arithmetic~  ***");

ALU_FUN_TB = 4'b0000 ;
A_TB ='d15 ;
B_TB ='d15 ;

#(CLK_PERIOD)
if (Arith_Out_TB == 16'd30 && flags_reg_TB ==4'd1)
 begin
    $display ("Addition IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Addition IS FAILED") ;
 end

//////////~~[1.2] Subtraction
$display ("*** TEST CASE 2 ~Arithmetic~  ***");
ALU_FUN_TB = 4'b0001 ;
A_TB ='d65 ;
B_TB ='d15 ;

#(CLK_PERIOD)
if (Arith_Out_TB == 16'd50&& flags_reg_TB ==4'd1)
 begin
    $display ("Subtraction IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Subtraction IS FAILED") ;
 end


//////////~~[1.3] Multiplication
$display ("*** TEST CASE 3 ~Arithmetic~  ***");
ALU_FUN_TB = 4'b0010 ;
A_TB ='d8 ;
B_TB ='d9;

#(CLK_PERIOD)
if (Arith_Out_TB == 16'd72&& flags_reg_TB ==4'd1)
 begin
    $display ("Multiplication IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Multiplication IS FAILED") ;
 end

//////////~~[1.4] Division
$display ("*** TEST CASE 4  ~Arithmetic~ ***");
ALU_FUN_TB = 4'b0011 ;
A_TB ='d80 ;
B_TB ='d10;

#(CLK_PERIOD)
if (Arith_Out_TB == 16'd8 && flags_reg_TB ==4'd1)
 begin
    $display ("Division IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Division IS FAILED") ;
 end

//////////~~[2.1] ANDING
$display ("*** TEST CASE 5 ~Logic~ ***");
ALU_FUN_TB = 4'b0100;
A_TB ='d15 ;
B_TB ='d8;
#(CLK_PERIOD)
if (Logic_Out_TB == 'd8 && flags_reg_TB ==4'd2)
 begin
    $display ("ANDING IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("ANDING IS FAILED") ;
 end

 //////////~~[2.2] ORING
$display ("*** TEST CASE 6 ~Logic~ ***");
ALU_FUN_TB = 4'b0101;
A_TB ='d7 ;
B_TB ='d8;
#(CLK_PERIOD)
if (Logic_Out_TB == 'd15 && flags_reg_TB ==4'd2)
 begin
    $display ("ORING IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("ORING IS FAILED") ;
 end
 
 //////////~~[2.3] NANDING
$display ("*** TEST CASE 7 ~Logic~ ***");
ALU_FUN_TB = 4'b0110;
A_TB ='d65535 ; //ALL ONES 
B_TB ='d65532;  // ALL ONES EXCEPT THE FIRST 2 BITS 
#(CLK_PERIOD)
if (Logic_Out_TB == 'd3 && flags_reg_TB ==4'd2)
 begin
    $display ("NANDING IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("NANDING IS FAILED") ;
 end

  //////////~~[2.4] NORING
$display ("*** TEST CASE 8 ~Logic~ ***");
ALU_FUN_TB = 4'b0111;
A_TB ='d65534 ; // ALL ONES  EXCEPT LSB
B_TB ='d2;
#(CLK_PERIOD)
if (Logic_Out_TB == 'd1 && flags_reg_TB ==4'd2)
 begin
    $display ("NORING IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("NORING IS FAILED") ;
 end

   //////////~~[3.1] CMP "NOP"
$display ("*** TEST CASE 9 ~CMP~ ***");
ALU_FUN_TB = 4'b1000;
A_TB ='d5;
B_TB ='d2;
#(CLK_PERIOD)
if (CMP_Out_TB == 'd0 && flags_reg_TB ==4'd4)
 begin
    $display ("NOP IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("NOP IS FAILED") ;
 end

    //////////~~[3.2] CMP "Equality"
$display ("*** TEST CASE 10 ~CMP~ ***");
ALU_FUN_TB = 4'b1001;
A_TB ='d5;
B_TB ='d5;
#(CLK_PERIOD)
if (CMP_Out_TB == 'd1 && flags_reg_TB ==4'd4)
 begin
    $display ("Equality IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Equality IS FAILED") ;
 end

     //////////~~[3.3] CMP "Greather than"
$display ("*** TEST CASE 11 ~CMP~ ***");
ALU_FUN_TB = 4'b1010;
A_TB ='d8;
B_TB ='d5;
#(CLK_PERIOD)
if (CMP_Out_TB == 'd2 && flags_reg_TB ==4'd4)
 begin
    $display ("Greather than IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Greather than  IS FAILED") ;
 end

     //////////~~[3.4] CMP "Greather than"
$display ("*** TEST CASE 12 ~CMP~ ***");
ALU_FUN_TB = 4'b1011;
A_TB ='d2;
B_TB ='d5;
#(CLK_PERIOD)
if (CMP_Out_TB == 'd3 && flags_reg_TB ==4'd4)
 begin
    $display ("Less than IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Less than IS FAILED") ;
 end

      //////////~~[4.1] Shift_R  A
$display ("*** TEST CASE 13 ~SHIFT~ ***");
ALU_FUN_TB = 4'b1100;
A_TB ='d8;
B_TB ='d5;
#(CLK_PERIOD)
if (SHIFT_Out_TB == 'd4 && flags_reg_TB ==4'd8)
 begin
    $display ("Shift_R A reg IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Shift_R A reg  IS FAILED") ;
 end

       //////////~~[4.2] Shift_L  A
$display ("*** TEST CASE 14 ~SHIFT~ ***");
ALU_FUN_TB = 4'b1101;
A_TB ='d4;
B_TB ='d5;
#(CLK_PERIOD)
if (SHIFT_Out_TB == 'd8 && flags_reg_TB ==4'd8)
 begin
    $display ("Shift_L A reg IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Shift_L A reg  IS FAILED") ;
 end

      //////////~~[4.3] Shift_R  B
$display ("*** TEST CASE 15 ~SHIFT~ ***");
ALU_FUN_TB = 4'b1110;
A_TB ='d8;
B_TB ='d7;
#(CLK_PERIOD)
if (SHIFT_Out_TB == 'd3 && flags_reg_TB ==4'd8)
 begin
    $display ("Shift_R B reg IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Shift_R B reg  IS FAILED") ;
 end

       //////////~~[4.4] Shift_L  B
$display ("*** TEST CASE 16 ~SHIFT~ ***");
ALU_FUN_TB = 4'b1111;
A_TB ='d4;
B_TB ='d7;
#(CLK_PERIOD)
if (SHIFT_Out_TB == 'd14 && flags_reg_TB ==4'd8)
 begin
    $display ("Shift_L B reg IS PASSED") ;
    counter = counter +1;
 end
else
 begin
    $display ("Shift_L B reg  IS FAILED") ;
 end

if (counter==8'd16) 
begin
    $display ("*** ALL TESTS SUCCEED ***");
end
else
begin
    $display ("*** THERE IS AN ERROR in the design ***");
end
#(2*CLK_PERIOD)
$finish;
end





//********** Customize Clock Generator 4/6 duty cycle  **********\\
always #(4)
 begin
 CLK_TB = 1;
 #6
 CLK_TB = 0;
 end
    




//********** Module instantiation **********\\~~> DUT
ALU_TOP  DUT (
.A(A_TB),
.B(B_TB),
.CLK(CLK_TB),
.RST(RST_TB),
.ALU_FUN(ALU_FUN_TB),
.Arith_Out(Arith_Out_TB),
.Logic_Out(Logic_Out_TB),
.CMP_Out(CMP_Out_TB),
.SHIFT_Out(SHIFT_Out_TB),
.flags_reg(flags_reg_TB),
.Carry_Out(Carry_Out_TB)
);

endmodule