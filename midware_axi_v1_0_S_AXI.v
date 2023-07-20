`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/19 16:07:50
// Design Name: 
// Module Name: middleware
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module middleware #(
    // Users to add parameters here
    parameter TX_SIZE = 32,
    parameter RX_SIZE = 32,
    // User parameters ends
    // Do not modify the parameters beyond this line

    // Width of S_AXI data bus
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    // Width of S_AXI address bus
    parameter integer C_S_AXI_ADDR_WIDTH = 10
) (
    input wire i_TX_Start,

    input wire clk,
    input wire rstn,

    //AXI-Stream Master Port
    output wire [63 : 0] M_AXIS_TDATA,
    output wire          M_AXIS_TVALID,
    input  wire          M_AXIS_TREADY,
    output wire          M_AXIS_TLAST,

    //AXI-Stream Slave Port
    input  wire [63 : 0] S_AXIS_TDATA,
    input  wire          S_AXIS_TVALID,
    output wire          S_AXIS_TREADY,
    input  wire          S_AXIS_TLAST,



    //AXI-Lite Slave Port
    input  wire [    C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
    input  wire [                       2 : 0] S_AXI_AWPROT,
    input  wire                                S_AXI_AWVALID,
    output wire                                S_AXI_AWREADY,
    input  wire [    C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
    input  wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
    input  wire                                S_AXI_WVALID,
    output wire                                S_AXI_WREADY,
    output wire [                       1 : 0] S_AXI_BRESP,
    output wire                                S_AXI_BVALID,
    input  wire                                S_AXI_BREADY,
    input  wire [    C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
    input  wire [                       2 : 0] S_AXI_ARPROT,
    input  wire                                S_AXI_ARVALID,
    output wire                                S_AXI_ARREADY,
    output wire [    C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
    output wire [                       1 : 0] S_AXI_RRESP,
    output wire                                S_AXI_RVALID,
    input  wire                                S_AXI_RREADY
);
  reg [                    63:0] RX_buffer   [RX_SIZE-1:0];//S_AXI_Stream接收数据缓冲
  
  reg [10:0] rxed;//接受个数计数器


  // AXI4LITE signals
  reg [C_S_AXI_ADDR_WIDTH-1 : 0] axi_awaddr;
  reg                            axi_awready;
  reg                            axi_wready;
  reg [                   1 : 0] axi_bresp;
  reg                            axi_bvalid;
  reg [C_S_AXI_ADDR_WIDTH-1 : 0] axi_araddr;
  reg                            axi_arready;
  reg [C_S_AXI_DATA_WIDTH-1 : 0] axi_rdata;
  reg [                   1 : 0] axi_rresp;
  reg                            axi_rvalid;

  // Example-specific design signals
  // local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
  // ADDR_LSB is used for addressing 32/64 bit registers/memories
  // ADDR_LSB = 2 for 32 bits (n downto 2)
  // ADDR_LSB = 3 for 64 bits (n downto 3)
  localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH / 32) + 1;
  localparam integer OPT_MEM_ADDR_BITS = 7;
  //----------------------------------------------
  //-- Signals for user logic register space example
  //------------------------------------------------
  //-- Number of Slave Registers 138
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg0;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg1;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg2;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg3;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg4;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg5;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg6;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg7;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg8;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg9;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg10;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg11;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg12;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg13;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg14;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg15;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg16;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg17;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg18;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg19;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg20;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg21;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg22;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg23;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg24;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg25;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg26;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg27;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg28;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg29;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg30;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg31;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg32;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg33;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg34;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg35;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg36;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg37;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg38;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg39;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg40;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg41;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg42;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg43;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg44;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg45;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg46;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg47;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg48;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg49;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg50;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg51;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg52;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg53;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg54;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg55;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg56;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg57;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg58;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg59;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg60;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg61;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg62;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg63;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg64;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg65;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg66;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg67;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg68;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg69;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg70;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg71;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg72;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg73;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg74;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg75;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg76;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg77;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg78;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg79;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg80;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg81;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg82;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg83;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg84;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg85;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg86;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg87;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg88;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg89;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg90;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg91;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg92;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg93;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg94;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg95;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg96;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg97;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg98;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg99;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg100;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg101;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg102;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg103;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg104;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg105;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg106;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg107;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg108;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg109;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg110;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg111;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg112;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg113;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg114;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg115;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg116;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg117;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg118;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg119;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg120;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg121;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg122;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg123;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg124;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg125;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg126;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg127;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg128;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg129;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg130;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg131;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg132;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg133;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg134;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg135;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg136;
  reg     [C_S_AXI_DATA_WIDTH-1:0] slv_reg137;
  wire                             slv_reg_rden;
  wire                             slv_reg_wren;
  reg     [C_S_AXI_DATA_WIDTH-1:0] reg_data_out;
  integer                          byte_index;
  reg                              aw_en;

  // I/O Connections assignments

  assign S_AXI_AWREADY = axi_awready;
  assign S_AXI_WREADY  = axi_wready;
  assign S_AXI_BRESP   = axi_bresp;
  assign S_AXI_BVALID  = axi_bvalid;
  assign S_AXI_ARREADY = axi_arready;
  assign S_AXI_RDATA   = axi_rdata;
  assign S_AXI_RRESP   = axi_rresp;
  assign S_AXI_RVALID  = axi_rvalid;
  // Implement axi_awready generation
  // axi_awready is asserted for one clk clock cycle when both
  // S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
  // de-asserted when reset is low.

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      axi_awready <= 1'b0;
      aw_en       <= 1'b1;
    end else begin
      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) begin
        // slave is ready to accept write address when 
        // there is a valid write address and write data
        // on the write address and data bus. This design 
        // expects no outstanding transactions. 
        axi_awready <= 1'b1;
        aw_en       <= 1'b0;
      end else if (S_AXI_BREADY && axi_bvalid) begin
        aw_en       <= 1'b1;
        axi_awready <= 1'b0;
      end else begin
        axi_awready <= 1'b0;
      end
    end
  end

  // Implement axi_awaddr latching
  // This process is used to latch the address when both 
  // S_AXI_AWVALID and S_AXI_WVALID are valid. 

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      axi_awaddr <= 0;
    end else begin
      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) begin
        // Write Address latching 
        axi_awaddr <= S_AXI_AWADDR;
      end
    end
  end

  // Implement axi_wready generation
  // axi_wready is asserted for one clk clock cycle when both
  // S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
  // de-asserted when reset is low. 

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      axi_wready <= 1'b0;
    end else begin
      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en) begin
        // slave is ready to accept write data when 
        // there is a valid write address and write data
        // on the write address and data bus. This design 
        // expects no outstanding transactions. 
        axi_wready <= 1'b1;
      end else begin
        axi_wready <= 1'b0;
      end
    end
  end

  // Implement memory mapped register select and write logic generation
  // The write data is accepted and written to memory mapped registers when
  // axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
  // select byte enables of slave registers while writing.
  // These registers are cleared when reset (active low) is applied.
  // Slave register write enable is asserted when valid address and data are available
  // and the slave is ready to accept the write address and write data.
  assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      slv_reg0   <= 0;
      slv_reg1   <= 0;
      slv_reg2   <= 0;
      slv_reg3   <= 0;
      slv_reg4   <= 0;
      slv_reg5   <= 0;
      slv_reg6   <= 0;
      slv_reg7   <= 0;
      slv_reg8   <= 0;
      slv_reg9   <= 0;
      slv_reg10  <= 0;
      slv_reg11  <= 0;
      slv_reg12  <= 0;
      slv_reg13  <= 0;
      slv_reg14  <= 0;
      slv_reg15  <= 0;
      slv_reg16  <= 0;
      slv_reg17  <= 0;
      slv_reg18  <= 0;
      slv_reg19  <= 0;
      slv_reg20  <= 0;
      slv_reg21  <= 0;
      slv_reg22  <= 0;
      slv_reg23  <= 0;
      slv_reg24  <= 0;
      slv_reg25  <= 0;
      slv_reg26  <= 0;
      slv_reg27  <= 0;
      slv_reg28  <= 0;
      slv_reg29  <= 0;
      slv_reg30  <= 0;
      slv_reg31  <= 0;
      slv_reg32  <= 0;
      slv_reg33  <= 0;
      slv_reg34  <= 0;
      slv_reg35  <= 0;
      slv_reg36  <= 0;
      slv_reg37  <= 0;
      slv_reg38  <= 0;
      slv_reg39  <= 0;
      slv_reg40  <= 0;
      slv_reg41  <= 0;
      slv_reg42  <= 0;
      slv_reg43  <= 0;
      slv_reg44  <= 0;
      slv_reg45  <= 0;
      slv_reg46  <= 0;
      slv_reg47  <= 0;
      slv_reg48  <= 0;
      slv_reg49  <= 0;
      slv_reg50  <= 0;
      slv_reg51  <= 0;
      slv_reg52  <= 0;
      slv_reg53  <= 0;
      slv_reg54  <= 0;
      slv_reg55  <= 0;
      slv_reg56  <= 0;
      slv_reg57  <= 0;
      slv_reg58  <= 0;
      slv_reg59  <= 0;
      slv_reg60  <= 0;
      slv_reg61  <= 0;
      slv_reg62  <= 0;
      slv_reg63  <= 0;
      slv_reg64  <= 0;
      slv_reg65  <= 0;
      slv_reg66  <= 0;
      slv_reg67  <= 0;
      slv_reg68  <= 0;
      slv_reg69  <= 0;
      slv_reg70  <= 0;
      slv_reg71  <= 0;
      slv_reg72  <= 0;
      slv_reg73  <= 0;
      slv_reg74  <= 0;
      slv_reg75  <= 0;
      slv_reg76  <= 0;
      slv_reg77  <= 0;
      slv_reg78  <= 0;
      slv_reg79  <= 0;
      slv_reg80  <= 0;
      slv_reg81  <= 0;
      slv_reg82  <= 0;
      slv_reg83  <= 0;
      slv_reg84  <= 0;
      slv_reg85  <= 0;
      slv_reg86  <= 0;
      slv_reg87  <= 0;
      slv_reg88  <= 0;
      slv_reg89  <= 0;
      slv_reg90  <= 0;
      slv_reg91  <= 0;
      slv_reg92  <= 0;
      slv_reg93  <= 0;
      slv_reg94  <= 0;
      slv_reg95  <= 0;
      slv_reg96  <= 0;
      slv_reg97  <= 0;
      slv_reg98  <= 0;
      slv_reg99  <= 0;
      slv_reg100 <= 0;
      slv_reg101 <= 0;
      slv_reg102 <= 0;
      slv_reg103 <= 0;
      slv_reg104 <= 0;
      slv_reg105 <= 0;
      slv_reg106 <= 0;
      slv_reg107 <= 0;
      slv_reg108 <= 0;
      slv_reg109 <= 0;
      slv_reg110 <= 0;
      slv_reg111 <= 0;
      slv_reg112 <= 0;
      slv_reg113 <= 0;
      slv_reg114 <= 0;
      slv_reg115 <= 0;
      slv_reg116 <= 0;
      slv_reg117 <= 0;
      slv_reg118 <= 0;
      slv_reg119 <= 0;
      slv_reg120 <= 0;
      slv_reg121 <= 0;
      slv_reg122 <= 0;
      slv_reg123 <= 0;
      slv_reg124 <= 0;
      slv_reg125 <= 0;
      slv_reg126 <= 0;
      slv_reg127 <= 0;
      slv_reg128 <= 0;
      slv_reg129 <= 0;
      slv_reg130 <= 0;
      slv_reg131 <= 0;
      slv_reg132 <= 0;
      slv_reg133 <= 0;
      slv_reg134 <= 0;
      slv_reg135 <= 0;
      slv_reg136 <= 0;
      slv_reg137 <= 0;
    end else begin
      if (slv_reg_wren) begin
        case (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB])
          8'h00:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 0
              slv_reg0[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h01:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 1
              slv_reg1[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h02:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 2
              slv_reg2[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h03:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 3
              slv_reg3[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h04:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 4
              slv_reg4[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h05:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 5
              slv_reg5[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h06:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 6
              slv_reg6[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h07:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 7
              slv_reg7[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h08:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 8
              slv_reg8[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h09:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 9
              slv_reg9[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h0A:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 10
              slv_reg10[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h0B:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 11
              slv_reg11[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h0C:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 12
              slv_reg12[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h0D:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 13
              slv_reg13[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h0E:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 14
              slv_reg14[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h0F:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 15
              slv_reg15[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h10:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 16
              slv_reg16[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h11:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 17
              slv_reg17[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h12:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 18
              slv_reg18[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h13:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 19
              slv_reg19[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h14:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 20
              slv_reg20[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h15:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 21
              slv_reg21[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h16:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 22
              slv_reg22[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h17:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 23
              slv_reg23[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h18:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 24
              slv_reg24[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h19:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 25
              slv_reg25[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h1A:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 26
              slv_reg26[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h1B:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 27
              slv_reg27[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h1C:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 28
              slv_reg28[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h1D:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 29
              slv_reg29[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h1E:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 30
              slv_reg30[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h1F:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 31
              slv_reg31[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h20:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 32
              slv_reg32[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h21:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 33
              slv_reg33[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h22:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 34
              slv_reg34[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h23:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 35
              slv_reg35[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h24:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 36
              slv_reg36[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h25:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 37
              slv_reg37[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h26:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 38
              slv_reg38[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h27:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 39
              slv_reg39[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h28:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 40
              slv_reg40[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h29:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 41
              slv_reg41[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h2A:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 42
              slv_reg42[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h2B:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 43
              slv_reg43[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h2C:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 44
              slv_reg44[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h2D:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 45
              slv_reg45[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h2E:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 46
              slv_reg46[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h2F:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 47
              slv_reg47[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h30:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 48
              slv_reg48[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h31:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 49
              slv_reg49[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h32:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 50
              slv_reg50[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h33:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 51
              slv_reg51[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h34:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 52
              slv_reg52[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h35:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 53
              slv_reg53[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h36:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 54
              slv_reg54[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h37:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 55
              slv_reg55[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h38:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 56
              slv_reg56[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h39:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 57
              slv_reg57[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h3A:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 58
              slv_reg58[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h3B:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 59
              slv_reg59[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h3C:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 60
              slv_reg60[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h3D:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 61
              slv_reg61[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h3E:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 62
              slv_reg62[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h3F:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 63
              slv_reg63[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h40:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 64
              slv_reg64[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h41:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 65
              slv_reg65[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h42:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 66
              slv_reg66[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h43:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 67
              slv_reg67[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h44:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 68
              slv_reg68[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h45:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 69
              slv_reg69[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h46:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 70
              slv_reg70[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h47:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 71
              slv_reg71[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h48:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 72
              slv_reg72[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h49:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 73
              slv_reg73[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h4A:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 74
              slv_reg74[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h4B:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 75
              slv_reg75[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h4C:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 76
              slv_reg76[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h4D:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 77
              slv_reg77[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h4E:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 78
              slv_reg78[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h4F:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 79
              slv_reg79[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h50:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 80
              slv_reg80[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h51:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 81
              slv_reg81[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h52:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 82
              slv_reg82[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h53:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 83
              slv_reg83[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h54:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 84
              slv_reg84[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h55:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 85
              slv_reg85[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h56:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 86
              slv_reg86[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h57:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 87
              slv_reg87[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h58:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 88
              slv_reg88[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h59:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 89
              slv_reg89[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h5A:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 90
              slv_reg90[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h5B:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 91
              slv_reg91[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h5C:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 92
              slv_reg92[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h5D:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 93
              slv_reg93[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h5E:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 94
              slv_reg94[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h5F:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 95
              slv_reg95[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h60:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 96
              slv_reg96[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h61:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 97
              slv_reg97[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h62:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 98
              slv_reg98[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h63:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 99
              slv_reg99[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h64:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 100
              slv_reg100[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h65:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 101
              slv_reg101[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h66:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 102
              slv_reg102[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h67:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 103
              slv_reg103[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h68:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 104
              slv_reg104[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h69:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 105
              slv_reg105[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h6A:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 106
              slv_reg106[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h6B:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 107
              slv_reg107[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h6C:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 108
              slv_reg108[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h6D:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 109
              slv_reg109[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h6E:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 110
              slv_reg110[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h6F:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 111
              slv_reg111[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h70:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 112
              slv_reg112[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h71:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 113
              slv_reg113[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h72:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 114
              slv_reg114[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h73:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 115
              slv_reg115[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h74:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 116
              slv_reg116[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h75:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 117
              slv_reg117[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h76:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 118
              slv_reg118[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h77:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 119
              slv_reg119[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h78:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 120
              slv_reg120[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h79:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 121
              slv_reg121[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h7A:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 122
              slv_reg122[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h7B:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 123
              slv_reg123[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h7C:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 124
              slv_reg124[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h7D:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 125
              slv_reg125[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h7E:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 126
              slv_reg126[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h7F:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 127
              slv_reg127[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h80:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 128
              slv_reg128[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h81:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 129
              slv_reg129[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h82:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 130
              slv_reg130[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h83:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 131
              slv_reg131[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h84:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 132
              slv_reg132[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h85:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 133
              slv_reg133[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h86:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 134
              slv_reg134[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h87:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 135
              slv_reg135[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h88:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 136
              slv_reg136[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          8'h89:
          for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1)
            if (S_AXI_WSTRB[byte_index] == 1) begin
              // Respective byte enables are asserted as per write strobes 
              // Slave register 137
              slv_reg137[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
            end
          default: begin
            slv_reg0   <= slv_reg0;
            slv_reg1   <= slv_reg1;
            slv_reg2   <= slv_reg2;
            slv_reg3   <= slv_reg3;
            slv_reg4   <= slv_reg4;
            slv_reg5   <= slv_reg5;
            slv_reg6   <= slv_reg6;
            slv_reg7   <= slv_reg7;
            slv_reg8   <= slv_reg8;
            slv_reg9   <= slv_reg9;
            slv_reg10  <= slv_reg10;
            slv_reg11  <= slv_reg11;
            slv_reg12  <= slv_reg12;
            slv_reg13  <= slv_reg13;
            slv_reg14  <= slv_reg14;
            slv_reg15  <= slv_reg15;
            slv_reg16  <= slv_reg16;
            slv_reg17  <= slv_reg17;
            slv_reg18  <= slv_reg18;
            slv_reg19  <= slv_reg19;
            slv_reg20  <= slv_reg20;
            slv_reg21  <= slv_reg21;
            slv_reg22  <= slv_reg22;
            slv_reg23  <= slv_reg23;
            slv_reg24  <= slv_reg24;
            slv_reg25  <= slv_reg25;
            slv_reg26  <= slv_reg26;
            slv_reg27  <= slv_reg27;
            slv_reg28  <= slv_reg28;
            slv_reg29  <= slv_reg29;
            slv_reg30  <= slv_reg30;
            slv_reg31  <= slv_reg31;
            slv_reg32  <= slv_reg32;
            slv_reg33  <= slv_reg33;
            slv_reg34  <= slv_reg34;
            slv_reg35  <= slv_reg35;
            slv_reg36  <= slv_reg36;
            slv_reg37  <= slv_reg37;
            slv_reg38  <= slv_reg38;
            slv_reg39  <= slv_reg39;
            slv_reg40  <= slv_reg40;
            slv_reg41  <= slv_reg41;
            slv_reg42  <= slv_reg42;
            slv_reg43  <= slv_reg43;
            slv_reg44  <= slv_reg44;
            slv_reg45  <= slv_reg45;
            slv_reg46  <= slv_reg46;
            slv_reg47  <= slv_reg47;
            slv_reg48  <= slv_reg48;
            slv_reg49  <= slv_reg49;
            slv_reg50  <= slv_reg50;
            slv_reg51  <= slv_reg51;
            slv_reg52  <= slv_reg52;
            slv_reg53  <= slv_reg53;
            slv_reg54  <= slv_reg54;
            slv_reg55  <= slv_reg55;
            slv_reg56  <= slv_reg56;
            slv_reg57  <= slv_reg57;
            slv_reg58  <= slv_reg58;
            slv_reg59  <= slv_reg59;
            slv_reg60  <= slv_reg60;
            slv_reg61  <= slv_reg61;
            slv_reg62  <= slv_reg62;
            slv_reg63  <= slv_reg63;
            slv_reg64  <= slv_reg64;
            slv_reg65  <= slv_reg65;
            slv_reg66  <= slv_reg66;
            slv_reg67  <= slv_reg67;
            slv_reg68  <= slv_reg68;
            slv_reg69  <= slv_reg69;
            slv_reg70  <= slv_reg70;
            slv_reg71  <= slv_reg71;
            slv_reg72  <= slv_reg72;
            slv_reg73  <= slv_reg73;
            slv_reg74  <= slv_reg74;
            slv_reg75  <= slv_reg75;
            slv_reg76  <= slv_reg76;
            slv_reg77  <= slv_reg77;
            slv_reg78  <= slv_reg78;
            slv_reg79  <= slv_reg79;
            slv_reg80  <= slv_reg80;
            slv_reg81  <= slv_reg81;
            slv_reg82  <= slv_reg82;
            slv_reg83  <= slv_reg83;
            slv_reg84  <= slv_reg84;
            slv_reg85  <= slv_reg85;
            slv_reg86  <= slv_reg86;
            slv_reg87  <= slv_reg87;
            slv_reg88  <= slv_reg88;
            slv_reg89  <= slv_reg89;
            slv_reg90  <= slv_reg90;
            slv_reg91  <= slv_reg91;
            slv_reg92  <= slv_reg92;
            slv_reg93  <= slv_reg93;
            slv_reg94  <= slv_reg94;
            slv_reg95  <= slv_reg95;
            slv_reg96  <= slv_reg96;
            slv_reg97  <= slv_reg97;
            slv_reg98  <= slv_reg98;
            slv_reg99  <= slv_reg99;
            slv_reg100 <= slv_reg100;
            slv_reg101 <= slv_reg101;
            slv_reg102 <= slv_reg102;
            slv_reg103 <= slv_reg103;
            slv_reg104 <= slv_reg104;
            slv_reg105 <= slv_reg105;
            slv_reg106 <= slv_reg106;
            slv_reg107 <= slv_reg107;
            slv_reg108 <= slv_reg108;
            slv_reg109 <= slv_reg109;
            slv_reg110 <= slv_reg110;
            slv_reg111 <= slv_reg111;
            slv_reg112 <= slv_reg112;
            slv_reg113 <= slv_reg113;
            slv_reg114 <= slv_reg114;
            slv_reg115 <= slv_reg115;
            slv_reg116 <= slv_reg116;
            slv_reg117 <= slv_reg117;
            slv_reg118 <= slv_reg118;
            slv_reg119 <= slv_reg119;
            slv_reg120 <= slv_reg120;
            slv_reg121 <= slv_reg121;
            slv_reg122 <= slv_reg122;
            slv_reg123 <= slv_reg123;
            slv_reg124 <= slv_reg124;
            slv_reg125 <= slv_reg125;
            slv_reg126 <= slv_reg126;
            slv_reg127 <= slv_reg127;
            slv_reg128 <= slv_reg128;
            slv_reg129 <= slv_reg129;
            slv_reg130 <= slv_reg130;
            slv_reg131 <= slv_reg131;
            slv_reg132 <= slv_reg132;
            slv_reg133 <= slv_reg133;
            slv_reg134 <= slv_reg134;
            slv_reg135 <= slv_reg135;
            slv_reg136 <= slv_reg136;
            slv_reg137 <= slv_reg137;
          end
        endcase
      end

      //更新RX_buffer数据到寄存器中
      
        if (rxed>RX_SIZE) begin
          slv_reg1[0]<=1;
        end
      
      begin
        {slv_reg75, slv_reg74}   <= RX_buffer[0];
        {slv_reg77, slv_reg76}   <= RX_buffer[1];
        {slv_reg79, slv_reg78}   <= RX_buffer[2];
        {slv_reg81, slv_reg80}   <= RX_buffer[3];
        {slv_reg83, slv_reg82}   <= RX_buffer[4];
        {slv_reg85, slv_reg84}   <= RX_buffer[5];
        {slv_reg87, slv_reg86}   <= RX_buffer[6];
        {slv_reg89, slv_reg88}   <= RX_buffer[7];
        {slv_reg91, slv_reg90}   <= RX_buffer[8];
        {slv_reg93, slv_reg92}   <= RX_buffer[9];
        {slv_reg95, slv_reg94}   <= RX_buffer[10];
        {slv_reg97, slv_reg96}   <= RX_buffer[11];
        {slv_reg99, slv_reg98}   <= RX_buffer[12];
        {slv_reg101, slv_reg100} <= RX_buffer[13];
        {slv_reg103, slv_reg102} <= RX_buffer[14];
        {slv_reg105, slv_reg104} <= RX_buffer[15];
        {slv_reg107, slv_reg106} <= RX_buffer[16];
        {slv_reg109, slv_reg108} <= RX_buffer[17];
        {slv_reg111, slv_reg110} <= RX_buffer[18];
        {slv_reg113, slv_reg112} <= RX_buffer[19];
        {slv_reg115, slv_reg114} <= RX_buffer[20];
        {slv_reg117, slv_reg116} <= RX_buffer[21];
        {slv_reg119, slv_reg118} <= RX_buffer[22];
        {slv_reg121, slv_reg120} <= RX_buffer[23];
        {slv_reg123, slv_reg122} <= RX_buffer[24];
        {slv_reg125, slv_reg124} <= RX_buffer[25];
        {slv_reg127, slv_reg126} <= RX_buffer[26];
        {slv_reg129, slv_reg128} <= RX_buffer[27];
        {slv_reg131, slv_reg130} <= RX_buffer[28];
        {slv_reg133, slv_reg132} <= RX_buffer[29];
        {slv_reg135, slv_reg134} <= RX_buffer[30];
        {slv_reg137, slv_reg136} <= RX_buffer[31];


      end
    end
  end

  // Implement write response logic generation
  // The write response and response valid signals are asserted by the slave 
  // when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
  // This marks the acceptance of address and indicates the status of 
  // write transaction.

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      axi_bvalid <= 0;
      axi_bresp  <= 2'b0;
    end else begin
      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID) begin
        // indicates a valid write response is available
        axi_bvalid <= 1'b1;
        axi_bresp  <= 2'b0;  // 'OKAY' response 
      end                   // work error responses in future
      else
        begin
        if (S_AXI_BREADY && axi_bvalid) 
            //check if bready is asserted while bvalid is high) 
            //(there is a possibility that bready is always asserted high)   
            begin
          axi_bvalid <= 1'b0;
        end
      end
    end
  end

  // Implement axi_arready generation
  // axi_arready is asserted for one clk clock cycle when
  // S_AXI_ARVALID is asserted. axi_awready is 
  // de-asserted when reset (active low) is asserted. 
  // The read address is also latched when S_AXI_ARVALID is 
  // asserted. axi_araddr is reset to zero on reset assertion.

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      axi_arready <= 1'b0;
      axi_araddr  <= 32'b0;
    end else begin
      if (~axi_arready && S_AXI_ARVALID) begin
        // indicates that the slave has acceped the valid read address
        axi_arready <= 1'b1;
        // Read address latching
        axi_araddr  <= S_AXI_ARADDR;
      end else begin
        axi_arready <= 1'b0;
      end
    end
  end

  // Implement axi_arvalid generation
  // axi_rvalid is asserted for one clk clock cycle when both 
  // S_AXI_ARVALID and axi_arready are asserted. The slave registers 
  // data are available on the axi_rdata bus at this instance. The 
  // assertion of axi_rvalid marks the validity of read data on the 
  // bus and axi_rresp indicates the status of read transaction.axi_rvalid 
  // is deasserted on reset (active low). axi_rresp and axi_rdata are 
  // cleared to zero on reset (active low).  
  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      axi_rvalid <= 0;
      axi_rresp  <= 0;
    end else begin
      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid) begin
        // Valid read data is available at the read data bus
        axi_rvalid <= 1'b1;
        axi_rresp  <= 2'b0;  // 'OKAY' response
      end else if (axi_rvalid && S_AXI_RREADY) begin
        // Read data is accepted by the master
        axi_rvalid <= 1'b0;
      end
    end
  end

  // Implement memory mapped register select and read logic generation
  // Slave register read enable is asserted when valid address is available
  // and the slave is ready to accept the read address.
  assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
  always @(*) begin
    // Address decoding for reading registers
    case (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB])
      8'h00:   reg_data_out <= slv_reg0;
      8'h01:   reg_data_out <= slv_reg1;
      8'h02:   reg_data_out <= slv_reg2;
      8'h03:   reg_data_out <= slv_reg3;
      8'h04:   reg_data_out <= slv_reg4;
      8'h05:   reg_data_out <= slv_reg5;
      8'h06:   reg_data_out <= slv_reg6;
      8'h07:   reg_data_out <= slv_reg7;
      8'h08:   reg_data_out <= slv_reg8;
      8'h09:   reg_data_out <= slv_reg9;
      8'h0A:   reg_data_out <= slv_reg10;
      8'h0B:   reg_data_out <= slv_reg11;
      8'h0C:   reg_data_out <= slv_reg12;
      8'h0D:   reg_data_out <= slv_reg13;
      8'h0E:   reg_data_out <= slv_reg14;
      8'h0F:   reg_data_out <= slv_reg15;
      8'h10:   reg_data_out <= slv_reg16;
      8'h11:   reg_data_out <= slv_reg17;
      8'h12:   reg_data_out <= slv_reg18;
      8'h13:   reg_data_out <= slv_reg19;
      8'h14:   reg_data_out <= slv_reg20;
      8'h15:   reg_data_out <= slv_reg21;
      8'h16:   reg_data_out <= slv_reg22;
      8'h17:   reg_data_out <= slv_reg23;
      8'h18:   reg_data_out <= slv_reg24;
      8'h19:   reg_data_out <= slv_reg25;
      8'h1A:   reg_data_out <= slv_reg26;
      8'h1B:   reg_data_out <= slv_reg27;
      8'h1C:   reg_data_out <= slv_reg28;
      8'h1D:   reg_data_out <= slv_reg29;
      8'h1E:   reg_data_out <= slv_reg30;
      8'h1F:   reg_data_out <= slv_reg31;
      8'h20:   reg_data_out <= slv_reg32;
      8'h21:   reg_data_out <= slv_reg33;
      8'h22:   reg_data_out <= slv_reg34;
      8'h23:   reg_data_out <= slv_reg35;
      8'h24:   reg_data_out <= slv_reg36;
      8'h25:   reg_data_out <= slv_reg37;
      8'h26:   reg_data_out <= slv_reg38;
      8'h27:   reg_data_out <= slv_reg39;
      8'h28:   reg_data_out <= slv_reg40;
      8'h29:   reg_data_out <= slv_reg41;
      8'h2A:   reg_data_out <= slv_reg42;
      8'h2B:   reg_data_out <= slv_reg43;
      8'h2C:   reg_data_out <= slv_reg44;
      8'h2D:   reg_data_out <= slv_reg45;
      8'h2E:   reg_data_out <= slv_reg46;
      8'h2F:   reg_data_out <= slv_reg47;
      8'h30:   reg_data_out <= slv_reg48;
      8'h31:   reg_data_out <= slv_reg49;
      8'h32:   reg_data_out <= slv_reg50;
      8'h33:   reg_data_out <= slv_reg51;
      8'h34:   reg_data_out <= slv_reg52;
      8'h35:   reg_data_out <= slv_reg53;
      8'h36:   reg_data_out <= slv_reg54;
      8'h37:   reg_data_out <= slv_reg55;
      8'h38:   reg_data_out <= slv_reg56;
      8'h39:   reg_data_out <= slv_reg57;
      8'h3A:   reg_data_out <= slv_reg58;
      8'h3B:   reg_data_out <= slv_reg59;
      8'h3C:   reg_data_out <= slv_reg60;
      8'h3D:   reg_data_out <= slv_reg61;
      8'h3E:   reg_data_out <= slv_reg62;
      8'h3F:   reg_data_out <= slv_reg63;
      8'h40:   reg_data_out <= slv_reg64;
      8'h41:   reg_data_out <= slv_reg65;
      8'h42:   reg_data_out <= slv_reg66;
      8'h43:   reg_data_out <= slv_reg67;
      8'h44:   reg_data_out <= slv_reg68;
      8'h45:   reg_data_out <= slv_reg69;
      8'h46:   reg_data_out <= slv_reg70;
      8'h47:   reg_data_out <= slv_reg71;
      8'h48:   reg_data_out <= slv_reg72;
      8'h49:   reg_data_out <= slv_reg73;
      8'h4A:   reg_data_out <= slv_reg74;
      8'h4B:   reg_data_out <= slv_reg75;
      8'h4C:   reg_data_out <= slv_reg76;
      8'h4D:   reg_data_out <= slv_reg77;
      8'h4E:   reg_data_out <= slv_reg78;
      8'h4F:   reg_data_out <= slv_reg79;
      8'h50:   reg_data_out <= slv_reg80;
      8'h51:   reg_data_out <= slv_reg81;
      8'h52:   reg_data_out <= slv_reg82;
      8'h53:   reg_data_out <= slv_reg83;
      8'h54:   reg_data_out <= slv_reg84;
      8'h55:   reg_data_out <= slv_reg85;
      8'h56:   reg_data_out <= slv_reg86;
      8'h57:   reg_data_out <= slv_reg87;
      8'h58:   reg_data_out <= slv_reg88;
      8'h59:   reg_data_out <= slv_reg89;
      8'h5A:   reg_data_out <= slv_reg90;
      8'h5B:   reg_data_out <= slv_reg91;
      8'h5C:   reg_data_out <= slv_reg92;
      8'h5D:   reg_data_out <= slv_reg93;
      8'h5E:   reg_data_out <= slv_reg94;
      8'h5F:   reg_data_out <= slv_reg95;
      8'h60:   reg_data_out <= slv_reg96;
      8'h61:   reg_data_out <= slv_reg97;
      8'h62:   reg_data_out <= slv_reg98;
      8'h63:   reg_data_out <= slv_reg99;
      8'h64:   reg_data_out <= slv_reg100;
      8'h65:   reg_data_out <= slv_reg101;
      8'h66:   reg_data_out <= slv_reg102;
      8'h67:   reg_data_out <= slv_reg103;
      8'h68:   reg_data_out <= slv_reg104;
      8'h69:   reg_data_out <= slv_reg105;
      8'h6A:   reg_data_out <= slv_reg106;
      8'h6B:   reg_data_out <= slv_reg107;
      8'h6C:   reg_data_out <= slv_reg108;
      8'h6D:   reg_data_out <= slv_reg109;
      8'h6E:   reg_data_out <= slv_reg110;
      8'h6F:   reg_data_out <= slv_reg111;
      8'h70:   reg_data_out <= slv_reg112;
      8'h71:   reg_data_out <= slv_reg113;
      8'h72:   reg_data_out <= slv_reg114;
      8'h73:   reg_data_out <= slv_reg115;
      8'h74:   reg_data_out <= slv_reg116;
      8'h75:   reg_data_out <= slv_reg117;
      8'h76:   reg_data_out <= slv_reg118;
      8'h77:   reg_data_out <= slv_reg119;
      8'h78:   reg_data_out <= slv_reg120;
      8'h79:   reg_data_out <= slv_reg121;
      8'h7A:   reg_data_out <= slv_reg122;
      8'h7B:   reg_data_out <= slv_reg123;
      8'h7C:   reg_data_out <= slv_reg124;
      8'h7D:   reg_data_out <= slv_reg125;
      8'h7E:   reg_data_out <= slv_reg126;
      8'h7F:   reg_data_out <= slv_reg127;
      8'h80:   reg_data_out <= slv_reg128;
      8'h81:   reg_data_out <= slv_reg129;
      8'h82:   reg_data_out <= slv_reg130;
      8'h83:   reg_data_out <= slv_reg131;
      8'h84:   reg_data_out <= slv_reg132;
      8'h85:   reg_data_out <= slv_reg133;
      8'h86:   reg_data_out <= slv_reg134;
      8'h87:   reg_data_out <= slv_reg135;
      8'h88:   reg_data_out <= slv_reg136;
      8'h89:   reg_data_out <= slv_reg137;
      default: reg_data_out <= 0;
    endcase
  end

  // Output register or memory read data
  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      axi_rdata <= 0;
    end else begin
      // When there is a valid read address (S_AXI_ARVALID) with 
      // acceptance of read address by the slave (axi_arready), 
      // output the read dada 
      if (slv_reg_rden) begin
        axi_rdata <= reg_data_out;  // register read data
      end
    end
  end

  // Add user logic here

  // User logic ends

  //AXI-Stream Master

  wire [63 : 0] StreamTX_data;
  reg           m_axis_tdata_en;
  assign M_AXIS_TDATA = ((m_axis_tdata_en == 1) ? 64'hFFFFFFFF_FFFFFFFF : 64'h0) & StreamTX_data;

  reg m_axis_tvalid_reg;
  assign M_AXIS_TVALID = m_axis_tvalid_reg;

  wire TX_Start;
  reg TX_Start_ff, TX_Start_ff2;
  wire TX_Start_pulse;
  always @(posedge clk) begin
    if (!rstn) begin
      TX_Start_ff  <= 0;
      TX_Start_ff2 <= 0;
    end else begin
      TX_Start_ff  <= TX_Start;
      TX_Start_ff2 <= TX_Start_ff;
    end
  end
  assign TX_Start_pulse = (TX_Start_ff) & (~TX_Start_ff2);




  localparam M_AXIS_IDLE = 1;
  localparam M_AXIS_TREQ = 2;
  localparam M_AXIS_TTRS = 3;
  //parameter M_AXIS_IDLE=3;
  reg [6:0] current_state, next_state;
  reg [15:0] txed;

  always @(posedge clk) begin
    if (!rstn) begin
      current_state <= M_AXIS_IDLE;  // 复位后状态机处于空闲态       
    end else begin
      current_state <= next_state;  // 更新状态       
    end
  end

  always @(*) begin

    if ((current_state == M_AXIS_IDLE) && (TX_Start_pulse == 1'b1)) begin
      next_state = M_AXIS_TREQ;
    end else if ((current_state == M_AXIS_IDLE)) begin
      next_state = M_AXIS_IDLE;
    end

    if ((current_state == M_AXIS_TREQ) && (M_AXIS_TREADY == 1)) begin
      next_state = M_AXIS_TTRS;
    end else if ((current_state == M_AXIS_TREQ) && (M_AXIS_TREADY == 0)) begin
      next_state = M_AXIS_TREQ;
    end

    if ((current_state == M_AXIS_TTRS) && (txed < TX_SIZE)) begin
      next_state = M_AXIS_TTRS;
    end else if ((current_state == M_AXIS_TTRS)) begin
      next_state = M_AXIS_IDLE;
    end

  end

  always @(posedge clk) begin
    if (!rstn) begin
      m_axis_tdata_en   <= 0;
      m_axis_tvalid_reg <= 0;
      txed              <= 0;
    end else begin
      case (current_state)
        M_AXIS_IDLE: begin
          txed              <= 0;
          m_axis_tdata_en   <= m_axis_tdata_en;
          m_axis_tvalid_reg <= 0;
        end
        M_AXIS_TREQ: begin
          m_axis_tdata_en   <= 1;
          m_axis_tvalid_reg <= 1;
        end
        M_AXIS_TTRS: begin
          if (txed < TX_SIZE) begin
            txed = txed + 1;
          end else begin
            m_axis_tvalid_reg <= 0;
          end

        end

        default: begin
          current_state <= M_AXIS_IDLE;
        end
      endcase
    end
  end


  // Add user logic here
  assign TX_Start = slv_reg0[0];//i_TX_Start;  //仿真输入

  reg [63:0] StreamTX_data_reg;
  //  assign StreamTX_data = txed;//发送api
  assign StreamTX_data = StreamTX_data_reg;

  //M_AXIS 数据映射
  always @(*) begin
    case (txed)
      0:  StreamTX_data_reg = {slv_reg11, slv_reg10};
      1:  StreamTX_data_reg = {slv_reg13, slv_reg12};
      2:  StreamTX_data_reg = {slv_reg15, slv_reg14};
      3:  StreamTX_data_reg = {slv_reg17, slv_reg16};
      4:  StreamTX_data_reg = {slv_reg19, slv_reg18};
      5:  StreamTX_data_reg = {slv_reg21, slv_reg20};
      6:  StreamTX_data_reg = {slv_reg23, slv_reg22};
      7:  StreamTX_data_reg = {slv_reg25, slv_reg24};
      8:  StreamTX_data_reg = {slv_reg27, slv_reg26};
      9:  StreamTX_data_reg = {slv_reg29, slv_reg28};
      10: StreamTX_data_reg = {slv_reg31, slv_reg30};
      11: StreamTX_data_reg = {slv_reg33, slv_reg32};
      12: StreamTX_data_reg = {slv_reg35, slv_reg34};
      13: StreamTX_data_reg = {slv_reg37, slv_reg36};
      14: StreamTX_data_reg = {slv_reg39, slv_reg38};
      15: StreamTX_data_reg = {slv_reg41, slv_reg40};
      16: StreamTX_data_reg = {slv_reg43, slv_reg42};
      17: StreamTX_data_reg = {slv_reg45, slv_reg44};
      18: StreamTX_data_reg = {slv_reg47, slv_reg46};
      19: StreamTX_data_reg = {slv_reg49, slv_reg48};
      20: StreamTX_data_reg = {slv_reg51, slv_reg50};
      21: StreamTX_data_reg = {slv_reg53, slv_reg52};
      22: StreamTX_data_reg = {slv_reg55, slv_reg54};
      23: StreamTX_data_reg = {slv_reg57, slv_reg56};
      24: StreamTX_data_reg = {slv_reg59, slv_reg58};
      25: StreamTX_data_reg = {slv_reg61, slv_reg60};
      26: StreamTX_data_reg = {slv_reg63, slv_reg62};
      27: StreamTX_data_reg = {slv_reg65, slv_reg64};
      28: StreamTX_data_reg = {slv_reg67, slv_reg66};
      29: StreamTX_data_reg = {slv_reg69, slv_reg68};
      30: StreamTX_data_reg = {slv_reg71, slv_reg70};
      31: StreamTX_data_reg = {slv_reg73, slv_reg72};

      default: StreamTX_data_reg = 0;

    endcase
  end

  // User logic ends


  //AXI_Stream Slave
  reg s_axis_tready_reg;
  assign S_AXIS_TREADY = s_axis_tready_reg;

  reg [1:0] S_axis_current_state, S_axis_next_state;
  parameter [1:0] S_AXIS_IDLE = 1'b0, S_AXIS_READ = 1'b1;


  always @(posedge clk) begin
    if (!rstn) begin
      s_axis_tready_reg <= 0;
    end else begin
      if (S_AXIS_TVALID == 1) begin
        s_axis_tready_reg <= 1;
      end else begin
        s_axis_tready_reg <= 0;
      end
    end
  end

  // Add user logic here
  reg [63:0] midtemp;
  always @(posedge clk) begin
    if (!rstn) begin : rxinit
      integer i;
      for (i = 0; i < RX_SIZE; i = i + 1) begin
        RX_buffer[i] <= 0;
      end
      midtemp <= 0;
      rxed    <= 0;
    end else begin
      if (S_AXIS_TVALID && S_AXIS_TREADY) begin
        rxed            <= rxed + 1;
        RX_buffer[rxed] <= S_AXIS_TDATA;
        midtemp         <= S_AXIS_TDATA;
      end
    end
  end
  // User logic ends



endmodule