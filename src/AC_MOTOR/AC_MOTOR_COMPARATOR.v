module AC_MOTOR_COMPARATOR(
	input CLK,
	input ENABLE,
	//input CW,
	//input CCW,

	input signed [bits + level_bits - 1:0] TRIANGLE,
	input signed [bits + level_bits - 1:0] SINE,

	output reg OUT1,
	output reg OUT2,
	output EN1,
	output EN2);
	
	parameter bits = 12;
	parameter level_bits = 12;

	reg [3:0] dead_time;
	reg signed [bits + level_bits - 1:0] sine_int;
	reg signed [bits + level_bits - 1:0] triangle_int;
	reg signed [3:0] out_count;
	reg signed [2:0] out_count_dir;
	
	assign EN1 = 1;
	assign EN2 = 1;

	initial begin
		sine_int <= 0;
		triangle_int <= 0;
		dead_time <= 1;
		out_count <= 0;
		out_count_dir <= 1;
		OUT1 <= 0;
		OUT2 <= 0;
	end
	
	//sine and triangle comparator
	always @(posedge CLK) begin
		sine_int <= SINE;
		triangle_int <= TRIANGLE;
	end

	always @(posedge CLK) begin
		if (sine_int >= triangle_int) out_count_dir <= 1;
		else out_count_dir <= -1;
	end

	//bridge control with dead times
	always @(posedge CLK) begin
		if (out_count == 0 && out_count_dir == -1) begin
			OUT1 <= 1;
			OUT2 <= 0;
		end else if (out_count == dead_time && out_count_dir == 1) begin
			OUT1 <= 0;
			OUT2 <= 1;
		end else begin
			OUT1 <= 0;
			OUT2 <= 0;
			out_count <= out_count + out_count_dir;
		end
	end
endmodule
