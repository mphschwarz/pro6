module AC_MOTOR_DIRECTION(
	input CLK,
	input CW,
	input CCW,
	input S1_IN,
	input S2_IN,
	input S3_IN,
	output reg S1_OUT,
	output reg S2_OUT,
	output reg S3_OUT
);

initial begin
	S1_OUT <= 0;
	S2_OUT <= 0;
	S3_OUT <= 0;
end

always @(posedge CLK) begin
	if (CCW == 1 && CW == 0) begin
		S1_OUT <= S1_IN;
		S2_OUT <= S2_IN;
		S3_OUT <= S3_IN;
	end else if (CCW == 0 && CW == 1) begin
		S1_OUT <= S1_IN;
		S2_OUT <= S3_IN;
		S3_OUT <= S2_IN;
	end else begin
		S1_OUT <= 0;
		S2_OUT <= 0;
		S3_OUT <= 0;
	end
end

endmodule
