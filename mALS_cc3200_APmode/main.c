//*****************************************************************************
//
//! \addtogroup mALS Application
//! @{
//
//*****************************************************************************

// Standard includes
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// simplelink includes
#include "simplelink.h" 
#include "additionalFiles.h"
#include "simpleLinkExtra.h"

// driverlib includes
#include "hw_types.h"
#include "hw_ints.h"
#include "hw_memmap.h"
#include "interrupt.h"
#include "rom_map.h"
#include "gpio.h"
#include "prcm.h"
#include "uart.h"
#include "utils.h"
#include "gpio_if.h"
#include "uart_if.h"
#include "i2c_if.h"
#include "button_if.h"

#include "common.h"
#include "timer.h"
#include "timer_if.h"
#include "fs.h"

// MQTT Library includes
#include "sl_mqtt_client.h"
#include "sl_mqtt_server.h"

// Application specific includes
#include "pinmux.h"
#include "server_client_cbs.h"

// Library for acceleration
#include "ADXL345.h"

/* Global Variables */
bool g_readAccFlag = 1;
bool g_timerFlag = 0;
bool g_StartReadingProcess = false;
int g_ThresholdRange 	= 7;
int g_AccThreshold 	= 7;
unsigned char qos[3]= { QOS0, QOS1, QOS2 };
unsigned char *data[DATA_ITEMS] = {"WATER", "FOOD", "ALARM-ON", "RESTROOM", "TV" };	/* WATER FOOD ALARM-ON RESTROOM TV */
char *pub_topics[TOPICS];
char *sub_topics[TOPICS];
char *topics[] = { "noti", "conf", "getc" };
int g_alarmStatus = 2;
bool g_stopPublishing = true;
int g_TimeOut = DEFAULT_TIMEOUT;
int g_topicStatus = 0;
long g_lFileHandle = -1;
static volatile unsigned long g_ulTimerInts = 0;
unsigned long g_ulToken = 0;
unsigned short g_usTimerInts;

//*****************************************************************************
//                      LOCAL FUNCTION PROTOTYPES
//*****************************************************************************
void BoardInit(void);
void MqttClientServer(void *pvParameters);
void ReadSensorData(void *pvParameters);
void InitPWMModules();

//*****************************************************************************
//                 GLOBAL VARIABLES -- Start
//*****************************************************************************
extern void (* const g_pfnVectors[])(void);

struct BridgeHandle {
    /* Handle to the client context */
    void *ClientCtxHndl;
}BridgeHndl;

/*Message Queue*/
OsiMsgQ_t g_PBQueue;

extern SlMqttServerCbs_t server_callbacks;
extern SlMqttClientCbs_t client_callbacks;

/*Initialization structure to be used with sl_ExtMqtt_Init API*/
SlMqttClientCtxCfg_t Mqtt_ClientCtx ={
{
    SL_MQTT_NETCONN_URL,
	REMOTE_SERVER_ADDRESS,
	PORT_NUMBER,
    0,
    0,
    0,
    NULL
    },
    MQTT_3_1,
    true
};

SlMqttClientLibCfg_t Mqtt_ClientCfg ={
    0,
    TASK_PRIORITY,
    RCV_TIMEOUT,
    true,
    (long(*)(const char *, ...))UART_PRINT
};

SlMqttServerCfg_t Mqtt_Server={
    {
        0,
        NULL,
		PORT_NUMBER,
        0,
        0,
        0,
        NULL
    },
    LOOPBACK_PORT,
    TASK_PRIORITY,
    RCV_TIMEOUT,
    true,
    (long(*)(const char *, ...))UART_PRINT
};

//*****************************************************************************
//                 GLOBAL VARIABLES -- End
//*****************************************************************************
//*****************************************************************************
//
//! Board Initialization & Configuration
//!
//! \param  None
//!
//! \return None
//
//*****************************************************************************
void BoardInit(void)
{
    /* In case of TI-RTOS vector table is initialize by OS itself */
    #ifndef USE_TIRTOS
    //
    // Set vector table base
    //
    IntVTableBaseSet((unsigned long)&g_pfnVectors[0]);
	#endif
    //
    // Enable Processor
    //
    MAP_IntMasterEnable();
    MAP_IntEnable(FAULT_SYSTICK);

    PRCMCC3200MCUInit();
}

void
TimerBaseIntHandler(void)
{
    // Clear the timer interrupt.
    Timer_IF_InterruptClear(TIMERA0_BASE);
    g_ulTimerInts ++;

    // For testing purposes.
    UART_PRINT("In TimerBaseIntHandler\n\r");
    UART_PRINT("topicStatus: %d\n\r" , g_topicStatus);

    // Writes to queue
	struct msg_queue queue_element;
	queue_element.event = ACCELERATION;
	queue_element.topic = g_topicStatus;
	osi_MsgQWrite(&g_PBQueue,&queue_element,OSI_NO_WAIT);

	// Resets all variables and timers being used.
	// Prevents infinite loop of timer.
	g_topicStatus = 0;
	g_timerFlag = 0;
	g_readAccFlag = 1;
	Timer_IF_Stop(TIMERA0_BASE, TIMER_A);
}

