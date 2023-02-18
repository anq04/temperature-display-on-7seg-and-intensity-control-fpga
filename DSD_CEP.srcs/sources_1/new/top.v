`timescale 1ns / 1ps


module top(
    input         CLK100MHZ,        // nexys clk signal
    input         reset,            // btnC on nexys
    input  [12:0] switches,         //for switch input
    input         enable,     // for change of input between switches and sensor
    inout         TMP_SDA,          // i2c sda on temp sensor - bidirectional
    output        TMP_SCL,          // i2c scl on temp sensor
    output [6:0]  SEG,              // 7 segments of each display
    output [7:0]  AN,               // 4 anodes of 4 displays
    output dp,              // 4 anodes always OFF
    output [15:0]  LED,              // nexys leds = binary temp in deg C
    output  R,
    output  G,
    output  B
    );
    
    wire sda_dir;                   // direction of SDA signal - to or from master
    wire w_200kHz;                  // 200kHz SCL
    wire [15:0] w_data;              // 8 bits of temperature data
    // Instantiate i2c master
    i2c master(
        .clk_200kHz(w_200kHz),
        .reset(reset),
        .temp_data(w_data),
        .SDA(TMP_SDA),
        .SDA_dir(sda_dir),
        .SCL(TMP_SCL)
    );
    
    // Instantiate 200kHz clock generator
    clk cgen(
        .clk_100MHz(CLK100MHZ),
        .clk_200kHz(w_200kHz)
    );
    
    // Instantiate 7 segment control
    
    
    seven_seg seg_instance(.clk_100MHz(CLK100MHZ),
        .temp_data(w_data),
        .switch_data(switches),
        .switch(enable),
        .SEG(SEG),
        .AN(AN),
        .dp(dp));
    pwm pwm_instance(.clk(CLK100MHZ),
    .temp_data(w_data),
    .switch_data(switches),
     .switch(enable),
     .R(R),
     .G(G),
     .B(B));
     

    // Set LED value to temp data
    assign LED = w_data;

endmodule