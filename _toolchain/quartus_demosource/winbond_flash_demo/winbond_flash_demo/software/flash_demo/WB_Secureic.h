/*
  ******************************************************************************
  * @file    /WB_Secureic.h
  * @author  Winbond FAE YY Huang, FAE Steam Lin
  * @version V1.0.0
  * @date    15-June-2015
  * @brief   This code provide the Demo code for RPMC operation. Please do not copy the rootkey generate method directly.
		     Rootkey generate method should be keep in secret and should not exposed.

  *
  * COPYRIGHT 2015 Winbond Electronics Corporation.
*/

#ifndef WB_SECUREIC_H_
#define WB_SECUREIC_H_

#ifdef __cplusplus
 extern "C" {
#endif

#include "defs.h"
/* Includes ------------------------------------------------------------------*/

//--------------------------------------------------------------------------------------
//			RMPC Functions (13/04/23)
//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------

// DBL_INT_ADD treats two unsigned ints a and b as one 64-bit integer and adds c to it
#define DBL_INT_ADD(a,b,c) if (a > 0xffffffff - (c)) ++b; a += c;
#define ROTLEFT(a,b) (((a) << (b)) | ((a) >> (32-(b))))
#define ROTRIGHT(a,b) (((a) >> (b)) | ((a) << (32-(b))))
#define CH(x,y,z) (((x) & (y)) ^ (~(x) & (z)))
#define MAJ(x,y,z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
#define EP0(x) (ROTRIGHT(x,2) ^ ROTRIGHT(x,13) ^ ROTRIGHT(x,22))
#define EP1(x) (ROTRIGHT(x,6) ^ ROTRIGHT(x,11) ^ ROTRIGHT(x,25))
#define SIG0(x) (ROTRIGHT(x,7) ^ ROTRIGHT(x,18) ^ ((x) >> 3))
#define SIG1(x) (ROTRIGHT(x,17) ^ ROTRIGHT(x,19) ^ ((x) >> 10))
#define IPAD 0x36
#define OPAD 0x5C




//SIC Functions
void sha256(unsigned char *text1 ,unsigned char *output,unsigned int length);
void sha256_init(SHA256_CTX *ctx);
void sha256_update(SHA256_CTX *ctx, alt_u8 data[], alt_u32 len);
void sha256_final(SHA256_CTX *ctx, alt_u8 hash[]);
void sha256_transform(SHA256_CTX *ctx, alt_u8 data[]);
unsigned int hmacsha256( unsigned char *key, unsigned int  key_len, unsigned char *text, unsigned int  text_len, unsigned char *digest);


#endif /* WB_SECUREIC_H_ */
