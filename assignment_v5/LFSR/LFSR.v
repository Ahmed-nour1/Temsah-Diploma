module lfsr (
input   wire   [3:0]  seed,
input   wire          RST,CLK,

output  reg           OUT,Valid
);
reg  [3:0] LFSR;
reg  [4:0] counter;
reg        SM_F,LM_F;

integer    i;
parameter  Taps =4'b1000 ;


// COUNTER FLAGS

always @(posedge CLK or negedge RST)

 begin
if (!RST || counter >5'd12)
  begin
        counter <= 5'b0;
        SM_F  <= 1'b0;
        LM_F  <= 1'b0;
  end
else
begin
    counter <= counter +1;
    if (counter==5'd8 && !LM_F) 
    begin
        LM_F <= 1'b1;   
    end
    else if (counter==5'd12)
    begin
        SM_F  <= 1'b1;
    end
 end
 end


 // LFSR
 always @(posedge CLK or negedge RST ) 
 begin
if (!RST) 
   begin
      LFSR <= seed ;  
   end

else if (!LM_F)
   begin
LFSR[2:0] <= LFSR >>1;
LFSR[3]   <= ((LFSR[0]^LFSR[1]) ^ LFSR[2]);
   end
else if (!SM_F)
  begin
    OUT   <= LFSR[0] ;
    LFSR  <= LFSR>>1 ;
    Valid <= 1;
  end
 end

    
endmodule