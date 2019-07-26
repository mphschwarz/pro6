module AC_MOTOR_SWITCH_DELAY(
	input CLK,
	input ENABLE,
	input [10:0] DELAY,
	input S_IN,
	output reg S_HIGH, 
	output reg S_LOW
);

reg signed [11:0] delay_counter;
reg signed [11:0] delay_min;
reg signed [11:0] delay_max;

initial begin
	delay_counter <= 0;
	delay_min <= -1000;
	delay_max <= 1000;
	S_HIGH <= 0;
	S_LOW <= 0;
end

always @(posedge CLK) begin
	end

always @(posedge CLK) begin  //handles changes in delay, prevents unwanted peaks
	if (delay_max != DELAY && delay_counter == 0) begin
		delay_min <= -DELAY;
		delay_max <= DELAY;
	end else if (delay_counter < delay_max && S_IN) delay_counter <= delay_counter + 1;
	else if (delay_counter > delay_min && !S_IN) delay_counter <= delay_counter - 1;
end

always @(posedge CLK) begin
	if (ENABLE) begin
		if (delay_counter == delay_max && S_IN) begin //switches set to high
			S_HIGH <= 1;
			S_LOW <= 0;
		end else if (delay_counter == delay_min && !S_IN) begin //switches set to low
			S_HIGH <= 0;
			S_LOW <= 1;
		end else begin //switches set to high impedance while delay_counter is between limits
			S_HIGH <= 0;
			S_LOW <= 0;
		end
	end else begin
		S_HIGH <= 0;
		S_LOW <= 0;
	end
end

endmodule
