module regfile #(
parameter WIDTH  =16,
           DEPTH =8,
           AddrW =3) 
                   
(
input      wire                CLK,RST,
input      wire                RdEn,WrEn,
input      wire   [AddrW-1:0]  Address,
input      wire   [WIDTH-1:0]  WrData,
output     reg    [WIDTH-1:0]  RdData

);
integer i;
reg [WIDTH-1:0] Reg_File  [DEPTH-1:0];

always @(posedge CLK or negedge RST)
begin
if (!RST)
    begin
       for ( i=0 ;i<DEPTH ;i=i+1) 
           begin
             Reg_File[i] <= 16'b0;
           end
    end
else if (WrEn && !RdEn) 
    begin
    Reg_File[Address] <= WrData ;
    end
else
    begin
     RdData <= Reg_File[Address] ;
    end
end





    
endmodule