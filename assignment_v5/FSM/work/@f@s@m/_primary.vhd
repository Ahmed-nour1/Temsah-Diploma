library verilog;
use verilog.vl_types.all;
entity FSM is
    port(
        Ac              : in     vl_logic;
        Up_Max          : in     vl_logic;
        Dn_Max          : in     vl_logic;
        RST             : in     vl_logic;
        CLK             : in     vl_logic;
        UP_M            : out    vl_logic;
        Dn_M            : out    vl_logic
    );
end FSM;
