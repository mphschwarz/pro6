module AC_MOTOR_SINE(
	input CLK,
	input [bits - 1:0] FREQUENCY,
	input signed [bits - 1:0] AMPLITUDE,
	input CW,
	input CCW,
	input LOCK,
	output reg signed [12 + 12 - 1:0] SINE_VAL_1,
	output reg signed [12 + 12 - 1:0] SINE_VAL_2,
	output reg signed [12 + 12 - 1:0] SINE_VAL_3
	);

	parameter starting_sample = 0;
	parameter sine_samples = 512 * 4;
	parameter bits = 12;

	parameter f_clk = 82000000;
	parameter f_min = 10;
	parameter f_max = 600;
	parameter clock_div_min =  f_clk / (f_min * sine_samples);
	parameter clock_div_max =  f_clk / (f_max * sine_samples);

	reg [12:0] clock_div;
	reg [12:0] freq_int;
	reg signed [12:0] ampl_int;
	reg ccw_int;
	reg cw_int;
	reg [13:0] sine_index_1;	//time index of sine
	reg [13:0] sine_index_2;	//time index of sine
	reg [13:0] sine_index_3;	//time index of sine
	reg [8:0] mem_index_1;	//memory index of sine sample to output
	reg [8:0] mem_index_2;	//memory index of sine sample to output
	reg [8:0] mem_index_3;	//memory index of sine sample to output
	reg signed [bits-1:0] unsigned_sine_1;  //stores the sine value without sign, enables RAM usage
	reg signed [bits-1:0] unsigned_sine_2;  //stores the sine value without sign, enables RAM usage
	reg signed [bits-1:0] unsigned_sine_3;  //stores the sine value without sign, enables RAM usage
	reg signed [bits-1:0] signed_sine_1;
	reg signed [bits-1:0] signed_sine_2;
	reg signed [bits-1:0] signed_sine_3;
	reg signed [2:0] sine_sign_1;
	reg signed [2:0] sine_sign_2;
	reg signed [2:0] sine_sign_3;

	(* ramstyle = "M9K" *) reg signed [bits-1:0] sine [(sine_samples / 4) - 1:0];

	always @(posedge LOCK) begin
		freq_int <= FREQUENCY + clock_div_max;
		ampl_int <= AMPLITUDE;
		cw_int <= CW;
		ccw_int <= CCW;
	end
	
	always @(posedge CLK) begin
		if (clock_div >= freq_int) begin
			clock_div <= 0;
			if      (sine_index_1 >= 0                    && sine_index_1 <= sine_samples     / 4 - 1) mem_index_1 <= sine_index_1;
			else if (sine_index_1 >= sine_samples     / 4 && sine_index_1 <= sine_samples     / 2 - 1) mem_index_1 <= sine_samples / 2 - sine_index_1 - 1;
			else if (sine_index_1 >= sine_samples     / 2 && sine_index_1 <= sine_samples * 3 / 4 - 1) mem_index_1 <= sine_index_1 - sine_samples / 2;
			else if (sine_index_1 >= sine_samples * 3 / 4 && sine_index_1 <= sine_samples         - 1) mem_index_1 <= sine_samples - sine_index_1 - 1;

			if      (sine_index_2 >= 0                    && sine_index_2 <= sine_samples     / 4 - 1) mem_index_2 <= sine_index_2;
			else if (sine_index_2 >= sine_samples     / 4 && sine_index_2 <= sine_samples     / 2 - 1) mem_index_2 <= sine_samples / 2 - sine_index_2 - 1;
			else if (sine_index_2 >= sine_samples     / 2 && sine_index_2 <= sine_samples * 3 / 4 - 1) mem_index_2 <= sine_index_2 - sine_samples / 2;
			else if (sine_index_2 >= sine_samples * 3 / 4 && sine_index_2 <= sine_samples         - 1) mem_index_2 <= sine_samples - sine_index_2 - 1;
			
			if      (sine_index_3 >= 0                    && sine_index_3 <= sine_samples     / 4 - 1) mem_index_3 <= sine_index_3;
			else if (sine_index_3 >= sine_samples     / 4 && sine_index_3 <= sine_samples     / 2 - 1) mem_index_3 <= sine_samples / 2 - sine_index_3 - 1;
			else if (sine_index_3 >= sine_samples     / 2 && sine_index_3 <= sine_samples * 3 / 4 - 1) mem_index_3 <= sine_index_3 - sine_samples / 2;
			else if (sine_index_3 >= sine_samples * 3 / 4 && sine_index_3 <= sine_samples         - 1) mem_index_3 <= sine_samples - sine_index_3 - 1;


			if (sine_index_1 >= sine_samples / 2 && sine_index_1 <= sine_samples - 1) sine_sign_1 <= -1;
			else sine_sign_1 <= 1;

			if (sine_index_2 >= sine_samples / 2 && sine_index_2 <= sine_samples - 1) sine_sign_2 <= -1;
			else sine_sign_2 <= 1;
			
			if (sine_index_3 >= sine_samples / 2 && sine_index_3 <= sine_samples - 1) sine_sign_3 <= -1;
			else sine_sign_3 <= 1;


			// value_temp <= 12'b000000000000; // für triangle frequency testing
			if (sine_index_1 == sine_samples + 3) sine_index_1 <= 0;
			else sine_index_1 <= sine_index_1 + 1;
			if (sine_index_2 == sine_samples + 3) sine_index_2 <= 0;
			else sine_index_2 <= sine_index_2 + 1;
			if (sine_index_3 == sine_samples + 3) sine_index_3 <= 0;
			else sine_index_3 <= sine_index_3 + 1;


		end else begin
			clock_div <= clock_div + 1;
		end
	end

	always @(posedge CLK) begin
		unsigned_sine_1 <= sine[mem_index_1];
		unsigned_sine_2 <= sine[mem_index_2];
		unsigned_sine_3 <= sine[mem_index_3];
	end

	always @(posedge CLK) begin
		signed_sine_1 <= unsigned_sine_1 * sine_sign_1;
		signed_sine_2 <= unsigned_sine_2 * sine_sign_2;
		signed_sine_3 <= unsigned_sine_3 * sine_sign_3;
	end

	always @(posedge CLK) begin
		if (cw_int == 0 && ccw_int == 1) begin 
			SINE_VAL_1 <= signed_sine_1 * ampl_int;
			SINE_VAL_2 <= signed_sine_2 * ampl_int;
			SINE_VAL_3 <= signed_sine_3 * ampl_int;
		end else if (cw_int == 1 && ccw_int == 0) begin // for reverse, two phases are switched
			SINE_VAL_1 <= signed_sine_1 * ampl_int;
			SINE_VAL_3 <= signed_sine_2 * ampl_int;
			SINE_VAL_2 <= signed_sine_3 * ampl_int;
		end
	end

	initial begin
		clock_div <= 0;
		sine_index_1 <= 0;
		sine_index_2 <= sine_samples / 3;
		sine_index_3 <= sine_samples / 3 * 2;
		freq_int <= clock_div_max;
		ampl_int <= 2**11;
		sine[0] = 12'b000000000000; sine[1] = 12'b000000000110; /*12'b000000000000*/
		sine[2] = 12'b000000001100; sine[3] = 12'b000000010010;
		sine[4] = 12'b000000011001; sine[5] = 12'b000000011111;
		sine[6] = 12'b000000100101; sine[7] = 12'b000000101100;
		sine[8] = 12'b000000110010; sine[9] = 12'b000000111000;
		sine[10] = 12'b000000111110; sine[11] = 12'b000001000101;
		sine[12] = 12'b000001001011; sine[13] = 12'b000001010001;
		sine[14] = 12'b000001011000; sine[15] = 12'b000001011110;
		sine[16] = 12'b000001100100; sine[17] = 12'b000001101010;
		sine[18] = 12'b000001110001; sine[19] = 12'b000001110111;
		sine[20] = 12'b000001111101; sine[21] = 12'b000010000100;
		sine[22] = 12'b000010001010; sine[23] = 12'b000010010000;
		sine[24] = 12'b000010010110; sine[25] = 12'b000010011101;
		sine[26] = 12'b000010100011; sine[27] = 12'b000010101001;
		sine[28] = 12'b000010110000; sine[29] = 12'b000010110110;
		sine[30] = 12'b000010111100; sine[31] = 12'b000011000010;
		sine[32] = 12'b000011001001; sine[33] = 12'b000011001111;
		sine[34] = 12'b000011010101; sine[35] = 12'b000011011011;
		sine[36] = 12'b000011100010; sine[37] = 12'b000011101000;
		sine[38] = 12'b000011101110; sine[39] = 12'b000011110100;
		sine[40] = 12'b000011111011; sine[41] = 12'b000100000001;
		sine[42] = 12'b000100000111; sine[43] = 12'b000100001101;
		sine[44] = 12'b000100010100; sine[45] = 12'b000100011010;
		sine[46] = 12'b000100100000; sine[47] = 12'b000100100110;
		sine[48] = 12'b000100101101; sine[49] = 12'b000100110011;
		sine[50] = 12'b000100111001; sine[51] = 12'b000100111111;
		sine[52] = 12'b000101000101; sine[53] = 12'b000101001100;
		sine[54] = 12'b000101010010; sine[55] = 12'b000101011000;
		sine[56] = 12'b000101011110; sine[57] = 12'b000101100101;
		sine[58] = 12'b000101101011; sine[59] = 12'b000101110001;
		sine[60] = 12'b000101110111; sine[61] = 12'b000101111101;
		sine[62] = 12'b000110000011; sine[63] = 12'b000110001010;
		sine[64] = 12'b000110010000; sine[65] = 12'b000110010110;
		sine[66] = 12'b000110011100; sine[67] = 12'b000110100010;
		sine[68] = 12'b000110101000; sine[69] = 12'b000110101111;
		sine[70] = 12'b000110110101; sine[71] = 12'b000110111011;
		sine[72] = 12'b000111000001; sine[73] = 12'b000111000111;
		sine[74] = 12'b000111001101; sine[75] = 12'b000111010011;
		sine[76] = 12'b000111011010; sine[77] = 12'b000111100000;
		sine[78] = 12'b000111100110; sine[79] = 12'b000111101100;
		sine[80] = 12'b000111110010; sine[81] = 12'b000111111000;
		sine[82] = 12'b000111111110; sine[83] = 12'b001000000100;
		sine[84] = 12'b001000001010; sine[85] = 12'b001000010001;
		sine[86] = 12'b001000010111; sine[87] = 12'b001000011101;
		sine[88] = 12'b001000100011; sine[89] = 12'b001000101001;
		sine[90] = 12'b001000101111; sine[91] = 12'b001000110101;
		sine[92] = 12'b001000111011; sine[93] = 12'b001001000001;
		sine[94] = 12'b001001000111; sine[95] = 12'b001001001101;
		sine[96] = 12'b001001010011; sine[97] = 12'b001001011001;
		sine[98] = 12'b001001011111; sine[99] = 12'b001001100101;
		sine[100] = 12'b001001101011; sine[101] = 12'b001001110001;
		sine[102] = 12'b001001110111; sine[103] = 12'b001001111101;
		sine[104] = 12'b001010000011; sine[105] = 12'b001010001001;
		sine[106] = 12'b001010001111; sine[107] = 12'b001010010101;
		sine[108] = 12'b001010011011; sine[109] = 12'b001010100001;
		sine[110] = 12'b001010100111; sine[111] = 12'b001010101101;
		sine[112] = 12'b001010110011; sine[113] = 12'b001010111001;
		sine[114] = 12'b001010111111; sine[115] = 12'b001011000100;
		sine[116] = 12'b001011001010; sine[117] = 12'b001011010000;
		sine[118] = 12'b001011010110; sine[119] = 12'b001011011100;
		sine[120] = 12'b001011100010; sine[121] = 12'b001011101000;
		sine[122] = 12'b001011101110; sine[123] = 12'b001011110100;
		sine[124] = 12'b001011111001; sine[125] = 12'b001011111111;
		sine[126] = 12'b001100000101; sine[127] = 12'b001100001011;
		sine[128] = 12'b001100010001; sine[129] = 12'b001100010111;
		sine[130] = 12'b001100011100; sine[131] = 12'b001100100010;
		sine[132] = 12'b001100101000; sine[133] = 12'b001100101110;
		sine[134] = 12'b001100110011; sine[135] = 12'b001100111001;
		sine[136] = 12'b001100111111; sine[137] = 12'b001101000101;
		sine[138] = 12'b001101001010; sine[139] = 12'b001101010000;
		sine[140] = 12'b001101010110; sine[141] = 12'b001101011100;
		sine[142] = 12'b001101100001; sine[143] = 12'b001101100111;
		sine[144] = 12'b001101101101; sine[145] = 12'b001101110010;
		sine[146] = 12'b001101111000; sine[147] = 12'b001101111110;
		sine[148] = 12'b001110000011; sine[149] = 12'b001110001001;
		sine[150] = 12'b001110001111; sine[151] = 12'b001110010100;
		sine[152] = 12'b001110011010; sine[153] = 12'b001110100000;
		sine[154] = 12'b001110100101; sine[155] = 12'b001110101011;
		sine[156] = 12'b001110110000; sine[157] = 12'b001110110110;
		sine[158] = 12'b001110111100; sine[159] = 12'b001111000001;
		sine[160] = 12'b001111000111; sine[161] = 12'b001111001100;
		sine[162] = 12'b001111010010; sine[163] = 12'b001111010111;
		sine[164] = 12'b001111011101; sine[165] = 12'b001111100010;
		sine[166] = 12'b001111101000; sine[167] = 12'b001111101101;
		sine[168] = 12'b001111110011; sine[169] = 12'b001111111000;
		sine[170] = 12'b001111111110; sine[171] = 12'b010000000011;
		sine[172] = 12'b010000001001; sine[173] = 12'b010000001110;
		sine[174] = 12'b010000010011; sine[175] = 12'b010000011001;
		sine[176] = 12'b010000011110; sine[177] = 12'b010000100100;
		sine[178] = 12'b010000101001; sine[179] = 12'b010000101110;
		sine[180] = 12'b010000110100; sine[181] = 12'b010000111001;
		sine[182] = 12'b010000111110; sine[183] = 12'b010001000100;
		sine[184] = 12'b010001001001; sine[185] = 12'b010001001110;
		sine[186] = 12'b010001010100; sine[187] = 12'b010001011001;
		sine[188] = 12'b010001011110; sine[189] = 12'b010001100100;
		sine[190] = 12'b010001101001; sine[191] = 12'b010001101110;
		sine[192] = 12'b010001110011; sine[193] = 12'b010001111000;
		sine[194] = 12'b010001111110; sine[195] = 12'b010010000011;
		sine[196] = 12'b010010001000; sine[197] = 12'b010010001101;
		sine[198] = 12'b010010010010; sine[199] = 12'b010010011000;
		sine[200] = 12'b010010011101; sine[201] = 12'b010010100010;
		sine[202] = 12'b010010100111; sine[203] = 12'b010010101100;
		sine[204] = 12'b010010110001; sine[205] = 12'b010010110110;
		sine[206] = 12'b010010111011; sine[207] = 12'b010011000000;
		sine[208] = 12'b010011000110; sine[209] = 12'b010011001011;
		sine[210] = 12'b010011010000; sine[211] = 12'b010011010101;
		sine[212] = 12'b010011011010; sine[213] = 12'b010011011111;
		sine[214] = 12'b010011100100; sine[215] = 12'b010011101001;
		sine[216] = 12'b010011101110; sine[217] = 12'b010011110011;
		sine[218] = 12'b010011110111; sine[219] = 12'b010011111100;
		sine[220] = 12'b010100000001; sine[221] = 12'b010100000110;
		sine[222] = 12'b010100001011; sine[223] = 12'b010100010000;
		sine[224] = 12'b010100010101; sine[225] = 12'b010100011010;
		sine[226] = 12'b010100011111; sine[227] = 12'b010100100011;
		sine[228] = 12'b010100101000; sine[229] = 12'b010100101101;
		sine[230] = 12'b010100110010; sine[231] = 12'b010100110111;
		sine[232] = 12'b010100111011; sine[233] = 12'b010101000000;
		sine[234] = 12'b010101000101; sine[235] = 12'b010101001010;
		sine[236] = 12'b010101001110; sine[237] = 12'b010101010011;
		sine[238] = 12'b010101011000; sine[239] = 12'b010101011100;
		sine[240] = 12'b010101100001; sine[241] = 12'b010101100110;
		sine[242] = 12'b010101101010; sine[243] = 12'b010101101111;
		sine[244] = 12'b010101110100; sine[245] = 12'b010101111000;
		sine[246] = 12'b010101111101; sine[247] = 12'b010110000001;
		sine[248] = 12'b010110000110; sine[249] = 12'b010110001010;
		sine[250] = 12'b010110001111; sine[251] = 12'b010110010011;
		sine[252] = 12'b010110011000; sine[253] = 12'b010110011100;
		sine[254] = 12'b010110100001; sine[255] = 12'b010110100101;
		sine[256] = 12'b010110101010; sine[257] = 12'b010110101110;
		sine[258] = 12'b010110110011; sine[259] = 12'b010110110111;
		sine[260] = 12'b010110111100; sine[261] = 12'b010111000000;
		sine[262] = 12'b010111000100; sine[263] = 12'b010111001001;
		sine[264] = 12'b010111001101; sine[265] = 12'b010111010001;
		sine[266] = 12'b010111010110; sine[267] = 12'b010111011010;
		sine[268] = 12'b010111011110; sine[269] = 12'b010111100010;
		sine[270] = 12'b010111100111; sine[271] = 12'b010111101011;
		sine[272] = 12'b010111101111; sine[273] = 12'b010111110011;
		sine[274] = 12'b010111111000; sine[275] = 12'b010111111100;
		sine[276] = 12'b011000000000; sine[277] = 12'b011000000100;
		sine[278] = 12'b011000001000; sine[279] = 12'b011000001100;
		sine[280] = 12'b011000010001; sine[281] = 12'b011000010101;
		sine[282] = 12'b011000011001; sine[283] = 12'b011000011101;
		sine[284] = 12'b011000100001; sine[285] = 12'b011000100101;
		sine[286] = 12'b011000101001; sine[287] = 12'b011000101101;
		sine[288] = 12'b011000110001; sine[289] = 12'b011000110101;
		sine[290] = 12'b011000111001; sine[291] = 12'b011000111101;
		sine[292] = 12'b011001000001; sine[293] = 12'b011001000101;
		sine[294] = 12'b011001001001; sine[295] = 12'b011001001100;
		sine[296] = 12'b011001010000; sine[297] = 12'b011001010100;
		sine[298] = 12'b011001011000; sine[299] = 12'b011001011100;
		sine[300] = 12'b011001100000; sine[301] = 12'b011001100011;
		sine[302] = 12'b011001100111; sine[303] = 12'b011001101011;
		sine[304] = 12'b011001101111; sine[305] = 12'b011001110010;
		sine[306] = 12'b011001110110; sine[307] = 12'b011001111010;
		sine[308] = 12'b011001111110; sine[309] = 12'b011010000001;
		sine[310] = 12'b011010000101; sine[311] = 12'b011010001000;
		sine[312] = 12'b011010001100; sine[313] = 12'b011010010000;
		sine[314] = 12'b011010010011; sine[315] = 12'b011010010111;
		sine[316] = 12'b011010011010; sine[317] = 12'b011010011110;
		sine[318] = 12'b011010100010; sine[319] = 12'b011010100101;
		sine[320] = 12'b011010101001; sine[321] = 12'b011010101100;
		sine[322] = 12'b011010101111; sine[323] = 12'b011010110011;
		sine[324] = 12'b011010110110; sine[325] = 12'b011010111010;
		sine[326] = 12'b011010111101; sine[327] = 12'b011011000001;
		sine[328] = 12'b011011000100; sine[329] = 12'b011011000111;
		sine[330] = 12'b011011001011; sine[331] = 12'b011011001110;
		sine[332] = 12'b011011010001; sine[333] = 12'b011011010100;
		sine[334] = 12'b011011011000; sine[335] = 12'b011011011011;
		sine[336] = 12'b011011011110; sine[337] = 12'b011011100001;
		sine[338] = 12'b011011100101; sine[339] = 12'b011011101000;
		sine[340] = 12'b011011101011; sine[341] = 12'b011011101110;
		sine[342] = 12'b011011110001; sine[343] = 12'b011011110100;
		sine[344] = 12'b011011111000; sine[345] = 12'b011011111011;
		sine[346] = 12'b011011111110; sine[347] = 12'b011100000001;
		sine[348] = 12'b011100000100; sine[349] = 12'b011100000111;
		sine[350] = 12'b011100001010; sine[351] = 12'b011100001101;
		sine[352] = 12'b011100010000; sine[353] = 12'b011100010011;
		sine[354] = 12'b011100010110; sine[355] = 12'b011100011001;
		sine[356] = 12'b011100011011; sine[357] = 12'b011100011110;
		sine[358] = 12'b011100100001; sine[359] = 12'b011100100100;
		sine[360] = 12'b011100100111; sine[361] = 12'b011100101010;
		sine[362] = 12'b011100101100; sine[363] = 12'b011100101111;
		sine[364] = 12'b011100110010; sine[365] = 12'b011100110101;
		sine[366] = 12'b011100110111; sine[367] = 12'b011100111010;
		sine[368] = 12'b011100111101; sine[369] = 12'b011100111111;
		sine[370] = 12'b011101000010; sine[371] = 12'b011101000101;
		sine[372] = 12'b011101000111; sine[373] = 12'b011101001010;
		sine[374] = 12'b011101001101; sine[375] = 12'b011101001111;
		sine[376] = 12'b011101010010; sine[377] = 12'b011101010100;
		sine[378] = 12'b011101010111; sine[379] = 12'b011101011001;
		sine[380] = 12'b011101011100; sine[381] = 12'b011101011110;
		sine[382] = 12'b011101100001; sine[383] = 12'b011101100011;
		sine[384] = 12'b011101100101; sine[385] = 12'b011101101000;
		sine[386] = 12'b011101101010; sine[387] = 12'b011101101101;
		sine[388] = 12'b011101101111; sine[389] = 12'b011101110001;
		sine[390] = 12'b011101110011; sine[391] = 12'b011101110110;
		sine[392] = 12'b011101111000; sine[393] = 12'b011101111010;
		sine[394] = 12'b011101111100; sine[395] = 12'b011101111111;
		sine[396] = 12'b011110000001; sine[397] = 12'b011110000011;
		sine[398] = 12'b011110000101; sine[399] = 12'b011110000111;
		sine[400] = 12'b011110001001; sine[401] = 12'b011110001100;
		sine[402] = 12'b011110001110; sine[403] = 12'b011110010000;
		sine[404] = 12'b011110010010; sine[405] = 12'b011110010100;
		sine[406] = 12'b011110010110; sine[407] = 12'b011110011000;
		sine[408] = 12'b011110011010; sine[409] = 12'b011110011100;
		sine[410] = 12'b011110011110; sine[411] = 12'b011110011111;
		sine[412] = 12'b011110100001; sine[413] = 12'b011110100011;
		sine[414] = 12'b011110100101; sine[415] = 12'b011110100111;
		sine[416] = 12'b011110101001; sine[417] = 12'b011110101011;
		sine[418] = 12'b011110101100; sine[419] = 12'b011110101110;
		sine[420] = 12'b011110110000; sine[421] = 12'b011110110010;
		sine[422] = 12'b011110110011; sine[423] = 12'b011110110101;
		sine[424] = 12'b011110110111; sine[425] = 12'b011110111000;
		sine[426] = 12'b011110111010; sine[427] = 12'b011110111100;
		sine[428] = 12'b011110111101; sine[429] = 12'b011110111111;
		sine[430] = 12'b011111000000; sine[431] = 12'b011111000010;
		sine[432] = 12'b011111000011; sine[433] = 12'b011111000101;
		sine[434] = 12'b011111000110; sine[435] = 12'b011111001000;
		sine[436] = 12'b011111001001; sine[437] = 12'b011111001011;
		sine[438] = 12'b011111001100; sine[439] = 12'b011111001110;
		sine[440] = 12'b011111001111; sine[441] = 12'b011111010000;
		sine[442] = 12'b011111010010; sine[443] = 12'b011111010011;
		sine[444] = 12'b011111010100; sine[445] = 12'b011111010101;
		sine[446] = 12'b011111010111; sine[447] = 12'b011111011000;
		sine[448] = 12'b011111011001; sine[449] = 12'b011111011010;
		sine[450] = 12'b011111011100; sine[451] = 12'b011111011101;
		sine[452] = 12'b011111011110; sine[453] = 12'b011111011111;
		sine[454] = 12'b011111100000; sine[455] = 12'b011111100001;
		sine[456] = 12'b011111100010; sine[457] = 12'b011111100011;
		sine[458] = 12'b011111100100; sine[459] = 12'b011111100101;
		sine[460] = 12'b011111100110; sine[461] = 12'b011111100111;
		sine[462] = 12'b011111101000; sine[463] = 12'b011111101001;
		sine[464] = 12'b011111101010; sine[465] = 12'b011111101011;
		sine[466] = 12'b011111101100; sine[467] = 12'b011111101101;
		sine[468] = 12'b011111101110; sine[469] = 12'b011111101110;
		sine[470] = 12'b011111101111; sine[471] = 12'b011111110000;
		sine[472] = 12'b011111110001; sine[473] = 12'b011111110010;
		sine[474] = 12'b011111110010; sine[475] = 12'b011111110011;
		sine[476] = 12'b011111110100; sine[477] = 12'b011111110100;
		sine[478] = 12'b011111110101; sine[479] = 12'b011111110110;
		sine[480] = 12'b011111110110; sine[481] = 12'b011111110111;
		sine[482] = 12'b011111110111; sine[483] = 12'b011111111000;
		sine[484] = 12'b011111111000; sine[485] = 12'b011111111001;
		sine[486] = 12'b011111111001; sine[487] = 12'b011111111010;
		sine[488] = 12'b011111111010; sine[489] = 12'b011111111011;
		sine[490] = 12'b011111111011; sine[491] = 12'b011111111100;
		sine[492] = 12'b011111111100; sine[493] = 12'b011111111100;
		sine[494] = 12'b011111111101; sine[495] = 12'b011111111101;
		sine[496] = 12'b011111111101; sine[497] = 12'b011111111110;
		sine[498] = 12'b011111111110; sine[499] = 12'b011111111110;
		sine[500] = 12'b011111111110; sine[501] = 12'b011111111111;
		sine[502] = 12'b011111111111; sine[503] = 12'b011111111111;
		sine[504] = 12'b011111111111; sine[505] = 12'b011111111111;
		sine[506] = 12'b011111111111; sine[507] = 12'b011111111111;
		sine[508] = 12'b011111111111; sine[509] = 12'b011111111111;
		sine[510] = 12'b011111111111; sine[511] = 12'b011111111111/*12'b100000000000*/;
	end
endmodule
