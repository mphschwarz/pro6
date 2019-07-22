////////////////////////////////////////////////////////////////////////////////////////////
module DREHZAHLMESSUNG(
	input CLK,
	input IN,
	output reg [31:0] SPEED
	);
	//
	reg [31:0] speed_temp;
	reg [31:0] speed_temp_1;
	reg [31:0] speed_temp_2;
	reg [31:0] speed_temp_3;
	reg [31:0] speed_temp_4;
	reg [31:0] speed_temp_5;
	reg [31:0] speed_temp_6;
	reg [31:0] speed_temp_7;
	reg [31:0] speed_temp_8;
	reg [31:0] summe_mov_avg;
	reg [10:0] ctr_mov_avg;
	reg [5:0] state;
	reg [5:0] counter;
	//
	reg hri1; reg hri2;
	//
	wire in_;
	wire in_re;
	//
	localparam ENC_FILTER = 12'd500;	
	INP_FILTER inp_filter(CLK, IN, in_); defparam inp_filter.FILTER = ENC_FILTER;
	//
	assign in_re = (hri1 && !hri2);
	//
	initial
	begin	
		SPEED <= 0;
		//
		counter <= 0;
		speed_temp <= 0;
		ctr_mov_avg <= 1;
		state <= 0;
		speed_temp_1 <= 0;
		speed_temp_2 <= 0;
		speed_temp_3 <= 0;
		speed_temp_4 <= 0;
		speed_temp_5 <= 0;
		speed_temp_6 <= 0;
		speed_temp_7 <= 0;
		speed_temp_8 <= 0;
		summe_mov_avg <= 0;
		//
		hri1 <= 0; hri2 <= 0;
	end
	//
	always @(posedge CLK)
	begin
	// Impulsauswertung
	hri1 <= in_;
	hri2 <= hri1;	
	//
	// Drehzahlerfassung mit Betrachtung des Ueberlaufes +-2^31
	if (speed_temp < 2147483640)
		begin
		speed_temp <= speed_temp + 1;
		end
	//
	if (in_re || (speed_temp >= 50000000))
		begin
		counter <= counter + 1;
		end
	//
	if (counter == 4)
		begin
		counter <= 0;
		speed_temp <= 0;
		ctr_mov_avg <= ctr_mov_avg + 1;
		if (ctr_mov_avg == 8) ctr_mov_avg <= 1;
		case(ctr_mov_avg)
			1: speed_temp_1 <= speed_temp;
			2: speed_temp_2 <= speed_temp;
			3: speed_temp_3 <= speed_temp;
			4: speed_temp_4 <= speed_temp;
			5: speed_temp_5 <= speed_temp;
			6: speed_temp_6 <= speed_temp;
			7: speed_temp_7 <= speed_temp;
			8: speed_temp_8 <= speed_temp;			
			endcase
		state <= 6'd1;		
		end
	//
	// Moving Average
	if (state == 6'd1)
		begin
		summe_mov_avg <= 0;
		state <= state + 6'd1;
		end
	//
	if (state == 6'd2)
		begin
		summe_mov_avg <= summe_mov_avg + speed_temp_1;
		state <= state + 6'd1;
		end
	//
	if (state == 6'd3)
		begin
		summe_mov_avg <= summe_mov_avg + speed_temp_2;
		state <= state + 6'd1;
		end
	//
	if (state == 6'd4)
		begin
		summe_mov_avg <= summe_mov_avg + speed_temp_3;
		state <= state + 6'd1;
		end
	//
	if (state == 6'd5)
		begin
		summe_mov_avg <= summe_mov_avg + speed_temp_4;
		state <= state + 6'd1;
		end
	//
	if (state == 6'd6)
		begin
		summe_mov_avg <= summe_mov_avg + speed_temp_5;
		state <= state + 6'd1;
		end
	//
	if (state == 6'd7)
		begin
		summe_mov_avg <= summe_mov_avg + speed_temp_6;
		state <= state + 6'd1;
		end
	//
	if (state == 6'd8)
		begin
		summe_mov_avg <= summe_mov_avg + speed_temp_7;
		state <= state + 6'd1;
		end
	//
	if (state == 6'd9)
		begin
		summe_mov_avg <= summe_mov_avg + speed_temp_8;
		state <= state + 6'd1;
		end
	//
	if (state == 6'd10)
		begin
		SPEED <= summe_mov_avg / 8;
		state <= state + 6'd1;
		end
	//
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////
//	Digitales Filter
module	INP_FILTER (
	input CLK, 
	input IN,
	output reg OUT
	);
//
parameter FILTER = 12'd5;
//
reg [11:0] ctr0;
reg [11:0] ctr1;
//
initial
	begin
	OUT <= 0;
	ctr0 <= 0;
	ctr1 <= 0;
	end
always	@(posedge CLK)
begin
	if (IN && !OUT)
		begin
		ctr0 <= 0;
		ctr1 <= ctr1 + 1;
		end
	//	
	if (!IN && OUT)
		begin
		ctr0 <= ctr0 + 1;
		ctr1 <= 0;
		end	
	//
	if (ctr0 == FILTER)
		begin
		ctr0 <= 0;
		ctr1 <= 0;
		OUT <= 0;
		end
	//
	if (ctr1 == FILTER)
		begin
		ctr0 <= 0;
		ctr1 <= 0;
		OUT <= 1;
		end
	//	
	if (((ctr0 > 0) && IN) || ((ctr1 > 0) && !IN))
		begin
		ctr0 <= 0;
		ctr1 <= 0;
		end	
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////

