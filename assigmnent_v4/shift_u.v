module shift_u# (
    parameter   WIDTH =16)
(
  input    wire                  CLK,
  input    wire                  S_EN,
  input    wire   [1:0]          ALU_fun_SU,
  input    wire   [WIDTH-1 :0]   IN1, 
  input    wire   [WIDTH-1 :0]   IN2, 
  output   reg    [WIDTH-1 :0]   SHIFT_Out,                  
  output   reg                   SHIFT_Flag
);

always @(*) 
begin
    if (S_EN)
      begin
     SHIFT_Flag = 1 ;
        case (ALU_fun_SU)
          2'b00:  SHIFT_Out       = IN1 >>1;
          2'b01:  SHIFT_Out       = IN1 <<1;
          2'b10:  SHIFT_Out       = IN2 >>1;
          2'b11:  SHIFT_Out       = IN2 <<1;
        
        endcase  
      end
    else
      begin
     SHIFT_Out   = 0; 
     SHIFT_Flag = 0;
      end


    
end
endmodule