void
MqttClientServer(void *pvParameters)
{
    struct msg_queue que_elem_recv;
    struct publish_msg_header msg_head;
    unsigned int uiTopOffset = 0;
    long lRetVal = -1;
    unsigned int uiPayloadOffset = 0;
    int iCount = 0;
    unsigned int uiConnFlag = 0;
    int alarmCount = 1;
	unsigned char *tempData;
	bool bypass = false;

    // Connection for the WiFi Network
    lRetVal = ReadConfigAndConnectToNetwork();

    if ( lRetVal == SUCCESS )
    {
    	UART_PRINT("Starting the reading for acceleration \r\n");
    	g_StartReadingProcess = true;
    }

	// Register Push Button Handlers
	Button_IF_Init(pushButtonInterruptHandler2, pushButtonInterruptHandler3);

	/******************************************************************************/
	/*    Initialiszing server and registreing callbacks                          */
	/******************************************************************************/
	sl_ExtLib_MqttServerInit( &Mqtt_Server,&server_callbacks);

	/******************************************************************************/
	/* Initialising Client and Subscribing to the Broker                          */
	/******************************************************************************/

	//
	// Initialze MQTT client lib
	//
	lRetVal = sl_ExtLib_MqttClientInit(&Mqtt_ClientCfg);
	if(lRetVal != 0)
	{
		// lib initialization failed
		UART_PRINT("MQTT Client lib initialization failed\n\r");
		LOOP_FOREVER();
	}

	//
	// Create MQTT client context
	//
	BridgeHndl.ClientCtxHndl = sl_ExtLib_MqttClientCtxCreate(&Mqtt_ClientCtx,
									&client_callbacks,
									&BridgeHndl);
	//
	// Set Client ID
	//
	sl_ExtLib_MqttClientSet(BridgeHndl.ClientCtxHndl, SL_MQTT_PARAM_CLIENT_ID,
						getMacAddress() ,strlen(getMacAddress()));

	for ( iCount = 0; iCount < TOPICS; iCount++ )
	{
		sub_topics[iCount] = malloc(TOPICS_LENGTH);
		pub_topics[iCount] = malloc(TOPICS_LENGTH);
		snprintf(pub_topics[iCount], TOPICS_LENGTH, "%s/%s", getMacAddress(), topics[iCount]);
		if ( strstr (topics[iCount], "noti") != 0 )
			snprintf(sub_topics[iCount], TOPICS_LENGTH, "%s/%s", g_pairedMac, topics[iCount]);
		 else
			snprintf(sub_topics[iCount], TOPICS_LENGTH, "%s/%s", getMacAddress(), topics[iCount]);
	}

	for ( iCount = 0; iCount < TOPICS; iCount++ )
		UART_PRINT("[%d] sub_topics : %s | pub_topics : %s \r\n",iCount, sub_topics[iCount], pub_topics[iCount]);

	if( sl_ExtLib_MqttClientSub(BridgeHndl.ClientCtxHndl, sub_topics, qos,
			sizeof(sub_topics)/sizeof(sub_topics[iCount]) ) < 0 )
	{
		sl_ExtLib_MqttClientDisconnect(BridgeHndl.ClientCtxHndl);
		uiConnFlag = 0;
	}

	//
	// on-board client is enrolling to server. Server will treated this
	// enrollment as a subscription.
	//
	sl_ExtLib_MqttTopicEnroll((const char*)sub_topics);
	//
	// handling the signals from various callbacks including the push button
	// prompting the client to publish a msg on PUB_TOPIC OR msg recieved by the
	// server on enrolled topic(for which the on-board clinet ha enrolled) from
	// a local client(will be published to the remote broker by the client) OR
	// msg received by the client from the remote broker(need to be sent to the
	// server to see if any local client has subscribed on the same topic).
	//

	// before starting the listning just send one message for disabling alarm if device went wrong somehow.
	sl_ExtLib_MqttClientSend(BridgeHndl.ClientCtxHndl,
												(const char *)pub_topics[0],"OFF",
												 strlen("OFF"), qos[0], 0 );
	UART_PRINT("Resetting board | Topic: %s | Data: OFF \n\r", pub_topics[0] );
	for(;;)
	{
		//
		// waiting for signals
		//
		osi_MsgQRead( &g_PBQueue, &que_elem_recv, OSI_WAIT_FOREVER);
		switch(que_elem_recv.event)
		{
		case RESET_PUSH_BUTTON_PRESSED:
			{
				if ( g_stopPublishing == false )
				{
					lRetVal =
							sl_ExtLib_MqttServerSend((const char *)pub_topics[0],"OFF",
											 strlen("OFF"), qos[0], 0, 0 );
					UART_PRINT("Reset | Topic: %s | Data: OFF \n\r", pub_topics[0] );
					alarmCount = 0;
					g_stopPublishing = true;
				}
			}
			Button_IF_EnableInterrupt(SW3);
			break;
		case PUB_PUSH_BUTTON_PRESSED:
			if ( g_stopPublishing == true )
			{
				if ( alarmCount == g_alarmStatus )
				{
					lRetVal =
							sl_ExtLib_MqttServerSend((char *)pub_topics[0], "ALARM-ON",
											  strlen("ALARM-ON"), qos[0], 0, 0);
					UART_PRINT("[Push | Topic: %s | Data: ALARM-ON \n\r",pub_topics[0] );
					g_stopPublishing = false;
				}
				else
				{
					UART_PRINT("Alarm Count Status : %d \n\r", alarmCount);
					alarmCount++;
				}
			}
			Button_IF_EnableInterrupt(SW2);
			break;
		case MSG_RECV_BY_SERVER:
			if(uiConnFlag == 0)
			{
				free(que_elem_recv.msg_ptr);
				break;
			}

			memcpy(&msg_head, que_elem_recv.msg_ptr, sizeof(msg_head));
			uiTopOffset = sizeof(msg_head);
			uiPayloadOffset = uiTopOffset + msg_head.topic_len + 1;
			lRetVal =
					sl_ExtLib_MqttServerSend(((const char *)(que_elem_recv.msg_ptr)+uiTopOffset),
					  ((unsigned char*)(que_elem_recv.msg_ptr)+uiPayloadOffset),
					  msg_head.pay_len, qos[0], 0, 0);
			UART_PRINT("Payload : %s \n\r", (unsigned char*)(que_elem_recv.msg_ptr)+uiPayloadOffset);
			free(que_elem_recv.msg_ptr);
			break;
		case MSG_RECV_BY_CLIENT:
			memcpy(&msg_head, que_elem_recv.msg_ptr, sizeof(msg_head));
			uiTopOffset = sizeof(msg_head);
			uiPayloadOffset = uiTopOffset + msg_head.topic_len + 1;
			lRetVal =
			sl_ExtLib_MqttServerSend(((const char*)(que_elem_recv.msg_ptr)+ uiTopOffset),
					  ((unsigned char*)(que_elem_recv.msg_ptr)+uiPayloadOffset),
					  msg_head.pay_len, qos[0], false, 0 );
			parseAndProcess( (const char*) que_elem_recv.msg_ptr + uiTopOffset, \
					(const char*) que_elem_recv.msg_ptr + uiPayloadOffset);
			UART_PRINT("Payload : %s \n\r", (const char*) que_elem_recv.msg_ptr + uiTopOffset);
			free(que_elem_recv.msg_ptr);
			break;
		case ACCELERATION :
			{
				switch(que_elem_recv.topic)
				{
					case NOTIF1:
							bypass = false;
							tempData=data[0];
							break;
					case NOTIF2:
							bypass = false;
							tempData = data[1];
							break;
					case NOTIF3:
							bypass = false;
							tempData = data[2];
							break;
					case NOTIF4:
							bypass = false;
							tempData = data[3];
							break;
					case NOTIF5:
							bypass = false;
							tempData = data[4];
							break;
					default:
						bypass = true;
						break;
				}
				if ( bypass )
					break;
				lRetVal = sl_ExtLib_MqttServerSend((const char *)pub_topics[0], tempData,
											  strlen((char*)tempData), qos[0], 0, 0 );
				UART_PRINT("[Acc | Topic: %s | Data: %s \n\r",pub_topics[0], tempData );
			}
			break;
		default:
			break;
		}
		if(lRetVal < 0)
		{
			break;
		}
	}

	// unsubscribing the topics
	sl_ExtLib_MqttClientUnsub(BridgeHndl.ClientCtxHndl, sub_topics, sizeof(sub_topics)/sizeof(sub_topics[0]));
	UART_PRINT("Client Unsubscribed from the topics");
	for(iCount = 0; iCount < sizeof(sub_topics)/sizeof(sub_topics[iCount]); iCount++)
	{
		UART_PRINT(",%s",sub_topics[iCount]);
	}

	// disconnecting from the remote broker
	sl_ExtLib_MqttClientDisconnect(BridgeHndl.ClientCtxHndl);
	UART_PRINT("\n\r Disconnected from the broker\n\r");

	// deleting the context for the connection
	sl_ExtLib_MqttClientCtxDelete(BridgeHndl.ClientCtxHndl);

	// exiting the Client library
	sl_ExtLib_MqttClientExit();
	LOOP_FOREVER();
}

