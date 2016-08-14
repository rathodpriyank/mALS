/*
 * additionalFiles.c
 *
 *  Created on: Jul 30, 2015
 *      Author: Priyank
 */
#include "stdio.h"
#include "strings.h"
#include "stdlib.h"
#include "hw_types.h"
#include "hw_ints.h"
#include "hw_memmap.h"
#include "rom_map.h"
#include "common.h"
#include "timer.h"
#include "wlan.h"
#include "gpio.h"
#include "gpio_if.h"
#include "network_if.h"
#include "prcm.h"
#include "uart_if.h"
#include "fs.h"
#include "additionalFiles.h"

//MQTT Library includes
#include "sl_mqtt_client.h"
#include "sl_mqtt_server.h"

// application specific includes
#include "pinmux.h"
#include "server_client_cbs.h"

/* Globale Variables */
char *g_Ssid 			= MY_SSID;
char *g_SecurityKey		= MY_SECURITY_KEY;
int g_defaultTimeout	= DEFAULT_TIMEOUT;
char *g_tempBuf;
char *g_pairedMac = "AABBCCDDEEFF";
int g_deviceMode = SENSOR_MODE;

/* Create the list of files here */
const char *device_files[] = { WIFI_CONFIG, LOCL_CONFIG, NOTF_CONFIG, PAIR_CONFIG };

/* AP Security Parameters */
SlSecParams_t SecurityParams = {0};

/*Message Queue*/
OsiMsgQ_t g_PBQueue;

/* Application specific status/error codes */
#define FILE_ALREADY_EXIST  	-11
#define FILE_CLOSE_ERROR 		FILE_ALREADY_EXIST - 1
#define FILE_NOT_MATCHED 		FILE_CLOSE_ERROR - 1
#define FILE_OPEN_READ_FAILED 	FILE_NOT_MATCHED - 1
#define FILE_OPEN_WRITE_FAILED 	FILE_OPEN_READ_FAILED -1
#define FILE_READ_FAILED 		FILE_OPEN_WRITE_FAILED - 1
#define EMPTY_FILE_FOUND 		FILE_READ_FAILED - 1
#define FILE_WRITE_FAILED 		EMPTY_FILE_FOUND - 1

//*****************************************************************************
//
//!  This funtion includes the following steps:
//!  - Checks the file wheather it is present in the system or not
//!  - If file is not present it will create the file as per the file list on device
//!  - close the user file
//!
//!
//!  /return  0:Success, -ve: failure
//
//*****************************************************************************
int CheckAndCreateFile()
{
	unsigned long ulToken;
	long lFileHandle;
	SlFsFileInfo_t fileInfo;
	int i = 0;
	int lRetVal = -1;

	for ( i = 0; i < sizeof(device_files)/sizeof(device_files[i]); i++ )
	{
		//sl_FsDel(device_files[i], 0);
		lRetVal = sl_FsGetInfo((const _u8*)device_files[i], 0, &fileInfo);
		if (lRetVal < 0)
		{
			UART_PRINT("sl_FsGetInfo failed, Need to create [%s] file \r\n", device_files[i]);
			//  create a user file
			lRetVal = sl_FsOpen((const _u8*)device_files[i],
								FS_MODE_OPEN_CREATE(65536, \
								  _FS_FILE_OPEN_FLAG_COMMIT|_FS_FILE_PUBLIC_WRITE),
								&ulToken,
								&lFileHandle);
			if ( lRetVal == 0 )
			{

				lRetVal = sl_FsClose(lFileHandle, 0, 0, 0);
				if (SL_RET_CODE_OK != lRetVal)
				{
					return FILE_CLOSE_ERROR;
				}
			}
		}
		else
		{
			UART_PRINT("sl_FsGetInfo success, [%s] file is present \r\n", device_files[i]);
		}
	}
	return SUCCESS;
}

