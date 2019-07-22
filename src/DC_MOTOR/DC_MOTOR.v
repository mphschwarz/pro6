////////////////////////////////////////////////////////////////////////////////////////////
module DC_MOTOR_ANTRIEB (
	input CLK,
	input ENABLE,
	input CW,
	input CCW,
	input [11:0] VALUE,
	input [11:0] ADC_CMP,
	input [11:0] ADC,
	output reg OUT1,
	output reg OUT2,
	output EN1,
	output EN2,	
	output reg ADC_LATCH);
	//
	parameter PWM_LIMIT = 12'd500;
	parameter ADC_CMP_LIMIT = 12'd2600;
	//
	assign EN1 = ENABLE;// (ENABLE && CW && OUT1) || (ENABLE && CCW);
	assign EN2 = ENABLE;// (ENABLE && CCW && OUT2) || (ENABLE && CW);
	//
	reg cw_temp;
	reg ccw_temp;
	reg [11:0] value_temp;
	reg [11:0] adc_cmp_temp;
	reg [11:0] adc_temp;
	reg en_adc;
	reg [11:0] ctr;
	reg ctr_dir;
	reg [11:0] ctr_adc_latch;
	reg ctr_adc_latch_en;
	reg adc_cmp_en;
	reg [11:0] value_temp_adc_latch;
	//
	initial
		begin
			OUT1 <= 0;
			OUT2 <= 0;
			ADC_LATCH <= 0;
			//
			cw_temp <= 0;
			ccw_temp <= 0;
			value_temp <= 0;
			adc_cmp_temp <= 0;
			adc_temp <= 0;
			en_adc <= 1;
			ctr <= 4095;
			ctr_dir <= 1;
			ctr_adc_latch <= 1;
			ctr_adc_latch_en <= 1;
			value_temp_adc_latch <= 0;
			adc_cmp_en <= 0;
		end
	//
	always @(posedge CLK)
	begin
		// Pulsblocker
		adc_temp[11:0] <= ADC[11:0];
		if ((adc_temp > adc_cmp_temp) && adc_cmp_en) en_adc <= 0;
		//
		if (ctr == 4095) 
			begin
			cw_temp <= CW;
			ccw_temp <= CCW;
			//
			if (VALUE <= PWM_LIMIT) value_temp[11:0] <= VALUE[11:0];
			else value_temp[11:0] <= PWM_LIMIT;
			//
			if (ADC_CMP <= ADC_CMP_LIMIT) adc_cmp_temp[11:0] <= ADC_CMP[11:0];			
			else adc_cmp_temp <= ADC_CMP_LIMIT;
			//
			en_adc <= 1;
			ctr_adc_latch_en <= 1;
			adc_cmp_en <= 0;
			end
		//
		if (ctr == 1) ctr_dir <= 1;
		if (ctr == 4094) ctr_dir <= 0;
		//
		if (ctr_dir) ctr <= ctr + 1;
		else ctr <= ctr - 1;	
		//
		if ((value_temp >= ctr) && (value_temp > 0) && en_adc)
			begin
			//
			if (cw_temp && !ccw_temp)
				begin
				OUT1 <= 1;
				OUT2 <= 0;
				end
			//	
			if (!cw_temp && ccw_temp)
				begin
				OUT1 <= 0;
				OUT2 <= 1;
				end
			//
			end
		else
			begin
			OUT1 <= 0;
			OUT2 <= 0;
			end
		// ADC Latch
		// 1us => 50 , 15us => 750
		if (value_temp > 750) value_temp_adc_latch <= value_temp - 750;
		else value_temp_adc_latch <= 0;
		//
		if ((value_temp_adc_latch >= ctr) && ctr_adc_latch_en)
			begin
			ctr_adc_latch_en <= 0;
			ADC_LATCH <= 1;
			end
		if (ADC_LATCH) ctr_adc_latch <= ctr_adc_latch + 1;	
		if (ctr_adc_latch == 250)
			begin
			ctr_adc_latch <= 1;
			ADC_LATCH <= 0;
			adc_cmp_en <= 1;
			end						
		//
	end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////
module DC_MOTOR_RAMPE(
	input CLK,
	input ENABLE,
	input signed [14:0] VALUE_IN,
	output reg CW,
	output reg CCW,	
	output reg [11:0] VALUE_OUT);
	//
	parameter RAMPE_CMP = 16'd3000;
	//
	reg [15:0] ctr;
	reg [11:0] value_temp;
	reg hri1; reg hri2;
	//
	wire latch_cmp;
	assign latch_cmp = (hri1 && !hri2);
	//
	initial
		begin
			CW <= 0;
			CCW <= 0;
			VALUE_OUT <= 0;
			//
			ctr <= 1;
			value_temp <= 0;
			//
			hri1 <= 0; hri2 <= 0;
		end
	//
	always @(posedge CLK)
	begin	
	hri1 <= (ctr == RAMPE_CMP);
	hri2 <= hri1;	
	ctr <= ctr + 1;
	if (ctr == RAMPE_CMP)
		begin
		ctr <= 1;
		if (VALUE_IN >= 0) value_temp[11:0] <= VALUE_IN[11:0];
		else value_temp[11:0] <= ~VALUE_IN[11:0] + 1;// Zweierkomplement
		end
	//
	if (latch_cmp) begin
		if (VALUE_OUT == 0) begin
			if (VALUE_IN >= 0) 
				begin
				CW <= 1;
				CCW <= 0;
				end
			//
			if (VALUE_IN < 0) 
				begin
				CW <= 0;
				CCW <= 1;
				end
			//
			end
		//
		if (CW)
			begin
			//
			if (VALUE_IN >= 0) 
				begin
				if (value_temp > VALUE_OUT) VALUE_OUT <= VALUE_OUT + 1;
				if (value_temp < VALUE_OUT) VALUE_OUT <= VALUE_OUT - 1;
				end
			//
			else
				begin
				if (VALUE_OUT > 0) VALUE_OUT <= VALUE_OUT - 1;
				end
			//
			end
		//
		if (CCW)
			begin
			//
			if (VALUE_IN < 0) 
				begin
				if (value_temp > VALUE_OUT) VALUE_OUT <= VALUE_OUT + 1;
				if (value_temp < VALUE_OUT) VALUE_OUT <= VALUE_OUT - 1;
				end
			else
				begin
				if (VALUE_OUT > 0) VALUE_OUT <= VALUE_OUT - 1;
				end
			//
			end
		//
		end
	//
	if (!ENABLE)
		begin
		CW <= 0;
		CCW <= 0;
		VALUE_OUT <= 0;
		end
	//
	end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////
module DC_MOTOR_LUEFTER(
	input CLK,
	input [11:0] VALUE,
	output reg OUT);
	//
	parameter PWM_LIMIT = 12'd4095;
	//
	reg [11:0] ctr;
	reg [11:0] valueTest;
	//
	initial
		begin
			OUT <= 0;
			ctr <= 0;
			valueTest <= 0;
		end
	//
	always @(posedge CLK)
	begin	
		if (VALUE <= 4095) valueTest <= VALUE;
		if (VALUE > PWM_LIMIT) valueTest <= PWM_LIMIT;// Spannungsbeschränkung
		if (valueTest > ctr) OUT <= 1;
		else OUT <= 0;
		ctr <= ctr + 1;
	end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////