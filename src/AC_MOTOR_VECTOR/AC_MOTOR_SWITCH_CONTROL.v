module AC_MOTOR_SWITCH_CONTROL(
	input CLK,
	input [2:0] SECTOR,
	input U_0,
	input U_1,
	input U_2,
	input U_7,
	output reg S_1,
	output reg S_2,
	output reg S_3
);

initial begin
	S_1 <= 0;
	S_2 <= 0;
	S_3 <= 0;
end


always @(posedge CLK) begin
	if ((SECTOR == 5 || SECTOR == 0) && U_1) begin S_1 <= 1; S_2 <= 0; S_3 <= 0; end
	if ((SECTOR == 0 || SECTOR == 1) && U_2) begin S_1 <= 1; S_2 <= 1; S_3 <= 0; end
	if ((SECTOR == 1 || SECTOR == 2) && U_1) begin S_1 <= 0; S_2 <= 1; S_3 <= 0; end
	if ((SECTOR == 2 || SECTOR == 3) && U_2) begin S_1 <= 0; S_2 <= 1; S_3 <= 1; end
	if ((SECTOR == 3 || SECTOR == 4) && U_1) begin S_1 <= 0; S_2 <= 0; S_3 <= 1; end
	if ((SECTOR == 4 || SECTOR == 5) && U_2) begin S_1 <= 1; S_2 <= 0; S_3 <= 1; end
	
	if (U_0) begin S_1 <= 0; S_2 <= 0; S_3 <= 0; end
	if (U_7) begin S_1 <= 1; S_2 <= 1; S_3 <= 1; end
end
	
endmodule