void ReadSensorData(void *pvParameters)
{
    unsigned short cAccXT1,cAccYT1,cAccZT1;
    unsigned short cAccXT2,cAccYT2,cAccZT2;
    unsigned short sDelAccX, sDelAccY, sDelAccZ;
    int iRet = -1;
    int iCount = 0;
    bool StartRead = false;

	while(1)
	{
		if ( g_StartReadingProcess )
		{
			if ( iCount == 100 )
				osi_Sleep(10000000);

			if ( StartRead == false )
				{
					if ( ADXL345init() == 0 )
					{
						UART_PRINT("Starting the read \r\n");
						StartRead = true;
						g_deviceMode = SENSOR_MODE;
					}
					else
					{
						g_deviceMode = BUZZER_MODE;
						iCount++;
					}
				}
			else
			{
				for(iCount=0; iCount<2; iCount++)
				{
					if ( iCount == 1 )
						iRet = ADXL345ReadAcc(&cAccXT1, &cAccYT1, &cAccZT1);
					else
						iRet = ADXL345ReadAcc(&cAccXT2, &cAccYT2, &cAccZT2);
					osi_Sleep(50); // 20 msec
				}

				if( SUCCESS == iRet )
				{
					sDelAccX = abs((signed short)cAccXT2 - (signed short)cAccXT1);
					sDelAccY = abs((signed short)cAccYT2 - (signed short)cAccYT1);
					sDelAccZ = abs((signed short)cAccZT2 - (signed short)cAccZT1);

					//Compare with Pre defined Threshold
					if(g_readAccFlag)
					{
						if(sDelAccX > g_AccThreshold || sDelAccY > g_AccThreshold ||
						   sDelAccZ > g_AccThreshold)
						{
							if(sDelAccX < (g_ThresholdRange * g_AccThreshold ) || sDelAccY < (g_ThresholdRange * g_AccThreshold ) ||
											   sDelAccZ < (g_ThresholdRange * g_AccThreshold ) )
							{
								if(!g_timerFlag)
								{
									Timer_IF_Start(TIMERA0_BASE, TIMER_A, g_TimeOut);
									g_timerFlag = 1;
								}
								g_readAccFlag = 0;
								g_topicStatus++;
								//Device Movement Detected, Break and Return
								UART_PRINT("Movement detected [X:%d | Y:%d | Z:%d] \r\n ", sDelAccX, sDelAccY, sDelAccZ);
							}
						}
					}
					if(sDelAccX < g_AccThreshold && sDelAccY < g_AccThreshold &&
					   sDelAccZ < g_AccThreshold)
					{
						g_readAccFlag = 1;
					}
				}
				else
					UART_PRINT("Read failed \r\n");
			} // else ending
		} // if for g_StartReadingProcess ending
	} // while loop end
}

