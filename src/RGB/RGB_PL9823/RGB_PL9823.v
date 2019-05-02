///////////////////////////////////////////////////////////////////////////////
module RGB_PL9823( 
	input CLK,
	input [7:0] D1_ROT,
	input [7:0] D1_GRUEN,
	input [7:0] D1_BLAU,	
	input [7:0] D2_ROT,
	input [7:0] D2_GRUEN,
	input [7:0] D2_BLAU,	
	input [7:0] D3_ROT,
	input [7:0] D3_GRUEN,
	input [7:0] D3_BLAU,		
	output reg OUT
	);
	//
	reg [0:72] data;
	reg [7:0] i;
	reg [11:0] ctr;
	reg [1:0] state;
	//
	initial
	begin
		OUT <= 0;
		data <= 0;
		i <= 0;
		ctr <= 1;
		state <= 0;
	end
	//
	always @(posedge CLK)
	begin
	if (state == 0) 
		begin
		ctr <= ctr + 1;
		OUT <= 0;
		//				
		data[00:07] <= D1_ROT[7:0];
		data[08:15] <= D1_GRUEN[7:0];
		data[16:23] <= D1_BLAU[7:0];	
		//
		data[24:31] <= D2_ROT[7:0];
		data[32:39] <= D2_GRUEN[7:0];
		data[40:47] <= D2_BLAU[7:0];
		//
		data[48:55] <= D3_ROT[7:0];
		data[56:63] <= D3_GRUEN[7:0];
		data[64:71] <= D3_BLAU[7:0];
		//
		data[72] <= 0;
		//
		if (ctr == 3000) 
			begin
			state <= 1;
			ctr <= 1;
			i <= 0;
			end
		end
	//
	if (state == 1) 
		begin
		if (i == 72) 
			begin
			state <= 0;
			ctr <= 1;
			i <= 0;
			end
		//
		ctr <= ctr + 1;
		if (ctr == 86) 
			begin
			ctr <= 1;
			i <= i + 1;
			end	
		//
		if (i < 72)
			begin
			if (data[i] == 1) 
				begin
				//
				if (ctr <= 68)
					OUT <= 1;
				else
					OUT <= 0;
				//
				end
			else
				begin
				//
				if (ctr <= 18)
					OUT <= 1;
				else
					OUT <= 0;
				//
				end
			end
		end
	end
endmodule
///////////////////////////////////////////////////////////////////////////////