library verilog;
use verilog.vl_types.all;
entity regfile is
    generic(
        WIDTH           : integer := 16;
        DEPTH           : integer := 8;
        AddrW           : integer := 3
    );
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        RdEn            : in     vl_logic;
        WrEn            : in     vl_logic;
        Address         : in     vl_logic_vector;
        WrData          : in     vl_logic_vector;
        RdData          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DEPTH : constant is 1;
    attribute mti_svvh_generic_type of AddrW : constant is 1;
end regfile;
