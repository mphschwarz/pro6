////////////////////////////////////////////////////////////////////////////////////////////
// ToDo: NAP Mode
module ADC_LTC2313_12 (
	input CLK,
	input LATCH,
	input SDI_ADC,
	output reg CONV_ADC,
	output reg CLK_ADC,
	output reg [15:0] VALUE
	);
	//
	reg [15:0] ctr_clk_spi;
	reg [11:0] index;
	reg [11:0] value_temp;
	reg [4:0] state;
	reg [11:0] ctr_clk_cs;// Testvariable
	//
	reg hri1; reg hri2; reg hri3; reg hri4;
	wire latch_start;
	wire clk_adc_re;
	wire clk_adc_fe;	
	//
	assign	latch_start = (hri1 && !hri2);
	assign	clk_adc_re = (hri3 && !hri4);
	assign	clk_adc_fe = (!hri3 && hri4);
	//	
	initial
	begin
		
		CONV_ADC <= 1;
		CLK_ADC <= 0;
		VALUE <= 0;
		index <= 15;
		value_temp <= 0;
		state <= 0;
		ctr_clk_spi <= 1;
		ctr_clk_cs <= 1;
		//
		hri1 <= 0; hri2 <= 0; hri3 <= 0; hri4 <= 0;
	end	
	//
	always	@(posedge CLK)
	begin
	// Impulsauswertung
	hri1 <= LATCH;
	hri2 <= hri1;
	hri3 <= CLK_ADC;
	hri4 <= hri3;
	// Testroutine
	if (CONV_ADC == 0) ctr_clk_cs <= ctr_clk_cs + 1;
	else ctr_clk_cs <= 1;
	
	//
	if (state == 0) 
		begin
		CONV_ADC <= 1;
		CLK_ADC <= 0;
		index <= 12;
		value_temp <= 0;
		ctr_clk_spi <= 1;
		//
		if(latch_start) 
			begin
			state <= 1;
			end
		//
		end
	//
	if (state == 1) 
		begin
		CONV_ADC <= 1;
		CLK_ADC <= 0;
		ctr_clk_spi <= ctr_clk_spi + 1;
		if (ctr_clk_spi == 30) 
			begin
			ctr_clk_spi <= 0;
			state <= 2;
			end
		//
		end
	//
	if (state == 2) 
		begin
		CONV_ADC <= 0;
		ctr_clk_spi <= ctr_clk_spi + 1;
		if (ctr_clk_spi == 4) 
			begin
			ctr_clk_spi <= 1;
			CLK_ADC <= !CLK_ADC;
			end
		//
		if (clk_adc_re)	value_temp[index - 1] <= SDI_ADC;
		//
		if (clk_adc_fe) index <= index - 1;
		//
		if (index == 0) state <= 3;
		//
		end

	if (state == 3) 
		begin
		VALUE[15:4] <= value_temp[11:0];
		state <= 0;
		end
	end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////
module ADC_LTC2313_12_MOV_AVG(
	input CLK,
	input LATCH,
	input SDI_ADC,
	output CONV_ADC,
	output CLK_ADC,
	output [15:0] VALUE,
	output reg [15:0] VALUE_AVG,
	output reg LATCH_DAC
	);
	//
	reg ctr_latch_enable;
	reg [11:0] ctr_sample;
	reg [10:0] ctr_mov_avg;
	reg [15:0] value_adc_1;
	reg [15:0] value_adc_2;
	reg [15:0] value_adc_3;
	reg [15:0] value_adc_4;
	reg [15:0] value_adc_5;
	reg [15:0] value_adc_6;
	reg [15:0] value_adc_7;
	reg [15:0] value_adc_8;
	reg [31:0] summe_mov_avg;
	reg [31:0] value_temp;
	reg [15:0] state;
	//
	reg hri1; reg hri2; reg hri3; reg hri4;
	wire latch_start;
	wire latch_conv_re;
	wire latch_adc;
	//
	assign latch_adc = latch_start;
	ADC_LTC2313_12 adc_ltc2313_12(CLK, latch_adc, SDI_ADC, CONV_ADC, CLK_ADC, VALUE);
	//
	assign	latch_start = (hri1 && !hri2);
	assign	latch_conv_re = (hri3 && !hri4);	
	//	
	initial
	begin
		VALUE_AVG <= 0;
		LATCH_DAC <= 0;
		ctr_sample <= 0;
		value_adc_1 <= 0;
		value_adc_2 <= 0;
		value_adc_3 <= 0;
		value_adc_4 <= 0;	
		value_adc_5 <= 0;
		value_adc_6 <= 0;
		value_adc_7 <= 0;
		value_adc_8 <= 0;			
		ctr_mov_avg <= 1;
		summe_mov_avg <= 0;
		value_temp <= 0;
		state <= 0;
		//
		//hri1 <= 0; hri2 <= 0; hri3 <= 0; hri4 <= 0;
	end	
	//
	always	@(posedge CLK)
	begin
	// START
	hri1 <= LATCH;
	hri2 <= hri1;
	//
	hri3 <= CONV_ADC;
	hri4 <= hri3;
	//
	// Moving Average
	if (latch_conv_re)
		begin
		ctr_mov_avg <= ctr_mov_avg + 1;
		if (ctr_mov_avg == 8) ctr_mov_avg <= 1;
		case(ctr_mov_avg)
			1: value_adc_1 <= VALUE;
			2: value_adc_2 <= VALUE;
			3: value_adc_3 <= VALUE;
			4: value_adc_4 <= VALUE;
			5: value_adc_5 <= VALUE;
			6: value_adc_6 <= VALUE;
			7: value_adc_7 <= VALUE;
			8: value_adc_8 <= VALUE;
			endcase
		state <= 1;
		end
	if (state == 1)
		begin
		summe_mov_avg <= 0;
		state <= state + 1;
		end
	if (state == 2)
		begin
		summe_mov_avg <= summe_mov_avg + value_adc_1;
		state <= state + 1;
		end
	if (state == 3)
		begin
		summe_mov_avg <= summe_mov_avg + value_adc_2;
		state <= state + 1;
		end
	if (state == 4)
		begin
		summe_mov_avg <= summe_mov_avg + value_adc_3;
		state <= state + 1;
		end
	if (state == 5)
		begin
		summe_mov_avg <= summe_mov_avg + value_adc_4;
		state <= state + 1;
		end		
	if (state == 6)
		begin
		summe_mov_avg <= summe_mov_avg + value_adc_5;
		state <= state + 1;
		end		
	if (state == 7)
		begin
		summe_mov_avg <= summe_mov_avg + value_adc_6;
		state <= state + 1;
		end		
	if (state == 8)
		begin
		summe_mov_avg <= summe_mov_avg + value_adc_7;
		state <= state + 1;
		end		
	if (state == 9)
		begin
		summe_mov_avg <= summe_mov_avg + value_adc_8;
		state <= state + 1;
		end		
	if (state == 10)
		begin
		value_temp <=  summe_mov_avg / 8;
		state <= state + 1;
		end
	if (state == 11)
		begin
		VALUE_AVG[15:0] <= value_temp[15:0];
		state <= state + 1;
		end				
	if ((state >= 12) && (state < 22))
		begin
		LATCH_DAC <= 1;
		state <= state + 1;
		end
	if (state == 22)
		begin
		LATCH_DAC <= 0;
		state <= state + 1;
		end
	//
	end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////