////////////////////////////////////////////////////////////////////////////////////////////
module DAC_AD5061 (
	input CLK,
	input LATCH,
	input [15:0] VALUE,
	output reg SYNC_DAC,
	output reg CLK_DAC,
	output reg SDO_DAC
	);
	//
	reg [15:0] ctr_clk_delay;
	reg [11:0] index;
	reg [23:0] value_temp;
	reg [4:0] state;
	//
	reg hri1; reg hri2; reg hri3; reg hri4;
	wire latch_start;
	wire clk_dac_re;
	wire clk_dac_fe;	
	//
	assign	latch_start = (hri1 && !hri2);
	assign	clk_dac_re = (hri3 && !hri4);
	assign	clk_dac_fe = (!hri3 && hri4);
	//	
	initial
	begin
		
		SYNC_DAC <= 1;
		CLK_DAC <= 0;
		SDO_DAC <= 0;
		index <= 23;
		value_temp <= 24'b00000000_00000000_00000000;// Datasheet S.15
		state <= 0;
		ctr_clk_delay <= 1;
		//
		hri1 <= 0; hri2 <= 0; hri3 <= 0; hri4 <= 0; 
	end	
	//
	always	@(posedge CLK)
	begin
	// Impulsauswertung
	hri1 <= LATCH;
	hri2 <= hri1;
	hri3 <= CLK_DAC;
	hri4 <= hri3;
	//
	if (state == 0) 
		begin
		SYNC_DAC <= 1;
		index <= 23;
		value_temp <= 24'b00000000_00000000_00000000;// Datasheet S.15
		ctr_clk_delay <= 1;
		//
		if(latch_start) 
			begin
			value_temp[15:0] <= VALUE[15:0];
			SYNC_DAC <= 0;
			state <= 1;
			end
		//
		end
	//
	if (state == 1) 
		begin
		ctr_clk_delay <= ctr_clk_delay + 1;
		if (ctr_clk_delay == 3) 
			begin
			ctr_clk_delay <= 1;
			CLK_DAC <= !CLK_DAC;
			end
		//
		SDO_DAC <= value_temp[index];
		if (clk_dac_fe && (index > 0)) index <= index - 1;
		//
		if (clk_dac_fe && (index == 0)) 
			begin
			ctr_clk_delay <= 1;
			state <= 2;
			end
		end
	//
	if (state == 2) 
		begin
		ctr_clk_delay <= ctr_clk_delay + 1;
		if (ctr_clk_delay == 3) 
			begin
			ctr_clk_delay <= 1;
			SYNC_DAC <= 1;
			SDO_DAC <= 0;
			state <= 0;
			end
		end
	//
	end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////