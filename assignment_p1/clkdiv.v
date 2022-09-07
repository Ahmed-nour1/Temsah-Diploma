module clkdiv #(parameter Width =4 ) 
(
    input    wire                    i_ref_clk,
    input    wire                    i_rst_n,    
    input    wire                    i_clk_en,
    input    wire   [Width-1:0]      i_div_ratio,

    output   reg                     o_div_clk
);

// internal wires 
 reg    [Width-1:0] count ; 
 reg                h_flag,l_flag ;
 reg                o_div_clk_s;

//combinational block to choise between o/p

always @(*)
 begin
   if (i_clk_en==1 || !i_div_ratio=='b1)
    begin
      o_div_clk = o_div_clk_s  ;
    end   
   else if (i_clk_en==0 || i_div_ratio=='b1) 
    begin
    o_div_clk = i_ref_clk ;
    end
 end

// main block clock divider 
always @(posedge i_ref_clk or negedge i_rst_n )
 begin
    if (!i_rst_n)

        begin
         o_div_clk_s <= 0;  
        end

    else if (h_flag && !l_flag)
        begin
         o_div_clk_s <= 1'b1 ;   
        end
    else if (!h_flag && l_flag)
        begin
          o_div_clk_s <= 1'b0 ;
        end



   

    
 end

// counter and flags signals block 
 always @(negedge i_ref_clk or negedge i_rst_n )
  begin
  if (!i_rst_n )
   begin
      count  <= 1'b0 ;
      h_flag <= 1'b0 ;
      l_flag <= 1'b0 ;
   end


  else if (count == i_div_ratio)
  begin
      count  <= 1'b1 ;
      h_flag <= 1'b1 ;
      l_flag <= 1'b0 ;
  end

  else if ((count== i_div_ratio >>1) || l_flag) 
  begin
      h_flag <= 1'b0 ;
      l_flag <= 1'b1 ;  
      count  <= count +1'b1;
   end

  else 
  begin
     h_flag <= 1'b1 ;
     l_flag <= 1'b0 ;
     count  <= count +1'b1;
  end
  end




endmodule