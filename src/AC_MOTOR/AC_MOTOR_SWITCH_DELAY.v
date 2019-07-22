module AC_MOTOR_SWITCH_DELAY(
	input CLK,
	input ENABLE,
	input [10:0] DELAY,
	input S_IN,
	output reg S_HIGH, 
	output reg S_LOW
);

reg signed [11:0] delay_counter;

initial begin
	delay_counter <= 0;
	S_HIGH <= 0;
	S_LOW <= 0;
end

always @(posedge CLK) begin
	if (ENABLE) begin
		if (delay_counter == DELAY && S_IN) begin
			S_HIGH <= 1;
			S_LOW <= 0;
		end else if (delay_counter == -DELAY && !S_IN) begin
			S_HIGH <= 0;
			S_LOW <= 1;
		end else begin
			S_HIGH <= 0;
			S_LOW <= 0;
			if (S_IN) delay_counter <= delay_counter + 1;
			else delay_counter <= delay_counter - 1;
		end
	end else begin
		S_HIGH <= 0;
		S_LOW <= 0;
	end
end

endmodule
