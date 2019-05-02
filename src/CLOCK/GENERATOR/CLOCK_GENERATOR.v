module 	CLOCK_GENERATOR(
	input CLK, 
	output reg CLOCK_1MHz,
	output reg CLOCK_500kHz,	
	output reg CLOCK_100kHz,
	output reg CLOCK_50kHz,	
	output reg CLOCK_10kHz,	
	output reg CLOCK_5kHz,	
	output reg CLOCK_1kHz,
	output reg CLOCK_100Hz,
	output reg CLOCK_10Hz,
	output reg CLOCK_1Hz);
//
// ToDo: Optimierung der Bitbreite
reg	[31:0]COUNTER1M;
reg	[31:0]COUNTER500k;
reg	[31:0]COUNTER100k;
reg	[31:0]COUNTER50k;
reg	[31:0]COUNTER10k;
reg	[31:0]COUNTER5k;
reg	[31:0]COUNTER1k;
reg	[31:0]COUNTER100;
reg	[31:0]COUNTER10;
reg	[31:0]COUNTER1;
//
initial begin
 	COUNTER1M <= 0;
	COUNTER500k <= 0;
 	COUNTER100k <= 0;
	COUNTER50k <= 0;
	COUNTER10k <= 0;
	COUNTER1k <= 0;
	COUNTER5k <= 0;
	COUNTER100 <= 0;
	COUNTER10 <= 0;
	COUNTER1 <= 0;
 end
//
always @(posedge CLK) begin
	//
	COUNTER1M <= COUNTER1M + 1;
	COUNTER500k <= COUNTER500k + 1;
	COUNTER100k <= COUNTER100k + 1;
	COUNTER50k <= COUNTER50k + 1;
	COUNTER10k <= COUNTER10k + 1;
	COUNTER5k <= COUNTER5k + 1;
 	COUNTER1k <= COUNTER1k + 1;
	COUNTER100 <= COUNTER100 + 1;
	COUNTER10 <= COUNTER10 + 1;
	COUNTER1 <= COUNTER1 + 1;
	//
	if(COUNTER1M == 25) begin
		COUNTER1M <= 0;
		CLOCK_1MHz <= !CLOCK_1MHz;
	end
	//
	if(COUNTER500k == 50) begin
		COUNTER500k <= 0;
		CLOCK_500kHz <= !CLOCK_500kHz;
	end		
	//
	if(COUNTER100k == 250) begin
		COUNTER100k <= 0;
		CLOCK_100kHz <= !CLOCK_100kHz;
	end	
	//
	if(COUNTER50k == 500) begin
		COUNTER50k <= 0;
		CLOCK_50kHz <= !CLOCK_50kHz;
	end	
	//
	if(COUNTER10k == 2500) begin
		COUNTER10k <= 0;
		CLOCK_10kHz <= !CLOCK_10kHz;
	end	
	//
	if(COUNTER5k == 5000) begin
		COUNTER5k <= 0;
		CLOCK_5kHz <= !CLOCK_5kHz;
	end	
	//
	if(COUNTER1k == 25000) begin
		COUNTER1k <= 0;
		CLOCK_1kHz <= !CLOCK_1kHz;
	end		
	//
	if(COUNTER100 == 250000) begin
		COUNTER100 <= 0;
		CLOCK_100Hz <= !CLOCK_100Hz;
	end	
	//
	if(COUNTER10 == 2500000) begin
		COUNTER10 <= 0;
		CLOCK_10Hz <= !CLOCK_10Hz;
	end	
	//
	if(COUNTER1 == 25000000) begin
		COUNTER1 <= 0;
		CLOCK_1Hz <= !CLOCK_1Hz;
	end	
	//
end
//
endmodule

