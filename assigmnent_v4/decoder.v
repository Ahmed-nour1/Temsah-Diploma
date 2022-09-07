module decoder (

input       wire      [1:0]   alu_fun_d,
output      reg       [3:0]   EN_Signals
// EN_Signals --> {Arith,Logic,CMP,Shift} respectivly 
);
always @(*) begin

 case (alu_fun_d)
    2'b00:  EN_Signals = 4'b1000;
    2'b01:  EN_Signals = 4'b0100;
    2'b10:  EN_Signals = 4'b0010;
    2'b11:  EN_Signals = 4'b0001;
    
endcase
       
end

endmodule