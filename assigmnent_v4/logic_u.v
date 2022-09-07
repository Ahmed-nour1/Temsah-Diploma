module logic_u # (
    parameter WIDTH=16)
(
  input    wire                  CLK,
  input    wire                  L_EN,
  input    wire   [1:0]          ALU_fun_LU,
  input    wire   [WIDTH-1 :0]   IN1, 
  input    wire   [WIDTH-1 :0]   IN2, 
  output   reg    [WIDTH-1 :0]   Logic_Out,                 
  output   reg                   Logic_flag
);


always @(*) 
begin
    if (L_EN)
      begin
        Logic_flag = 1 ;
        case (ALU_fun_LU)
          2'b00:  Logic_Out             =   IN1 & IN2;
          2'b01:  Logic_Out             =   IN1 | IN2;
          2'b10:  Logic_Out             = ~(IN1 & IN2);
          2'b11:  Logic_Out             = ~(IN1 | IN2);
        
        endcase  
      end
    else
      begin
      Logic_Out  = 0; 
      Logic_flag = 0;
      end


    
end
    
endmodule