//*****************************************************************************
//
//!  This funtion includes the following steps:
//!  - open a user file for writing
//!  - write the supplied buffer
//!  - close the user file
//!
//!  /param[in] fName : Name of the file to be written
//!  /param[in] pData : Data which needs to be written
//!
//!  /return  0:Success, -ve: failure
//
//*****************************************************************************
long WriteFileToDevice(const char *fName, const char *pData)
{
	unsigned long ulToken;
	long lFileHandle;
    long lRetVal = -1;

    //  open a user file for writing
    lRetVal = sl_FsOpen((const _u8*)fName, FS_MODE_OPEN_WRITE,
                        &ulToken, &lFileHandle);
    if(lRetVal < 0)
    {
        lRetVal = sl_FsClose(lFileHandle, 0, 0, 0);
        return FILE_OPEN_WRITE_FAILED;
    }

    // write the test buffer to another file.
	lRetVal = sl_FsWrite(lFileHandle, 0, (_u8*) pData, strlen(pData));
	if (lRetVal < 0)
	{
		lRetVal = sl_FsClose(lFileHandle, 0, 0, 0);
		return FILE_WRITE_FAILED;
	}

    // close the user file
    lRetVal = sl_FsClose(lFileHandle, 0, 0, 0);
    if (SL_RET_CODE_OK != lRetVal)
    {
        return FILE_CLOSE_ERROR;
    }
    return SUCCESS;
}

//*****************************************************************************
//
//!  This funtion includes the following steps:
//!    -open the user file for reading
//!    -read the data and compare with the stored buffer
//!    -close the user file
//!
//!  /param[in] ulToken : file token
//!  /param[in] lFileHandle : file handle
//!
//!  /return 0: success, -ve:failure
//
//*****************************************************************************
long ReadFileFromDevice(const _u8 *fName, _u8 *pData)
{
	unsigned long ulToken;
	long lFileHandle;
    long lRetVal = -1;
    SlFsFileInfo_t fileInfo;

    // Checking if file is present or not
    int Status = sl_FsGetInfo(fName, 0, &fileInfo);
    if (Status < 0)
    	return FILE_READ_FAILED;

    if ( fileInfo.FileLen < 1 )
    	return EMPTY_FILE_FOUND;

    // open a user file for reading
    lRetVal = sl_FsOpen((const unsigned char*)fName,
                        FS_MODE_OPEN_READ,
                        &ulToken,
                        &lFileHandle);
    if(lRetVal < 0)
    {
        lRetVal = sl_FsClose(lFileHandle, 0, 0, 0);
        return FILE_OPEN_READ_FAILED;
    }

    // read the data
    lRetVal = sl_FsRead(lFileHandle, 0, pData, fileInfo.FileLen);
	if (lRetVal < 0)
	{
		lRetVal = sl_FsClose(lFileHandle, 0, 0, 0);
		return FILE_READ_FAILED;
	}

    // close the user file
    lRetVal = sl_FsClose(lFileHandle, 0, 0, 0);
    if (SL_RET_CODE_OK != lRetVal)
        return FILE_CLOSE_ERROR;

    return SUCCESS;
}

//****************************************************************************
//
//! Push Button Handler1(GPIOSW2). Press push button1 (GPIOSW2) Whenever user
//! wants to publish a message. Write message into message queue signaling the
//! event publish messages
//!
//! \param none
//!
//! return none
//
//****************************************************************************
void
pushButtonInterruptHandler2()
{
	struct msg_queue queue_element;
    queue_element.event = PUB_PUSH_BUTTON_PRESSED;
    queue_element.msg_ptr = NULL;
    //
    // write message indicating publish message
    //
    osi_MsgQWrite(&g_PBQueue,&queue_element,OSI_NO_WAIT);
}

//****************************************************************************
//
//! Push Button Handler2(GPIOSW3). Press push button3 Whenever user wants to discoonect
//! from the remote broker. Write message into message queue indicating
//! disconnect from broker.
//!
//! \param none
//!
//! return none
//
//****************************************************************************
void
pushButtonInterruptHandler3()
{
    struct msg_queue queue_element;
    queue_element.event = RESET_PUSH_BUTTON_PRESSED;
    queue_element.msg_ptr = NULL;
    //
    // write message indicating publish message
    //
    osi_MsgQWrite(&g_PBQueue,&queue_element,OSI_NO_WAIT);
}