//*****************************************************************************
//
//! Main 
//!
//! \param  none
//!
//! This function
//!    1. Invokes the SLHost task
//!    2. Invokes the MqttServer
//!
//! \return None
//!
//*****************************************************************************
void
main()
{
    // Initialize the board configurations
    BoardInit();

    // Pinmux for UART
    PinMuxConfig();

    // Configuring UART
    InitTerm();

    // Start the SimpleLink Host
    if(VStartSimpleLinkSpawnTask(SPAWN_TASK_PRIORITY) < 0)
    {
        ERR_PRINT(VStartSimpleLinkSpawnTask(SPAWN_TASK_PRIORITY));
    }

    // Init i2c
    if(I2C_IF_Open(I2C_MASTER_MODE_FST) < 0)
    {
        ERR_PRINT(I2C_IF_Open(I2C_MASTER_MODE_FST));
    }

    // Configure timer A and interrupt for that
    Timer_IF_Init(PRCM_TIMERA0, TIMERA0_BASE, TIMER_CFG_PERIODIC, TIMER_A, 0);
    Timer_IF_IntSetup(TIMERA0_BASE, TIMER_A, TimerBaseIntHandler);

    // Start the MQTT Server and Client task depending upon the jumper settings
	osi_MsgQCreate(&g_PBQueue, "PBQueue", sizeof(struct msg_queue),10);

	if(osi_TaskCreate(MqttClientServer, (const signed char *)"Mqtt Server", 2048, NULL, 2, NULL ) < 0)
	{
		UART_PRINT("Failed to start the Mqtt Server");
	}

	if(osi_TaskCreate(ReadSensorData, (const signed char *)"Read the Acc data", 2048, NULL, 2, NULL ) < 0)
	{
		UART_PRINT("Failed to Read the Acc data");
	}

	// Start the task scheduler
    osi_start();
}
