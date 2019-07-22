module AC_MOTOR_VECTOR_CONTROL(
	input CLK,
	input [14:0] T_1,
	input [14:0] T_2,
	output reg U_0,
	output reg U_1,
	output reg U_2
);

parameter f_clk = 100*10**6;
parameter f_tast = 5*10**3;
parameter tast_period = f_clk / f_tast;


reg [14:0] tast_index;
reg [14:0] t1;
reg [14:0] t2;

initial begin
	tast_index <= 0;
	U_0 <= 0;
	U_1 <= 0;
	U_2 <= 0;
end

always @(posedge CLK) begin
	if (tast_index >= tast_period) begin
		t1 <= T_1;
		t2 <= T_2;
		tast_index <= 0;
	end else begin
		tast_index <= tast_index + 1;

		if (t1 != 0) begin
			U_0 <= 0;
			U_1 <= 1;
			U_2 <= 0;
			t1 <= t1 - 1;
		end else if (t2 != 0) begin
			U_0 <= 0;
			U_1 <= 0;
			U_2 <= 1;
			t2 <= t2 - 1;
		end else begin
			U_0 <= 1;
			U_1 <= 0;
			U_2 <= 0;
		end
	end
end

endmodule