//****************************************************************************
//
//!    \brief Connects to the Network in AP or STA Mode - If ForceAP Jumper is
//!                                             Placed, Force it to AP mode
//!
//! \return  0 - Success
//!            -1 - Failure
//
//****************************************************************************
long ReadConfigAndConnectToNetwork()
{
	GPIO_IF_LedConfigure(LED1|LED2|LED3);
    Network_IF_ResetMCUStateMachine();

   char ssid[12];
   long lRetVal = -1;
   unsigned short len = 32;
   unsigned short config_opt = WLAN_AP_OPT_SSID;

   lRetVal = Network_IF_InitDriver(ROLE_AP);
	if(lRetVal < 0)
	{
	   UART_PRINT("Failed to start SimpleLink Device\n\r",lRetVal);
	}

	// just checking the wifi settings and checking the ssid and other stuff
   sl_WlanGet(SL_WLAN_CFG_AP_ID, &config_opt , &len, (unsigned char* )ssid);
   UART_PRINT("\n\r Connect to : \'%s\'\n\r\n\r", ssid);

   // Reading device related configuration configuration
   ReadConfiguration();
   return SUCCESS;
}

void WriteDefaultValuesToAllFiles (const char* fName)
{
	const char *pData[32];
	bzero(pData, sizeof(pData));
	if ( strcmp((const char*)fName, LOCL_CONFIG) == 0 )
		snprintf((char*)pData, sizeof(pData), "%s %d %d %d", g_tempBuf, g_defaultTimeout, g_AccThreshold, g_ThresholdRange);
	else if ( strcmp((const char*)fName, NOTF_CONFIG) == 0 )
		snprintf((char*)pData, sizeof(pData), "%s %s %s %s %s", g_tempBuf, data[0], data[1], data[2], data[3] );
	else if ( strcmp((const char*)fName, WIFI_CONFIG) == 0 )
		snprintf((char*)pData, sizeof(pData), "%s %s %s", g_tempBuf, g_Ssid, g_SecurityKey );
	else if ( strcmp((const char*)fName, PAIR_CONFIG) == 0 )
	{
		snprintf((char*)pData, sizeof(pData), "%s %s %d", g_tempBuf, g_pairedMac, g_deviceMode );
		UART_PRINT("g_pairedMac [%s] [%s]-- \r\n", pData, g_pairedMac, g_deviceMode );
	}
	else
		snprintf((char*)pData, sizeof(pData), "Testing data for a [%s]", fName);
	UART_PRINT("Writing this data *--[%s]--[%s]--* \r\n", fName, pData);
	WriteFileToDevice(fName, (const char*)pData);
}

void parseString(const char *fName, const char *parseData)
{
	if ( strcmp(fName, WIFI_CONFIG) == 0 )
		sscanf(parseData,"%s %s %s", g_tempBuf, g_Ssid, g_SecurityKey );
	else if ( strcmp(fName, LOCL_CONFIG) == 0 )
		sscanf(parseData,"%s %d %d %d", g_tempBuf, &g_defaultTimeout, &g_AccThreshold, &g_ThresholdRange);
	else if ( strcmp(fName, NOTF_CONFIG) == 0 )
		sscanf(parseData,"%s %s %s %s %s", g_tempBuf, data[0], data[1], data[2], data[3] );
	else if ( strcmp(fName, PAIR_CONFIG) == 0 )
		sscanf(parseData,"%s %s %d", g_tempBuf, g_pairedMac, &g_deviceMode );
	else
		UART_PRINT("No proper file name found \r\n");
}

void ReadConfiguration()
{
	unsigned char readingBuffer[BUF_SIZE];
	long lRetVal = -1;
	int i = 0;

	lRetVal = CheckAndCreateFile();
	if ( lRetVal == SUCCESS )
	{
		for ( i = 0; i < sizeof(device_files)/sizeof(device_files[i]); i++ )
		{
			bzero(readingBuffer, sizeof(readingBuffer));
			lRetVal = ReadFileFromDevice((const _u8*)device_files[i], readingBuffer);
			if (lRetVal == EMPTY_FILE_FOUND || lRetVal == FILE_READ_FAILED )
			{
				WriteDefaultValuesToAllFiles(device_files[i]);
			}
			else if ( lRetVal == SUCCESS )
			{
				parseString((const char*)device_files[i], (const char*) readingBuffer);
			}
		}
	}
}

