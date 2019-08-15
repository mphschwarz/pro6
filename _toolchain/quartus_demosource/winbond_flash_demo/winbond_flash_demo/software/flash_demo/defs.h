#ifndef defs_H_
#define defs_H_

#include <stdio.h>
#include <stdlib.h> // malloc, free
#include <string.h>
#include <stddef.h>
#include <unistd.h>  // usleep (unix standard?)
#include "alt_types.h"  // alt_u32
#include "altera_avalon_pio_regs.h" //IOWR_ALTERA_AVALON_PIO_DATA
#include "sys/alt_irq.h"  // interrupt
#include "system.h"
#include "altera_avalon_spi_regs.h"

#define Nor_INS_Write_Enable 0x06
#define Nor_INS_Volatile_SR_Write_Enable 0x50
#define	Nor_INS_Write_Disable 0x04
#define	Nor_INS_Read_Status_Register_1 0x05
#define Nor_INS_Read_Status_Register_2 0x35
#define Nor_INS_Read_Status_Register_3 0x15
#define Nor_INS_Write_Status_Register_1 0x01
#define Nor_INS_Write_Status_Register_2 0x31
#define Nor_INS_Write_Status_Register_3 0x11
#define Nor_INS_Sector_Erase_4KB 0x20
#define Nor_INS_Block_Erase_32KB 0x52
#define Nor_INS_Block_Erase_64KB 0xD8
#define Nor_INS_Chip_Erase 0xC7
#define Nor_INS_Read_Data 0x03
#define Nor_INS_Fast_Read 0x0B
#define Nor_INS_Page_Program 0x02
#define Nor_INS_Read_Unique_ID 0x4B
#define Nor_INS_Read_SFDP_Register 0x5A
#define Nor_INS_Erase_Security_Register 0x44
#define Nor_INS_Program_Security_Register 0x42
#define Nor_INS_Read_Security_Register 0x48
#define Nor_INS_JEDEC_ID 0x9F
#define Nor_INS_Manufacturer_ID 0x90
#define Nor_INS_Enter_4Byte_Address_Mode 0xB7
#define Nor_INS_Exit_4Byte_Address_Mode 0xE9
#define Nor_INS_Enable_Reset 0x66
#define Nor_INS_Reset_Device 0x99
#define Nor_INS_Power_Down 0xB9
#define Nor_INS_Release_Power_Down 0xAB
#define Nor_INS_Suspend 0x75
#define Nor_INS_Resume 0x7A
#define Nor_INS_Die_Select 0xC2


typedef struct {
	alt_u8 data[64];
	alt_u32 datalen;
	alt_u32 bitlen[2];
	alt_u32 state[8];
} SHA256_CTX;

#endif
