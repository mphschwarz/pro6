module AC_MOTOR_VECTOR_TIME(
	input CLK,
	input [2:0] SECTOR,
	input [bits - 1:0] U_STR,
	input [bits - 1:0] SIN_POSITIVE,
	input [bits - 1:0] SIN_NEGATIVE,
	output reg [14:0] T_0,
	output reg [14:0] T_1,
	output reg [14:0] T_2,
	output reg [14:0] T_7);

parameter bits = 12;
parameter f_clk = 100*10**6;
parameter f_tast = 10*10**3;
parameter t_tast = f_clk / f_tast;

parameter u_d = 2**bits - 1;

reg [26:0] constant;
reg [38:0] t_0;
reg [38:0] t_0_temp_2;
reg [38:0] t_0_temp_3;
reg [38:0] t_1;
reg [38:0] t_1_temp_1;
reg [38:0] t_1_temp_2;
reg [38:0] t_2;
reg [38:0] t_2_temp_1;
reg [38:0] t_2_temp_2;

initial begin
	T_0 <= 0;
	t_0 <= 0;
	t_0_temp_2 <= 0;
	T_1 <= 0;
	t_1 <= 0;
	t_1_temp_1 <= 0;
	t_1_temp_2 <= 0;
	T_2 <= 0;
	t_2 <= 0;
	T_7 <= 0;
	constant <= 0;
end

always @(U_STR) begin
	constant <= t_tast * U_STR;
end

always @(posedge CLK) begin
	// in odd sectors, t_1 and t_2 are switched
	if (SECTOR[0]) begin 
		t_1_temp_1 <= constant * SIN_POSITIVE;
		t_2_temp_1 <= constant * SIN_NEGATIVE;
	end else begin
		t_1_temp_1 <= constant * SIN_NEGATIVE;
		t_2_temp_1 <= constant * SIN_POSITIVE;
	end
end

always @(posedge CLK) begin
	t_0_temp_2 <= (2**24 - 1) * t_tast - t_2_temp_1;
	t_1_temp_2 <= t_1_temp_1;
	t_2_temp_2 <= t_2_temp_1;
end

always @(posedge CLK) begin
	t_0 <= t_0_temp_2 - t_1_temp_2;
	t_1 <= t_1_temp_2;
	t_2 <= t_2_temp_2;
end

always @(posedge CLK) begin
	T_0 <= t_0 / (2**25 - 1);
	T_1 <= t_1 / (2**24 - 1);
	T_2 <= t_2 / (2**24 - 1);
	T_7 <= t_0 / (2**25 - 1);
end


endmodule
