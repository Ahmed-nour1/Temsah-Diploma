module cmp_u # (
    parameter   WIDTH =16)
(
  input    wire                  CLK,
  input    wire                  C_EN,
  input    wire   [1:0]          ALU_fun_CU,
  input    wire   [WIDTH-1 :0]   IN1, 
  input    wire   [WIDTH-1 :0]   IN2, 
  output   reg    [WIDTH-1 :0]   CMP_Out,                  
  output   reg                   CMP_flag
);

always @(*) 
begin
    if (C_EN)
      begin
     CMP_flag = 1 ;
        case (ALU_fun_CU)
          2'b00:  CMP_Out       = 0;
          2'b01:  CMP_Out       =(IN1==IN2)? 'd1:0;
          2'b10:  CMP_Out       =(IN1>IN2)?  'd2:0;
          2'b11:  CMP_Out       =(IN1<IN2)?  'd3:0;
        
        endcase  
      end
    else
      begin
     CMP_Out  = 0; 
     CMP_flag = 0;
      end


    
end
endmodule