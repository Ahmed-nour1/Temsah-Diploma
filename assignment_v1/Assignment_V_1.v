module Assignment_V_1 (

input  wire  IN1  , IN2  , IN3 , IN4 , IN5 ,
input  wire  CLK
  ,
output reg   OUT1 , OUT2 , OUT3

);

// internal Wires D1 , D2 , D3 

reg D1 , D2 , D3 ;

// Sequential BLOCK 
always @(posedge CLK
 ) 
begin
 OUT1 <= D1 ; 
end

always @(posedge CLK
 ) 
begin
 OUT2 <= D2 ; 
end


always @(posedge CLK
 ) 
begin
 OUT3 <= D3 ; 
end

//

// Combinational BLOCK
always @(*) 
begin
    D1=~((~(IN1|IN2))&IN3);
end

always @(*) 
begin
    D2=~(IN2&IN3);
end

always @(*) 
begin
    D3=(((~IN4)|IN3)|IN5); 
end
endmodule


