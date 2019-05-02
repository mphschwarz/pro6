#include "defs.h"
#include "Nor_Flash.h"
#include "WB_Secureic.h"
#include "WB_Gneiss_Sample_Code_LLD.h"

int main()
{
   alt_u8   data[6],Byte_Mode=0;
   alt_u32  Address=0x000000;
   alt_u8   reg_Read_Data[256]= {0};

   alt_u8 ROOTKey[32];	// Rootkey array
   alt_u8 HMACKey[32];	// HMACkey array
   alt_u8 HMACMessage[4]; // HMAC message data, use for update HMAC key
   alt_u8 Input_tag[12];	// Input tag data for request conte
   alt_u8 Check_tag[12];	// Output tag data for verification
   alt_u8 Check_signature[32]; // Output signature
   alt_u8 RPMCStatus;
   unsigned int RPMC_counter;
   unsigned int i=0,j=0,a=0;
   memset(ROOTKey, 0xFF, sizeof(ROOTKey));
   memset(HMACKey, 0xFF, sizeof(HMACKey));
   memset(Check_signature, 0xFF, sizeof(Check_signature));
   memset(Check_tag, 0xFF, sizeof(Check_tag));
   memset(Input_tag, 0xFF, sizeof(Input_tag));

   //Configuration Register
   printf("== MAX1000 WB_SPI_Flash Demo ==\r\n");
   IOWR_ALTERA_AVALON_SPI_CONTROL(SPI_0_BASE,0x00);          //Initialize the spi control reg

   /* Read JEDEC ID Start */
   printf("JEDEC ID : %06x\n",Nor_JEDEC());
   /* Read JEDEC ID Over */

   /* Test SPI Flash Operation.  */

   /* Sector Erase Start
   Nor_Write_Enable();
   Nor_Erase(Address,1,Byte_Mode);
   while(Nor_BusyCheck());
   /* Sector Erase Over

   /* Write Data Start
   Nor_Write_Enable();
   Nor_Page_Program_Number(Address,Byte_Mode,0xaa,2);
   while(Nor_BusyCheck());
   /* Write Data Over

   /* Read Data Start
   Nor_Read_Data(Address,1,Byte_Mode,reg_Read_Data,2);
   /* Read Data Over

   for(i=0;i<2;i++){
	   printf("reg_Read_Data[%d] = %02Xh\r\n", i, reg_Read_Data[i]);
   }

   /* Test SPI Flash Operation Over . */

   //set RootKey all 1
   memset(ROOTKey, 0xFF, sizeof(ROOTKey));

   RPMCStatus = WB_RPMC_WrRootKey(2, ROOTKey);        // initial Rootkey, use first rootkey/counter pair

   if(RPMCStatus == 0x80){
     printf("Write RootKey  Success!\r\n");
   }
   else{
	 printf("Write RootKey Fail! RPMCStatus=0x%02x\r\n",RPMCStatus);
   }
   /* Second stage, update HMACKey after ever power on. without update HMACkey, Gneiss would not function*/
   //HMACMessage[0] = rand()%0x100;        // Get random data for HMAC message, it can also be serial number, RTC information and so on.
   //HMACMessage[1] = rand()%0x100;
   //HMACMessage[2] = rand()%0x100;
   //HMACMessage[3] = rand()%0x100;
   HMACMessage[0] = 't';
   HMACMessage[1] = 'e';
   HMACMessage[2] =	's';
   HMACMessage[3] = 't';
   /* Update HMAC key and get new HMACKey.
   HMACKey is generated by SW using Rootkey and HMACMessage.
   RPMC would also generate the same HMACKey by HW   */

   RPMCStatus = WB_RPMC_UpHMACkey(2, ROOTKey, HMACMessage, HMACKey);
   if(RPMCStatus == 0x80){
     // update HMACkey success
	   printf("update HMACkey  Success!\r\n");
   }
   else{
	   printf("update HMACkey  fail! RPMCStatus=0x%02x \r\n",RPMCStatus);
	   // write HMACkey fail, check datasheet for the error bit
   }
   /* update HMACKey operation done     */

   /* Third stage, increase RPMC counter */
   /* input tag is send in to RPMC, it could be time stamp, serial number and so on*/
   Input_tag[0] = '2'; //0x32  //50
   Input_tag[1] = '0'; //0x30  //48
   Input_tag[2] = '1'; //0x31  //49
   Input_tag[3] = '5'; //0x35  //53
   Input_tag[4] = '1'; //0x31  //49
   Input_tag[5] = '1'; //0x31  //49
   Input_tag[6] = '1'; //0x31  //49
   Input_tag[7] = '1'; //0x31  //49
   Input_tag[8] = '2'; //0x32  //50
   Input_tag[9] = '4'; //0x34  //52
   Input_tag[10] = '5'; //0x35 //53
   Input_tag[11] = '7'; //0x36 //54

   RPMCStatus = WB_RPMC_IncCounter(2, HMACKey, Input_tag);
   if(RPMCStatus == 0x80){
     // increase counter success
	   printf("increase counter  Success!\r\n");
   }
   else{
	   printf("increase counter  fail! RPMCStatus =0x%02x\r\n",RPMCStatus);
	   // increase counter fail, check datasheet for the error bit
   }
   /* counter data in stoage in public array counter[], data is available if WB_RPMC_IncCounter() operation successed */
   RPMC_counter = WB_RPMC_ReadCounterData();
   printf("RPMC_Counter Data = %ld\r\n",RPMC_counter);
   /* increase RPMC counter done*/

   /* Main security operation call challenge*/
   printf("-----Challenge-----:\r\n");
 	if(WB_RPMC_Challenge(2, HMACKey, Input_tag)!=0){
 		printf("signature miss-match!\r\n");
 		/* return signature miss-match */
 		return 1;
 	}
	else printf("Challenge Success!\r\n");

 }

