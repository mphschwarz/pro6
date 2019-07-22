module AC_MOTOR_VECTOR_TIME(
	input CLK,
	input [bits - 1:0] U_STR,
	input [bits - 1:0] SIN_POSITIVE,
	input [bits - 1:0] SIN_NEGATIVE,
	output reg [14:0] T_1,
	output reg [14:0] T_2);

parameter bits = 12;
parameter f_clk = 100*10**6;
parameter f_tast = 5*10**3;
parameter t_tast = f_clk / f_tast;

parameter u_d = 2**bits - 1;
parameter sq = 7093;

reg [26:0] constant;
reg [38:0] t_1;
reg [38:0] t_2;

initial begin
	T_1 <= 0;
	T_2 <= 0;
	constant <= 0;
end

always @(U_STR) begin
	constant <= t_tast * U_STR;
end

always @(posedge CLK) begin
	t_1 <= constant * SIN_NEGATIVE;
end
always @(posedge CLK) begin
	T_1 <= t_1 / (2**24 - 1);
end

always @(posedge CLK) begin
	t_2 <= constant * SIN_POSITIVE;
end
always @(posedge CLK) begin
	T_2 <= t_2 / (2**24 - 1);
end


endmodule
