module AC_MOTOR_SWITCH_CONTROL(
	input CLK,
	input [2:0] SECTOR,
	input U_0,
	input U_1,
	input U_2,
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
	end

always @(posedge CLK) begin
	if (U_0 == 1) begin
		S_1 <= 0;
		S_2 <= 0;
		S_3 <= 0;
	end else if ((SECTOR == 5 && U_2 == 1) || (SECTOR == 0 && U_1 == 1)) begin
		S_1 <= 1;
		S_2 <= 0;
		S_3 <= 0;
	end else if ((SECTOR == 0 && U_2 == 1) || (SECTOR == 1 && U_1 == 1)) begin
		S_1 <= 1;
		S_2 <= 1;
		S_3 <= 0;
	end else if ((SECTOR == 1 && U_2 == 1) || (SECTOR == 2 && U_1 == 1)) begin
		S_1 <= 0;
		S_2 <= 1;
		S_3 <= 0;
	end else if ((SECTOR == 2 && U_2 == 1) || (SECTOR == 3 && U_1 == 1)) begin
		S_1 <= 0;
		S_2 <= 1;
		S_3 <= 1;
	end else if ((SECTOR == 3 && U_2 == 1) || (SECTOR == 4 && U_1 == 1)) begin
		S_1 <= 0;
		S_2 <= 0;
		S_3 <= 1;
	end else if ((SECTOR == 4 && U_2 == 1) || (SECTOR == 5 && U_1 == 1)) begin
		S_1 <= 1;
		S_2 <= 0;
		S_3 <= 1;
	end
end
	
endmodule
