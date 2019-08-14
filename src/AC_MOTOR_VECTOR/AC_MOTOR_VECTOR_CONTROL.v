module AC_MOTOR_VECTOR_CONTROL(
	input CLK,
	input [2:0] SECTOR_IN,
	input [14:0] T_0,
	input [14:0] T_1,
	input [14:0] T_2,
	input [14:0] T_7,
	output reg [2:0] SECTOR_OUT,
	output reg U_0,
	output reg U_1,
	output reg U_2,
	output reg U_7);

parameter f_clk = 100*10**6;
parameter f_tast = 10*10**3;
parameter tast_period = f_clk / f_tast;


reg [2:0] sector;
reg [14:0] tast_index;
reg [14:0] t_0;
reg [14:0] t_0_counter;
reg [14:0] t_1;
reg [14:0] t_1_counter;
reg [14:0] t_2;
reg [14:0] t_2_counter;
reg [14:0] t_7;
reg [14:0] t_7_counter;

initial begin
	sector <= 0;
	tast_index <= 0;
	U_0 <= 0;
	U_1 <= 0;
	U_2 <= 0;
	U_7 <= 0;
end

always @(posedge CLK) SECTOR_OUT <= sector;

always @(posedge CLK) if (tast_index == 1) sector <= SECTOR_IN;

always @(posedge CLK) begin
	if (tast_index >= tast_period) begin
		t_0 <= T_0 / 2;
		t_1 <= T_1 / 2;
		t_2 <= T_2 / 2;
		t_7 <= T_7 / 2;

		t_0_counter <= 0;
		t_1_counter <= 0;
		t_2_counter <= 0;
		t_7_counter <= 0;

		tast_index <= 0;
	end else begin tast_index <= tast_index + 1; end

	if (t_0_counter != t_0 && t_1_counter ==   0 && t_2_counter ==   0 && t_7_counter ==   0) t_0_counter <= t_0_counter + 1;
	if (t_0_counter == t_0 && t_1_counter != t_1 && t_2_counter ==   0 && t_7_counter ==   0) t_1_counter <= t_1_counter + 1;
	if (t_0_counter == t_0 && t_1_counter == t_1 && t_2_counter != t_2 && t_7_counter ==   0) t_2_counter <= t_2_counter + 1;
	if (t_0_counter == t_0 && t_1_counter == t_1 && t_2_counter == t_2 && t_7_counter != t_7) t_7_counter <= t_7_counter + 1;
	if (t_0_counter == t_0 && t_1_counter == t_1 && t_2_counter !=   0 && t_7_counter == t_7) t_2_counter <= t_2_counter - 1;
	if (t_0_counter == t_0 && t_1_counter !=   0 && t_2_counter ==   0 && t_7_counter == t_7) t_1_counter <= t_1_counter - 1;
end

always @(posedge CLK) begin
	if (t_0_counter != 0 && t_0_counter != t_0) begin U_0 <= 1; U_1 <= 0; U_2 <= 0; U_7 <= 0; end
	if (t_1_counter != 0 && t_1_counter != t_1) begin U_0 <= 0; U_1 <= 1; U_2 <= 0; U_7 <= 0; end
	if (t_2_counter != 0 && t_2_counter != t_2) begin U_0 <= 0; U_1 <= 0; U_2 <= 1; U_7 <= 0; end
	if (t_7_counter != 0 && t_7_counter != t_7) begin U_0 <= 0; U_1 <= 0; U_2 <= 0; U_7 <= 1; end
end

endmodule
