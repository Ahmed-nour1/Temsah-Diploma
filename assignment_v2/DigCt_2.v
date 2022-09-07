// using cont assign to implement the Combinational cct

module DigCt_2 (
input      wire        IN1,
input      wire        IN2,
input      wire        IN3,
input      wire        IN4,
input      wire        IN5, 
input      wire        CLK,
output     reg         OUT1,
output     reg         OUT2,
output     reg         OUT3

);

//Internal Wires
wire   D1,D2,D3;


//Sequential Block
always @(posedge CLK ) 
begin
    OUT1 <= D1 ;
    OUT2 <= D2 ;
    OUT3 <= D3 ;
end

//Combinational Block using cont assignment
assign D1=~((~(IN1|IN2))&IN3);
assign D2=~(IN2&IN3);
assign D3=(((~IN4)|IN3)|IN5); 



endmodule