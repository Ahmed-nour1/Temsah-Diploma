module ALU_TOP #(
parameter WIDTH =16)
(
  input    wire                       CLK,RST,
  input    wire       [3:0]           ALU_FUN,
  input    wire       [WIDTH-1:0]     A,B,      
  output   reg        [WIDTH-1:0]     Arith_Out,
  output   reg        [WIDTH-1:0]     Logic_Out,
  output   reg        [WIDTH-1:0]     CMP_Out,
  output   reg        [WIDTH-1:0]     SHIFT_Out,
  output   reg                        Carry_Out,
  output   reg        [3:0]           flags_reg

);
//********** internal wires **********\\ 
wire    [3:0] EN_D_out ;  // Contain the Enable Signals respectivly
                         // {Arith,Logic,CMP,SHIFT}
wire   [WIDTH-1:0]  Arith_Out_c,Logic_Out_c;
wire   [WIDTH-1:0]  CMP_Out_c,SHIFT_Out_c;
wire                Arith_F_c,Logic_F_c,Carry_Out_c;
wire                CMP_F_c,SHIFT_F_c; 
wire   [3:0]        flags_c;
 



assign  flags_c = {SHIFT_F_c,CMP_F_c,Logic_F_c,Arith_F_c} ;



//********** Sequential BLOCK "Registering Both (Output,Flags)" **********\\
always @(posedge CLK or negedge RST ) 
begin
    if (!RST) 
     begin
        Arith_Out <= 0;
        Carry_Out <= 0; 
        Logic_Out <= 0;
        CMP_Out   <= 0;
        SHIFT_Out <= 0;
        flags_reg <= 0;
     end
    else
     begin
        Arith_Out <= Arith_Out_c;
        Carry_Out <= Carry_Out_c; 
        Logic_Out <= Logic_Out_c;
        CMP_Out   <= CMP_Out_c;
        SHIFT_Out <= SHIFT_Out_c;
        flags_reg <= flags_c;
     end

    
end

//********** Module instantiation **********\\


decoder d_U (
.alu_fun_d(ALU_FUN[3:2]),
.EN_Signals(EN_D_out)
);

arithmetic_u A_U (
.IN1(A),
.IN2(B),
.CLK(CLK),
.A_EN(EN_D_out[3]),
.ALU_fun_AU(ALU_FUN[1:0]),
.Arith_Out(Arith_Out_c),
.Carry_Out(Carry_Out_c),
.Arith_flag(Arith_F_c)
);

logic_u L_U (
.IN1(A),
.IN2(B),
.CLK(CLK),
.L_EN(EN_D_out[2]),
.ALU_fun_LU(ALU_FUN[1:0]),
.Logic_Out(Logic_Out_c),
.Logic_flag(Logic_F_c)
);

cmp_u C_U (
.IN1(A),
.IN2(B),
.CLK(CLK),
.C_EN(EN_D_out[1]),
.ALU_fun_CU(ALU_FUN[1:0]),
.CMP_Out(CMP_Out_c),
.CMP_flag(CMP_F_c)
);



shift_u S_U (
.IN1(A),
.IN2(B),
.CLK(CLK),
.S_EN(EN_D_out[0]),
.ALU_fun_SU(ALU_FUN[1:0]),
.SHIFT_Out(SHIFT_Out_c),
.SHIFT_Flag(SHIFT_F_c)
);

endmodule