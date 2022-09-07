module clkdiv_TB ();

/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////
parameter WIDTH      = 4; // no of bits for dividing ratio
parameter CLK_PERIOD = 10;

/////////////////////////////////////////////////////////
//////////////////// DUT Signals ////////////////////////
/////////////////////////////////////////////////////////
reg                           CLK_TB;
reg                           RST_TB;  
reg                           CLK_en_TB;
reg          [WIDTH-1:0]      div_ratio_TB;
wire                          o_div_clk_TB;


////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial 
begin
 // System Functions
 $dumpfile("clkdiv.vcd") ;       
 $dumpvars;

// initialization
 initialize() ;

//Reset the design
 reset();   

// changing the clk div and enable 


CD_by_n(0100,1);
#(5*CLK_PERIOD);
//....... div by 5 and enable is on .......//
CD_by_n(0101,1);
#(6*CLK_PERIOD);


//....... enable off .......//
CD_by_n(0011,0);

#100 

$stop;
end








////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////

task initialize ;
 begin
  CLK_TB       = 1'b0  ; 
  CLK_en_TB    = 1'b0  ;

 end
endtask

///////////////////////// RESET /////////////////////////

task reset ;
 begin
  RST_TB = 1'b1  ;  
  #5
  RST_TB = 1'b0  ;  
  #5
  RST_TB = 1'b1  ;  
 end
endtask


///////////////////////// clk divider by n/////////////////////////
task CD_by_n;
input    [WIDTH-1:0]    d_ratio ;
input                   clk_en  ;

begin

CLK_en_TB    = clk_en ;
div_ratio_TB = d_ratio;
#(2*CLK_PERIOD) 


if (clk_en==0)
 begin
$display("****** Ref clock Mode is ~ON~ ******");
 end
else
 begin
 $display("****** dividing clock Mode by %0d is ~ON~ ******",d_ratio);  
 end
end
endtask


////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////

always #5 CLK_TB = ~CLK_TB ;


////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////


clkdiv DUT (
.i_ref_clk(CLK_TB),
.i_rst_n(RST_TB),
.i_clk_en(CLK_en_TB),
.i_div_ratio(div_ratio_TB),
.o_div_clk(o_div_clk_TB) 

);

endmodule