module AC_MOTOR_VECTOR_CONTROL(
	input CLK,
	input [2:0] SECTOR_IN,
	input [14:0] T_LOW,
	input [14:0] T_HIGH,
	output reg [2:0] SECTOR_OUT,
	output reg U_0,
	output reg U_LOW,
	output reg U_HIGH
);

parameter f_clk = 100*10**6;
parameter f_tast = 5*10**3;
parameter tast_period = f_clk / f_tast;


reg [2:0] sector;
reg [14:0] tast_index;
reg [14:0] t_low;
reg [14:0] t_high;

initial begin
	sector <= 0;
	tast_index <= 0;
	U_0 <= 0;
	U_LOW <= 0;
	U_HIGH <= 0;
end

always @(posedge CLK) SECTOR_OUT <= sector;

always @(posedge CLK) begin
	if (tast_index >= tast_period) begin
		t_low <= T_LOW;
		t_high <= T_HIGH;
		tast_index <= 0;
		sector <= SECTOR_IN;
	end else begin
		tast_index <= tast_index + 1;

		if (t_low != 0) begin
			U_0 <= 0;
			U_LOW <= 1;
			U_HIGH <= 0;
			t_low <= t_low - 1;
		end else if (t_high != 0) begin
			U_0 <= 0;
			U_LOW <= 0;
			U_HIGH <= 1;
			t_high <= t_high - 1;
		end else begin
			U_0 <= 1;
			U_LOW <= 0;
			U_HIGH <= 0;
		end
	end
end

endmodule