// This is only done when it receives the message from the server.
void parseAndProcess( const char *recvTopic, const char *recvPayload )
{
	int i = 0;
	int iLoopCnt = 0;
	unsigned char tempBuf[32];
	// For Alarm
	if ( strstr (recvTopic, sub_topics[0]) != 0  )
	{
		if ( strstr ( recvPayload, "ON" ) != 0 )
		{
			g_stopPublishing = false;
			GPIO_IF_LedOn(MCU_RED_LED_GPIO);
			InitPWMModules();
	        for( iLoopCnt = 0; iLoopCnt < 2000; iLoopCnt++ )
				UpdateDutyCycle(TIMERA2_BASE, TIMER_B, iLoopCnt);
			osi_Sleep(100);
		}
		else if ( strstr ( recvPayload, "OFF" ) != 0 )
		{
			UART_PRINT("Stopping the buzzer \r\n");
			g_stopPublishing = true;
			GPIO_IF_LedOff(MCU_RED_LED_GPIO);
			MAP_TimerDisable(TIMERA2_BASE, TIMER_B);
		}
	}
	// For config updates
	else if ( strstr (recvTopic,sub_topics[1]) != 0  )
	{
		if  ( strstr (recvPayload, WIFI_CONFIG) != 0  )
		{
			WriteFileToDevice(WIFI_CONFIG, recvPayload);
			parseString(WIFI_CONFIG, recvPayload);
			ReadFileFromDevice(WIFI_CONFIG, tempBuf);
		}
		if  ( strstr (recvPayload, NOTF_CONFIG) != 0  )
		{
			WriteFileToDevice(NOTF_CONFIG, recvPayload);
			parseString(NOTF_CONFIG, recvPayload);
			for ( i = 0; i < sizeof(data)/sizeof(data[i]); i++ )
				UART_PRINT("data - %d - %s \r\n", i , data[i]);
		}
		if ( strstr (recvPayload, LOCL_CONFIG) != 0  )
		{
			WriteFileToDevice(LOCL_CONFIG, recvPayload);
			parseString(LOCL_CONFIG, recvPayload);
		}
		if ( strstr (recvPayload, PAIR_CONFIG) != 0  )
		{
			WriteFileToDevice(PAIR_CONFIG, recvPayload);
			parseString(PAIR_CONFIG, recvPayload);
		}
	}
}

void InitPWMModules()
{
    // Initialization of timers to generate PWM output
    MAP_PRCMPeripheralClkEnable(PRCM_TIMERA2, PRCM_RUN_MODE_CLK);

    // TIMERA2 (TIMER B) as RED of RGB light. GPIO 9 --> PWM_5
    SetupTimerPWMMode(TIMERA2_BASE, TIMER_B,
            (TIMER_CFG_SPLIT_PAIR | TIMER_CFG_B_PWM), 1);
    MAP_TimerEnable(TIMERA2_BASE,TIMER_B);
}

void SetupTimerPWMMode(unsigned long ulBase, unsigned long ulTimer,
                       unsigned long ulConfig, unsigned char ucInvert)
{
    //
    // Set GPT - Configured Timer in PWM mode.
    //
    MAP_TimerConfigure(ulBase,ulConfig);
    MAP_TimerPrescaleSet(ulBase,ulTimer,0);

    //
    // Inverting the timer output if required
    //
    MAP_TimerControlLevel(ulBase,ulTimer,ucInvert);

    //
    // Load value set to ~0.5 ms time period
    //
    MAP_TimerLoadSet(ulBase,ulTimer,TIMER_INTERVAL_RELOAD);

    //
    // Match value set so as to output level 0
    //
    MAP_TimerMatchSet(ulBase,ulTimer,TIMER_INTERVAL_RELOAD);

}

void UpdateDutyCycle(unsigned long ulBase, unsigned long ulTimer,
                     unsigned char ucLevel)
{
    //
    // Match value is updated to reflect the new dutycycle settings
    //
    MAP_TimerMatchSet(ulBase,ulTimer,(ucLevel*DUTYCYCLE_GRANULARITY));
}
