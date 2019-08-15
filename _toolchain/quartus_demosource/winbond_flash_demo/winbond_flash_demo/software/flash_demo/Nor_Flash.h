/*
 * Nor_Flash.h
 *
 *  Created on: 2017/7/19
 *      Author: YAChen1
 */

#ifndef NOR_FLASH_H_
#define NOR_FLASH_H_

#include "defs.h"

alt_u8 Nor_BusyCheck();
void Nor_Write_Enable();
void Nor_Erase(unsigned long Address,unsigned char Mode,unsigned char Byte_Mode);
unsigned long Nor_Page_Program_Number(unsigned long Address,unsigned char Byte_Mode,unsigned int Number,unsigned int Length);
alt_u32 Nor_JEDEC();
unsigned long Nor_Read_Data(unsigned long Address,unsigned char Mode,unsigned char Byte_Mode,alt_u8 *Get_Buff,unsigned long Length);



#endif /* NOR_FLASH_H_ */
