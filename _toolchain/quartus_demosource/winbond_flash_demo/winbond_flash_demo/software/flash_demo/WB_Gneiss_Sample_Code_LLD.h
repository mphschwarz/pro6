/*
 * WB_Gneiss_Sample_Code_LLD.h
 *
 *  Created on: 2017/7/19
 *      Author: YAChen1
 */

#ifndef WB_GNEISS_SAMPLE_CODE_LLD_H_
#define WB_GNEISS_SAMPLE_CODE_LLD_H_


#include "defs.h"

unsigned int WB_RPMC_ReadCounterData();
unsigned int WB_RPMC_ReadRPMCstatus(unsigned int checkall);
unsigned int WB_RPMC_WrRootKey(unsigned int cadr,unsigned char *rootkey);
unsigned int WB_RPMC_UpHMACkey(unsigned int cadr,unsigned char *rootkey,unsigned char *hmac4,unsigned char *hmackey);
unsigned int WB_RPMC_IncCounter(unsigned int cadr,unsigned char *hmackey,unsigned char *input_tag);
unsigned char WB_RPMC_Challenge(unsigned int cadr,unsigned char *hmackey,unsigned char *input_tag);
void WB_RPMC_ReqCounter(unsigned int cadr, unsigned char *hmackey,unsigned char *tag);


#endif /* WB_GNEISS_SAMPLE_CODE_LLD_H_ */
