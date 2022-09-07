//  solution 1 : putting the combinational and sequential block together

module Up_Dn_Counterer (
input    wire     [4:0]   IN, 
input    wire             CLK,
input    wire             Load, 
input    wire             Up,
input    wire             Down,   
output   wire             High,
output   wire             Low,
output   reg      [4:0]   Counter

);

always @(posedge CLK ) 
begin
if (Load==1)
  begin
     Counter <= IN;
  end

else if (Down && !Low) 
  begin
     Counter <= Counter - 5'b1;      
  end

else if (Up && !High) 
  begin
     Counter <= Counter + 5'b1;
  end
end

assign High = (Counter ==5'd31);
assign Low  = (Counter ==5'd0);
endmodule