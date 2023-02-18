`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2023 12:01:27 PM
// Design Name: 
// Module Name: tb
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


module tb;
    reg        CLK100MHZ;        // nexys clk signal
    reg         reset;          // btnC on nexys
    reg  [12:0] sw;      //for switch input
    reg      enable;  // for change of input between switches and sensor
    wire        TMP_SDA;     // i2c sda on temp sensor - bidirectional
    reg        SDA_receiver;
    wire       SDA_sender;
    wire       TMP_SCL;          // i2c scl on temp sensor
    wire [6:0]  SEG;             // 7 segments of each display
    wire [7:0]  AN;              // 4 anodes of 4 displays
    wire dp;            // 4 anodes always OFF
    wire [15:0]  LED ;             // nexys leds = binary temp in deg C
    wire  R;
    wire  G;
    wire  B;

assign TMP_SDA = SDA_receiver;
assign SDA_sender = TMP_SDA;
top uut(
    .CLK100MHZ(CLK100MHZ),
    .reset(reset),
    .sw(sw),
    .enable(enable),
    .TMP_SDA(TMP_SDA),
    .TMP_SCL(TMP_SCL),
    .SEG(SEG),
    .AN(AN),
    .dp(dp),
    .LED(LED),
    .R(R),
    .G(G),
    .B(B)

);

always
#5 
CLK100MHZ=~CLK100MHZ;
initial begin
#10 
CLK100MHZ=0;
enable=1;
sw=13'b1100110010011;
SDA_receiver=1;
#10 
enable=1;
sw=13'b0000000000001;
SDA_receiver=0;

#10 
enable=0;
sw=13'b1101110111011;
SDA_receiver=0;

#10 
enable=1;
sw=13'b1111111111111;
SDA_receiver=0;
end

endmodule
