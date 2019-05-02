/*
 * Nor_Flash.c

 *
 *  Created on: 2017/7/19
 *      Author: YAChen1
 */
#include "Nor_Flash.h"

alt_u8 Nor_BusyCheck()
{
	alt_u8 Send_Buff[1] ={0x00};
	alt_u8 Get_Buff[1] = {0x00};
    Send_Buff[0] = Nor_INS_Read_Status_Register_1;  //Status Register-1 : 05h
    alt_avalon_spi_command(SPI_0_BASE, 0, 1, Send_Buff, 1, Get_Buff, 0);
	//printf("%d\n",Status_Data);
    return (Get_Buff[0]&0x01);
}

void Nor_Write_Enable()
{
	alt_u8 Send_Buff[1]={0xFF};
	alt_u8 Get_Buff[1]={0xFF};
	//printf("---Write Enable!--- \n");
    Send_Buff[0] = Nor_INS_Write_Enable;  //Write enable 06h.
    alt_avalon_spi_command(SPI_0_BASE, 0, 1, Send_Buff, 0, Get_Buff, 0);
    //printf("---Write Enable is done!--- \n");
}

void Nor_Erase(unsigned long Address,unsigned char Mode,unsigned char Byte_Mode)
{
	//Erase
	//IN : Address ,Mode(0:4KB,1:32KB,2:64KB,3:whole),Byte_Mode(0:3Byte,1:4Byte)
	//OUT: ES Timecost
	alt_u8 add[4]={0};
    alt_u8 Send_Buff[5];
    alt_u8 Get_Buff[5];

    memset(Send_Buff, 0xFF, sizeof(Send_Buff));
    memset(Get_Buff, 0xFF, sizeof(Get_Buff));
    add[0]=Address%256;
	add[1]=(Address>>8)%256;
	add[2]=(Address>>16)%256;
	add[3]=(Address>>24)%256;

    switch(Mode){
		case 0:    //4KB erase
			Send_Buff[0]=Nor_INS_Sector_Erase_4KB;
			if(Byte_Mode==0){
				Send_Buff[1] = add[2];Send_Buff[2] = add[1];Send_Buff[3] = add[0];  //MSB first
				alt_avalon_spi_command(SPI_0_BASE, 0, 4, Send_Buff, 0, Get_Buff, 0); //Send_Buff is 4Byte.
			}
			else if(Byte_Mode==1){
				Send_Buff[1] = add[3];Send_Buff[2] = add[2];Send_Buff[3] = add[1];Send_Buff[4] = add[0];  //MSB first
				alt_avalon_spi_command(SPI_0_BASE, 0, 5, Send_Buff, 0, Get_Buff, 0);        //Send_Buff is 5Byte.
			}
			else {
				printf("ES,Byte_Mode ERROR.\n");
			}
		break;
		case 1:    //32KB erase
			Send_Buff[0]=Nor_INS_Block_Erase_32KB;
			if(Byte_Mode==0){
				Send_Buff[1] = add[2];Send_Buff[2] = add[1];Send_Buff[3] = add[0];  //MSB first
				alt_avalon_spi_command(SPI_0_BASE, 0, 4, Send_Buff, 0, Get_Buff, 0);;        //Send_Buff is 4Byte.
			}
			else if(Byte_Mode==1){
				Send_Buff[1] = add[3];Send_Buff[2] = add[2];Send_Buff[3] = add[1];Send_Buff[4] = add[0];  //MSB first
				alt_avalon_spi_command(SPI_0_BASE, 0, 5, Send_Buff, 0, Get_Buff, 0);        //Send_Buff is 5Byte.
			}
			else {
				printf("ES,Byte_Mode ERROR.\n");
			}
		break;
		case 2:    //64KB erase
			Send_Buff[0]=Nor_INS_Block_Erase_64KB;
			if(Byte_Mode==0){
				Send_Buff[1] = add[2];Send_Buff[2] = add[1];Send_Buff[3] = add[0];  //MSB first
				alt_avalon_spi_command(SPI_0_BASE, 0, 4, Send_Buff, 0, Get_Buff, 0);        //Send_Buff is 4Byte.
			}
			else if(Byte_Mode==1){
				Send_Buff[1] = add[3];Send_Buff[2] = add[2];Send_Buff[3] = add[1];Send_Buff[4] = add[0];  //MSB first
				alt_avalon_spi_command(SPI_0_BASE, 0, 5, Send_Buff, 0, Get_Buff, 0);        //Send_Buff is 5Byte.
			}
			else {
				printf("ES,Byte_Mode ERROR.\n");
			}
		break;
		case 3:    //Chip erase
			Send_Buff[0]=Nor_INS_Chip_Erase;
			alt_avalon_spi_command(SPI_0_BASE, 0, 1, Send_Buff, 0, Get_Buff, 0);        //Send_Buff is 5Byte.
		break;
		default:
			printf("ES_Mode ERROR\n");
		break;
		//return 1;
	}
}

