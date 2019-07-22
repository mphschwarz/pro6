////////////////////////////////////////////////////////////////////////////////////////////
module DATA_IN_VAR(
	// Allgemeine Testvariablen
	input FPGA_TO_RPI_15,	
	input FPGA_TO_RPI_14,	
	input FPGA_TO_RPI_13,	
	input FPGA_TO_RPI_12,	
	input FPGA_TO_RPI_11,	
	input FPGA_TO_RPI_10,	
	input FPGA_TO_RPI_09,	
	input FPGA_TO_RPI_08,	
	input FPGA_TO_RPI_07,	
	input FPGA_TO_RPI_06,	
	input FPGA_TO_RPI_05,	
	input FPGA_TO_RPI_04,	
	input FPGA_TO_RPI_03,	
	input FPGA_TO_RPI_02,	
	input FPGA_TO_RPI_01,	
	input FPGA_TO_RPI_00,
	input [15:0] FPGA_TO_RPI_16BIT_1,
	input [15:0] FPGA_TO_RPI_16BIT_2,	
	input [15:0] FPGA_TO_RPI_16BIT_3,	
	input [15:0] FPGA_TO_RPI_16BIT_4,		
	// Hardware IO's
	input FPGA_IN_15,	
	input FPGA_IN_14,	
	input FPGA_IN_13,	
	input FPGA_IN_12,	
	input FPGA_IN_11,	
	input FPGA_IN_10,	
	input FPGA_IN_09,	
	input FPGA_IN_08,		
	input FPGA_IN_07,	
	input FPGA_IN_06,	
	input FPGA_IN_05,	
	input FPGA_IN_04,	
	input FPGA_IN_03,	
	input FPGA_IN_02,	
	input FPGA_IN_01,	
	input FPGA_IN_00,			
	// IO Expander
	input MCP23S17_IN_7,	
	input MCP23S17_IN_6,	
	input MCP23S17_IN_5,	
	input MCP23S17_IN_4,	
	input MCP23S17_IN_3,	
	input MCP23S17_IN_2,	
	input MCP23S17_IN_1,	
	input MCP23S17_IN_0,				
	// LT2313
	input [15:0] ADC_1,
	input [15:0] ADC_2,
	input [15:0] ADC_3,
	input [15:0] ADC_4,
	input [15:0] ADC_5,
	input [15:0] ADC_6,	
	// MCP3551
	input [23:0] ADC_T1,
	input [23:0] ADC_T2,
	//
	input [31:0] DREHZAHL,
	//
	output [255:0] DATA
	);
	//
	assign DATA[000]     = FPGA_TO_RPI_15;
	assign DATA[001]     = FPGA_TO_RPI_14;
	assign DATA[002]     = FPGA_TO_RPI_13;
	assign DATA[003]     = FPGA_TO_RPI_12;
	assign DATA[004]     = FPGA_TO_RPI_11;
	assign DATA[005]     = FPGA_TO_RPI_10;
	assign DATA[006]     = FPGA_TO_RPI_09;
	assign DATA[007]     = FPGA_TO_RPI_08;	
	assign DATA[008]     = FPGA_TO_RPI_07;
	assign DATA[009]     = FPGA_TO_RPI_06;
	assign DATA[010]     = FPGA_TO_RPI_05;
	assign DATA[011]     = FPGA_TO_RPI_04;
	assign DATA[012]     = FPGA_TO_RPI_03;
	assign DATA[013]     = FPGA_TO_RPI_02;
	assign DATA[014]     = FPGA_TO_RPI_01;
	assign DATA[015]     = FPGA_TO_RPI_00;	
	//
	assign DATA[031:016] = FPGA_TO_RPI_16BIT_1[15:0];
	assign DATA[047:032] = FPGA_TO_RPI_16BIT_2[15:0];
	assign DATA[063:048] = FPGA_TO_RPI_16BIT_3[15:0];
	assign DATA[079:064] = FPGA_TO_RPI_16BIT_4[15:0];
	//
	assign DATA[080]     = FPGA_IN_15;
	assign DATA[081]     = FPGA_IN_14;
	assign DATA[082]     = FPGA_IN_13;
	assign DATA[083]     = FPGA_IN_12;
	assign DATA[084]     = FPGA_IN_11;
	assign DATA[085]     = FPGA_IN_10;
	assign DATA[086]     = FPGA_IN_09;
	assign DATA[087]     = FPGA_IN_08;
	assign DATA[088]     = FPGA_IN_07;
	assign DATA[089]     = FPGA_IN_06;
	assign DATA[090]     = FPGA_IN_05;
	assign DATA[091]     = FPGA_IN_04;
	assign DATA[092]     = FPGA_IN_03;
	assign DATA[093]     = FPGA_IN_02;
	assign DATA[094]     = FPGA_IN_01;
	assign DATA[095]     = FPGA_IN_00;
	//
	assign DATA[096]     = MCP23S17_IN_7;
	assign DATA[097]     = MCP23S17_IN_6;
	assign DATA[098]     = MCP23S17_IN_5;
	assign DATA[099]     = MCP23S17_IN_4;
	assign DATA[100]     = MCP23S17_IN_3;
	assign DATA[101]     = MCP23S17_IN_2;
	assign DATA[102]     = MCP23S17_IN_1;
	assign DATA[103]     = MCP23S17_IN_0;	
	//
	assign DATA[119:104] = ADC_1[15:0];
	assign DATA[135:120] = ADC_2[15:0];
	assign DATA[151:136] = ADC_3[15:0];
	assign DATA[167:152] = ADC_4[15:0];
	assign DATA[183:168] = ADC_5[15:0];
	assign DATA[199:184] = ADC_6[15:0];
	//
	assign DATA[223:200] = ADC_T1[23:0];
	//assign DATA[247:224] = ADC_T1[23:0];
	//
	assign DATA[255:224] = DREHZAHL[31:0];
	//
