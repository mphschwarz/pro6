module AC_MOTOR_TRIANGLE(
	input CLK,
	output reg LOCK,
	output reg signed [output_bits - 1:0] TRIANGLE);
	
	parameter output_bits = 24;
	parameter level_bits = 13;

	// parameter triangle_max =  2**(level_bits - 1) - 2;
	// parameter triangle_min = -2**(level_bits - 1) + 2;

	reg cw_int;
	reg ccw_int;
	reg signed [1:0] triangle_dir;
	reg signed [level_bits - 1:0] triangle_int;

	initial begin
		triangle_dir <= 1;
		triangle_int <= 0;
		LOCK <= 0;
		TRIANGLE <= 0;
	end

	always @(posedge CLK) begin
		if (triangle_int >= 2**(level_bits - 1) - 1) begin
			LOCK <= 1;
		end else begin
			LOCK <= 0;
		end
	end

	always @(posedge CLK) begin
		if (triangle_int == 2**(level_bits - 1) - 2) triangle_dir <= -1;
		if (triangle_int == -1 * 2**(level_bits - 1) + 3) triangle_dir <= 1;
	end

	always @(posedge CLK) begin
		triangle_int <= triangle_int + triangle_dir;
	end

	always @(posedge CLK) begin
		//fill out full 24-bit signed integer
		TRIANGLE <= triangle_int * 2**(output_bits - level_bits);
	end

endmodule