unsigned long Nor_Page_Program_Number(unsigned long Address,unsigned char Byte_Mode,unsigned int Number,unsigned int Length){
    //page program
	//IN : Address ,Byte_Mode(0:3Byte,1:4Byte),*fin(fread FILE*)
	//OUT: PP checksum
	alt_u8 add[4]={0};
	alt_u32 i=0,Number_Buf[2]={0};
    unsigned long Sum=0;
    alt_u8 Send_Buff[Length+5];
    alt_u8 Get_Buff[Length+5];

    memset(Send_Buff, 0XFF, sizeof(Send_Buff));
    memset(Get_Buff, 0xFF, sizeof(Get_Buff));
	add[0]=Address%256;
	add[1]=(Address>>8)%256;
	add[2]=(Address>>16)%256;
	add[3]=(Address>>24)%256;
	if(Number>0xff){
		Number_Buf[0]=Number%256;
		Number_Buf[1]=(Number>>8)%256;
	}
	else Number_Buf[0]=Number_Buf[1]=Number;

    switch(Byte_Mode){
		case 0:       //3BYTE
			Send_Buff[0] = Nor_INS_Page_Program;  //Page Program : 02h
			Send_Buff[1] = add[2];Send_Buff[2] = add[1];Send_Buff[3] = add[0];  //MSB first
			for(i=0;i<Length;i++){
				//Send_Buff[i+4]=Number_Buf[i%2];
				Send_Buff[i+4]=i;
			}
			for(i=4;i<4+Length;i++){
				Sum=Sum+Send_Buff[i];
			}
			alt_avalon_spi_command(SPI_0_BASE, 0, Length+4, Send_Buff, 0, Get_Buff, 0);  //Send_Buff is 4Byte.
		break;
		case 1:       //4BYTE
			Send_Buff[0] = Nor_INS_Page_Program;  //Page Program : 02h
			Send_Buff[1] = add[3];Send_Buff[2] = add[2];Send_Buff[3] = add[1];Send_Buff[4] = add[0];  //MSB first
			for(i=0;i<Length;i++){
				Send_Buff[i+5]=Number_Buf[i%2];
			}
			for(i=5;i<5+Length;i++){
				Sum=Sum+Send_Buff[i];
			}
			alt_avalon_spi_command(SPI_0_BASE, 0, Length+5, Send_Buff, 0, Get_Buff, 0);  //Send_Buff is 5Byte.
		break;
		default:
			printf("Program Number error\n");
		break;
	}
	return Sum;
}
unsigned long Nor_Read_Data(unsigned long Address,unsigned char Mode,unsigned char Byte_Mode,alt_u8 *Get_Buff,unsigned long Length)
{
	//Read Data
	//IN : Address,Mode(0:es checksum verify,1:pp checksum verify,2:Read Data)
	//OUT: checksum
	alt_u8 add[4]={0};
    unsigned long i=0;
    alt_u8 Send_Buff[Length+5];
    //alt_u8 Get_Buff[Length+5];
    unsigned long cks=0;

    memset(Send_Buff, 0xFF, sizeof(Send_Buff));
    memset(Get_Buff, 0xFF, sizeof(Get_Buff));
    add[0]=Address%256;
	add[1]=(Address>>8)%256;
	add[2]=(Address>>16)%256;
	add[3]=(Address>>24)%256;

	switch(Byte_Mode){
		case 0:
			Send_Buff[0] = Nor_INS_Read_Data;  //READ DATA : 03h
			Send_Buff[1] = add[2];Send_Buff[2] = add[1];Send_Buff[3] = add[0];  //MSB first
			alt_avalon_spi_command(SPI_0_BASE, 0, 4, Send_Buff, Length, Get_Buff, 0);  //Send_Buff is 3Byte.
			//bcm2835_spi_transfernb(Send_Buff, Get_Buff, Length+4);
		break;
		case 1:
			Send_Buff[0] = Nor_INS_Read_Data;  //READ DATA : 03h
			Send_Buff[1] = add[3];Send_Buff[2] = add[2];Send_Buff[3] = add[1];Send_Buff[4] = add[0];  //MSB first
			alt_avalon_spi_command(SPI_0_BASE, 0, 5, Send_Buff, Length, Get_Buff, 0);  //Send_Buff is 4Byte.
			//bcm2835_spi_transfernb(Send_Buff, Get_Buff, Length+5);
        break;
        default:
			printf("RD ERROR\n");
		break;
	}
	switch(Mode){
		case 0:
		    cks=0xff;
		    for(i=4+Byte_Mode;i<(Length+4+Byte_Mode);i++){
               cks=cks&Get_Buff[i];
			}
		break;
		case 1:
		    for(i=4+Byte_Mode;i<(Length+4+Byte_Mode);i++){
               cks=cks+Get_Buff[i];
			}
		break;
		case 2:
			//fwrite((Get_Buff+4+Byte_Mode), 1, Length, fout);   //store on RD.bin
		    for(i=4+Byte_Mode;i<Length+4+Byte_Mode;i++){
               cks=cks+Get_Buff[i];
			}
		break;
    }
    return cks;
}

alt_u32 Nor_JEDEC(){

	alt_u8 Send_Buff[0x01];
	alt_u8 Get_Buff[0x03];
	alt_u32 read_data = 0;
    memset(Send_Buff, 0xFF, sizeof(Send_Buff));
    memset(Get_Buff, 0xFF, sizeof(Get_Buff));

    Send_Buff[0] = Nor_INS_JEDEC_ID;  //JEDEC ID : 9Fh
    alt_avalon_spi_command(SPI_0_BASE, 0, 1, Send_Buff, 3, Get_Buff, 0);
    read_data = (Get_Buff[0]<<16)|(Get_Buff[1]<<8)|(Get_Buff[2]);
    //printf("JEDEC ID : %06x\n",read_data);

    return read_data;
}



