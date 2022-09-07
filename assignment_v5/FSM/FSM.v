module FSM (
    
input   wire Ac,Up_Max,Dn_Max,
input   wire  RST,CLK,

output  reg  UP_M,Dn_M
);

reg [1:0] current_state,
          next_state   ;

//state encoder 

localparam [1:0]  IDLE =2'b00,   // gray encoding to minimize 
                  Mv_Up=2'b01,   // the switching power
                  Mv_Dn=2'b11,
                  op_st=2'b10 ; 

// state transition (Sequential Block 0F FSM)
always @(posedge CLK or negedge RST ) 
begin
   if (!RST) 
  
    current_state <= IDLE;
    else
     current_state <= next_state;
end


// next state logic 

always @(*)
 begin
   case (current_state)
IDLE:
    begin
      if (Ac && Dn_Max &&!Up_Max) 
         begin
          next_state =Mv_Up ;
         end
      else if (Ac && !Dn_Max && Up_Max) 
        begin
           next_state =Mv_Dn ;   
        end
      else
         begin
         next_state =IDLE;  
         end
    end

Mv_Up: 
    begin
        if (Up_Max) 
         begin
          next_state =op_st ;
         end
        else  
         begin
            next_state =Mv_Up;  
         end   
    end

Mv_Dn: 
    begin
        if (Dn_Max) 
         begin
            next_state =op_st ;
         end
        else  
         begin
            next_state =Mv_Up;  
         end   
    end
    
    default: next_state = IDLE;
   endcase 
 end



 // output logic 


 always @(*)
begin
case (current_state)
   IDLE:begin
      UP_M =0;
      Dn_M =0;
        end 

   Mv_Up:begin
      UP_M =1;
      Dn_M =0;
        end  

   Mv_Dn:begin
      UP_M =0;
      Dn_M =1;
        end

default : begin
      UP_M =0;
      Dn_M =0;
          end

endcase  
end
 
endmodule