module regfile_TB #
(parameter WIDTH=16,
           DEPTH=8,
           AddrW=3,
           CLK_PERIOD=10)
 ();

reg                 CLK_TB,RST_TB;
reg                 WrEn_TB,RdEn_TB;
reg     [AddrW-1:0] Addr_TB;
reg     [WIDTH-1:0] WrData_TB;
wire    [WIDTH-1:0] RdData_TB;


// initial block
initial
  begin
//initialize the inputs
 CLK_TB    = 1'b0 ;
 RST_TB    = 1'b1 ;
 Addr_TB   = 'b0 ;
 WrEn_TB   = 1'b0 ;
 RdEn_TB   = 1'b0 ;
 WrData_TB = 'b0;

// RST the memory 
 #(CLK_PERIOD/2)
   RST_TB=1'b0 ;
#(CLK_PERIOD/2)
   RST_TB=1'b1 ;  

//testing the write "1"
#(CLK_PERIOD)
WrEn_TB   =1'b1;
RdEn_TB   =1'b0;
WrData_TB ='d15;
Addr_TB   = 'd0;

//testing the Read "1"
#(CLK_PERIOD)
WrEn_TB   =1'b0;
RdEn_TB   =1'b1;
Addr_TB   = 'd0;

if (RdData_TB=='d15)
    $display("**** Test Case 1 Succeed ****");
else
    $display("**** Test Case 1 Failed ****");
///////////****************//////////////
//testing the write "2"
#(CLK_PERIOD)
WrEn_TB   =1'b1;
RdEn_TB   =1'b0;
WrData_TB ='d39;
Addr_TB   = 'd5;

//testing the Read "2"
#(CLK_PERIOD)
WrEn_TB   =1'b0;
RdEn_TB   =1'b1;
Addr_TB   = 'd5;

if (RdData_TB=='d39)
    $display("**** Test Case 2 Succeed ****");
else
    $display("**** Test Case 2 Failed ****");

#100
$finish ;

  end







// generate CLK 
always #(CLK_PERIOD/2) CLK_TB = ~CLK_TB;

// DUT 

regfile DUT (
.CLK(CLK_TB),
.RST(RST_TB),
.RdEn(RdEn_TB),
.WrEn(WrEn_TB),
.WrData(WrData_TB),
.RdData(RdData_TB),
.Address(Addr_TB));

    

    
endmodule