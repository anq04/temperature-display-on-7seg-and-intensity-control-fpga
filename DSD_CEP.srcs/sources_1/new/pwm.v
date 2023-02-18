`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2023 11:55:18 AM
// Design Name: 
// Module Name: pwm
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


module pwm(
input [15:0] temp_data,
input [12:0] switch_data,
input switch,
input clk,
output reg R,
output reg G,
output reg B);
reg [7:0] counter; //max temperature 255
reg signed [8:0] data; 
reg [12:0] temp; //for neg values
initial counter = 0;
always@(posedge clk)
begin
case(switch)
    1'b1:begin
    temp[12:0]<= temp_data[15:3];
end
    1'b0:begin
    temp[12:0]<= switch_data[12:0];
end
endcase

case(temp[12])
    1'b0:begin
    data[8:0]<=temp[12:4];
end
1'b1:begin
    if(temp[3:0]==0)
    data[8:0]<=temp[12:4];
else
    data[8:0]<=temp[12:4]+1;
end
endcase


if (counter<255)
    counter<=counter+1;
else
    counter<=0;
if (data>=-40 & data<10)
begin
if (data<-30)
begin
    R <= (counter<20)? 0:0; G <= (counter<20)? 1:0; B <= (counter<20)? 0:0;
end
else if (data<-20)
begin
    R <= (counter<40)? 0:0; G <= (counter<40)? 1:0; B <= (counter<40)? 0:0;
end
else if (data<-10)
begin
    R <= (counter<60)? 0:0; G <= (counter<60)? 1:0; B <= (counter<60)? 1:0;
end
else if (data<10)
begin
    R <= (counter<80)? 0:0; G <= (counter<80)? 1:0; B <= (counter<80)? 1:0;
end
end
if (data>=10 & data<40)
begin
if (data<20)
begin
    R <= (counter<20)? 1:0; G <= (counter<20)? 0:0; B <= (counter<20)? 0:0; 
end
else if (data<25)
begin
    R <= (counter<40)? 1:0; G <= (counter<40)? 0:0; B <= (counter<40)? 0:0;
end
else if (data<30)
begin
    R <= (counter<60)? 1:0; G <= (counter<60)? 0:0; B <= (counter<60)? 0:0;
end
else if (data<40)
begin
    R <= (counter<80)? 1:0; G <= (counter<80)? 1:0; B <= (counter<80)? 0:0;
end
end
if (data>=40 & data<80)
begin
if (data<50)
begin
    R <= (counter<20)? 1:0; G <= (counter<20)? 0:0; B <= (counter<20)? 0:0;
end
else if (data<60)
begin
    R <= (counter<40)? 1:0; G <= (counter<40)? 0:0; B <= (counter<40)? 0:0;
end
else if (data<70)
begin
    R <= (counter<60)? 1:0; G <= (counter<60)? 0:0; B <= (counter<60)? 0:0;
end
else if (data<80)
begin
    R <= (counter<60)? 1:0; G <= (counter<60)? 0:0; B <= (counter<60)? 0:0;
end
end
end
endmodule

