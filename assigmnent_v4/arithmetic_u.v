module arithmetic_u # (
    parameter   WIDTH =16)
(
  input    wire                  CLK,
  input    wire                  A_EN,
  input    wire   [1:0]          ALU_fun_AU,
  input    wire   [WIDTH-1 :0]   IN1, 
  input    wire   [WIDTH-1 :0]   IN2, 
  output   reg    [WIDTH-1 :0]   Arith_Out, 
  output   reg                   Carry_Out,                 
  output   reg                   Arith_flag
);

always @(*) 
begin
    if (A_EN)
      begin
        Arith_flag = 1 ;
        case (ALU_fun_AU)
          2'b00: {Carry_Out,Arith_Out}  = IN1 + IN2 ;
          2'b01:  Arith_Out             = IN1 - IN2 ;
          2'b10:  Arith_Out             = IN1 * IN2 ;
          2'b11:  Arith_Out             = IN1 / IN2 ;
        
        endcase  
      end
    else
      begin
      Arith_Out  = 0; 
      Arith_flag = 0;
      end


    
end
endmodule