endmodule
////////////////////////////////////////////////////////////////////////////////////////////
module DATA_OUT_VAR(
	input [255:0] DATA,
	//
	output RPI_TO_FPGA_15,
	output RPI_TO_FPGA_14,
	output RPI_TO_FPGA_13,
	output RPI_TO_FPGA_12,
	output RPI_TO_FPGA_11,
	output RPI_TO_FPGA_10,
	output RPI_TO_FPGA_09,
	output RPI_TO_FPGA_08,
	output RPI_TO_FPGA_07,
	output RPI_TO_FPGA_06,
	output RPI_TO_FPGA_05,
	output RPI_TO_FPGA_04,
	output RPI_TO_FPGA_03,
	output RPI_TO_FPGA_02,
	output RPI_TO_FPGA_01,
	output RPI_TO_FPGA_00,
	//
	output [15:0] RPI_TO_FPGA_16BIT_1,
	output [15:0] RPI_TO_FPGA_16BIT_2,
	output [15:0] RPI_TO_FPGA_16BIT_3,
	output [15:0] RPI_TO_FPGA_16BIT_4,
	// Hardware IO's 
	output FPGA_OUT_15,	
	output FPGA_OUT_14,	
	output FPGA_OUT_13,	
	output FPGA_OUT_12,	
	output FPGA_OUT_11,	
	output FPGA_OUT_10,	
	output FPGA_OUT_09,	
	output FPGA_OUT_08,		
	output FPGA_OUT_07,	
	output FPGA_OUT_06,	
	output FPGA_OUT_05,	
	output FPGA_OUT_04,	
	output FPGA_OUT_03,	
	output FPGA_OUT_02,	
	output FPGA_OUT_01,	
	output FPGA_OUT_00,			
	// IO Expander
	output MCP23S17_OUT_7,	
	output MCP23S17_OUT_6,	
	output MCP23S17_OUT_5,	
	output MCP23S17_OUT_4,	
	output MCP23S17_OUT_3,	
	output MCP23S17_OUT_2,	
	output MCP23S17_OUT_1,	
	output MCP23S17_OUT_0,	
	output [15:0] DAC_1,
	output [15:0] DAC_2,
	output [15:0] DAC_3	
	);
	//
	assign RPI_TO_FPGA_15            = DATA[000];
	assign RPI_TO_FPGA_14            = DATA[001];
	assign RPI_TO_FPGA_13            = DATA[002];
	assign RPI_TO_FPGA_12            = DATA[003];
	assign RPI_TO_FPGA_11            = DATA[004];
	assign RPI_TO_FPGA_10            = DATA[005];
	assign RPI_TO_FPGA_09            = DATA[006];
	assign RPI_TO_FPGA_08            = DATA[007];	
	assign RPI_TO_FPGA_07            = DATA[008];
	assign RPI_TO_FPGA_06            = DATA[009];
	assign RPI_TO_FPGA_05            = DATA[010];
	assign RPI_TO_FPGA_04            = DATA[011];
	assign RPI_TO_FPGA_03            = DATA[012];
	assign RPI_TO_FPGA_02            = DATA[013];
	assign RPI_TO_FPGA_01            = DATA[014];
	assign RPI_TO_FPGA_00            = DATA[015];	
	//
	assign RPI_TO_FPGA_16BIT_1[15:0] = DATA[031:016];	
	assign RPI_TO_FPGA_16BIT_2[15:0] = DATA[047:032];	
	assign RPI_TO_FPGA_16BIT_3[15:0] = DATA[063:048];	
	assign RPI_TO_FPGA_16BIT_4[15:0] = DATA[079:064];	
	//
	assign FPGA_OUT_15               = DATA[080];	
	assign FPGA_OUT_14               = DATA[081];	
	assign FPGA_OUT_13               = DATA[082];	
	assign FPGA_OUT_12               = DATA[083];	
	assign FPGA_OUT_11               = DATA[084];	
	assign FPGA_OUT_10               = DATA[085];	
	assign FPGA_OUT_09               = DATA[086];	
	assign FPGA_OUT_08               = DATA[087];	
	assign FPGA_OUT_07               = DATA[088];	
	assign FPGA_OUT_06               = DATA[089];	
	assign FPGA_OUT_05               = DATA[090];	
	assign FPGA_OUT_04               = DATA[091];	
	assign FPGA_OUT_03               = DATA[092];	
	assign FPGA_OUT_02               = DATA[093];	
	assign FPGA_OUT_01               = DATA[094];	
	assign FPGA_OUT_00               = DATA[095];	
	//
	assign MCP23S17_OUT_7            = DATA[096];	
	assign MCP23S17_OUT_6            = DATA[097];	
	assign MCP23S17_OUT_5            = DATA[098];	
	assign MCP23S17_OUT_4            = DATA[099];	
	assign MCP23S17_OUT_3            = DATA[100];	
	assign MCP23S17_OUT_2            = DATA[101];	
	assign MCP23S17_OUT_1            = DATA[102];	
	assign MCP23S17_OUT_0            = DATA[103];	
	//
	assign DAC_1[15:0] 					= DATA[119:104];
	assign DAC_2[15:0] 					= DATA[135:120];
	assign DAC_3[15:0] 					= DATA[151:136];
	//
endmodule
////////////////////////////////////////////////////////////////////////////////////////////
