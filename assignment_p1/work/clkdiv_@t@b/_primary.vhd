library verilog;
use verilog.vl_types.all;
entity clkdiv_TB is
    generic(
        WIDTH           : integer := 4;
        CLK_PERIOD      : integer := 10
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
end clkdiv_TB;
