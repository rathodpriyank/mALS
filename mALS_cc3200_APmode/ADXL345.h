
/*
* ADXL345.h
*
*  Created on: Jun 18, 2015
*      Author: Franklin
*/

//*****************************
// Defining Sensor
//*****************************
#ifndef _ADXL345_H_
#define _ADXL345_H_



//*****************************
// If in C++, then bind to C
//*****************************
#ifdef _cplusplus
extern "C"
{
#endif

// 0x53 // alt address pin low (GND)
// 0x1D // alt address pin high (VCC)

	//*****************************
	// I2C Address
	//*****************************
#define _ADXL345_DEV_ADD		0x53
#define _ADXL345_DEV_ID			0x00

#define	CHIP_ID					0xe5


	//*****************************
	// Address for configurations
	//*****************************
#define ACT_INACT_CTL			0x27
#define POWER_CTL 				0x2D
#define DATA_FORMAT				0x31
#define ADXL345_PCTL_LINK_BIT       5
#define ADXL345_PCTL_AUTOSLEEP_BIT  4
#define ADXL345_PCTL_MEASURE_BIT    3
#define ADXL345_PCTL_SLEEP_BIT      2
#define ADXL345_PCTL_WAKEUP_BIT     1
#define ADXL345_PCTL_WAKEUP_LENGTH  2



	//*****************************
	// Addresses of acceleration readers
	//*****************************
#define ADXL345_RA_DATAX0           0x32
#define ADXL345_RA_DATAX1           0x33
#define ADXL345_RA_DATAY0           0x34
#define ADXL345_RA_DATAY1           0x35
#define ADXL345_RA_DATAZ0           0x36
#define ADXL345_RA_DATAZ1           0x37



	//*****************************
	// Function Protoypes
	//*****************************
	int ADXL345init();
	int ADXL345ReadAcc(unsigned short *pcAccX, unsigned short *pcAccY, unsigned short *pcAccZ);
	int ADXL345GetReg(unsigned char regAddr, unsigned char *pucRegValue);
	int ADXL345SetReg(unsigned char regAddr, unsigned char regValue);
	int ADXL345BlockRead(unsigned char ucRegAddr, unsigned char *pucBLKData, unsigned int pucBLKDataSize);
	//*****************************
	// End of C binding
	//*****************************
#ifdef _cplusplus
}
#endif

#endif

