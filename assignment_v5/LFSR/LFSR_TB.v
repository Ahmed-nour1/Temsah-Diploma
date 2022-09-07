

module LFSR_TB ();


reg [3:0] seed_TB;
reg       RST_TB,CLK_TB;

wire      OUT_TB,Valid_TB;



parameter CLK_Period =10;

initial
 begin
    //initial values
  CLK_TB  = 1'b0;
  RST_TB  = 1'b1;
  seed_TB = 4'b0;
// testing the RST
  #(CLK_Period);
  RST_TB  = 1'b0;
  seed_TB = 4'b1001;

  #(CLK_Period);
  RST_TB  = 1'b1;

 #(9*CLK_Period);
 



 end

// DUT
lfsr DUT (
.seed(seed_TB),
.RST(RST_TB),
.CLK(CLK_TB),
.OUT(OUT_TB),
.Valid(Valid_TB)
);


// clk generator

always #(CLK_Period/2) CLK_TB = ~CLK_TB;



    
endmodule