
/*
* ADXL345.c
*
*  Created on: Jun 18, 2015
*      Author: Franklin
*/

#include "ADXL345.h"
#include <stdio.h>
#include <math.h>
#include "utils.h"
// Common interface includes
#include "i2c_if.h"
#include "uart_if.h"
#include "gpio_if.h"

#define FAILURE				-1
#define SUCCESS				0
#define RET_IF_ERR(Func)	{int iRetVal = (Func); \
                                 if (SUCCESS != iRetVal) \
                                     return  iRetVal;}

int ADXL345init()
{
	unsigned char ucRegVal;
	RET_IF_ERR(ADXL345GetReg(_ADXL345_DEV_ID, &ucRegVal));
	Report("CHIP ID: 0x%x\n\r", ucRegVal);

	// Set Register for axis enable control for activity and inactivity detection
	RET_IF_ERR(ADXL345SetReg(ACT_INACT_CTL, 0x70));
	// Set Register for Data Format Control
	RET_IF_ERR(ADXL345SetReg(DATA_FORMAT, 0x00));
	//Set Register for Power Saving Controls
	RET_IF_ERR(ADXL345SetReg(POWER_CTL, 0x08));

	return SUCCESS;
}

int ADXL345ReadAcc(unsigned short *pcAccX, unsigned short *pcAccY, unsigned short *pcAccZ)
{
	unsigned char acc[6];
											//   |- We are reading six bytes only from the block
	int ret = ADXL345BlockRead(ADXL345_RA_DATAX0, acc , sizeof(acc));
	if (ret != SUCCESS)
	{
		return FAILURE;
	}
	*pcAccX = (acc[1] << 8) | (acc[0]);
	*pcAccY = (acc[3] << 8) | (acc[2]);
	*pcAccZ = (acc[5] << 8) | (acc[4]);

	return SUCCESS;
}

int ADXL345SetReg(unsigned char regAddr, unsigned char regValue)
{
	unsigned char ucDATA[2];

	ucDATA[0] = regAddr;
	ucDATA[1] = regValue;

	if (I2C_IF_Write(_ADXL345_DEV_ADD, ucDATA, 2, 1) == 0)
	{
		return SUCCESS;
	}
	return FAILURE;
}

int ADXL345GetReg(unsigned char regAddr, unsigned char *pucRegValue)
{
	if (I2C_IF_ReadFrom(_ADXL345_DEV_ADD, &regAddr, 1, pucRegValue, 1) != 0)
	{
		return FAILURE;
	}

	return SUCCESS;
}

int ADXL345BlockRead(unsigned char ucRegAddr, unsigned char *pucBLKData, unsigned int pucBLKDataSize)
{
	if (I2C_IF_ReadFrom(_ADXL345_DEV_ADD, &ucRegAddr, 1, pucBLKData, pucBLKDataSize) != 0)
	{
		return FAILURE;
	}
	return SUCCESS;
}
