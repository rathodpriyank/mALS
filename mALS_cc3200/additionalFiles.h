/*
 * additionalFiles.h
 *
 *  Created on: Jul 30, 2015
 *      Author: Priyank
 */

#ifndef MALS_CC3200_ADDITIONALFILES_H_
#define MALS_CC3200_ADDITIONALFILES_H_
#include "stdio.h"
#include "stdbool.h"

/* Global Defines */
#define BUF_SIZE                256
#define SH_GPIO_3               3
#define	LOCL_CONFIG				"locl_config.ini"		/* locl_config.ini 6000 7 7 */
#define WIFI_CONFIG          	"wifi_config.ini"		/* wifi_config.ini Pr!y@nk Mon$ter1nc1 */
#define NOTF_CONFIG				"noti_config.ini"		/* noti_config.ini WATER FOOD ALARM-ON RESTROOM TV */
#define PAIR_CONFIG				"pair_config.ini"		/* pair_config.ini SENSOR_BOARD_MAC BUZZER_BOARD_MAC */

/* Defines */
/*Operate Lib in MQTT 3.1 mode.*/
#define MQTT_3_1                true 		/* MQTT 3.1 */
#define MY_SSID					"TestAP"
#define	MY_SECURITY_KEY			"Mon$ter1nc1"
#define SERVER_NAME				"cc3200server.net"
#define CLIENT_NAME				"cc3200client.net"
#define REMOTE_SERVER_ADDRESS	"test.mosquitto.org"
#define PORT_NUMBER             1883
#define LOOPBACK_PORT           1882
#define RCV_TIMEOUT             30
#define TASK_PRIORITY           3
#define KEEP_ALIVE_TIMER        25
#define QOS0                    0
#define QOS1                    1
#define QOS2                    2
#define CLEAN_SESSION           true
#define DEFAULT_TIMEOUT 		6000
#define SL_MAX_FILE_SIZE       	1L*1024L       /* 1KB file */
#define BUF_SIZE                256
#define SENSOR_FAIL_COUNT		50
#define DATA_ITEMS				5
#define TIMER_INTERVAL_RELOAD   40035 /* =(255*157) */
#define DUTYCYCLE_GRANULARITY   157
#define SH_GPIO_3				3
#define	SENSOR_MODE				100
#define	BUZZER_MODE				200
#define TOPICS					3
#define TOPICS_LENGTH			18

extern unsigned char *data[DATA_ITEMS];
extern char *pub_topics[];
extern char  *sub_topics[];
extern char *device_topics[];
extern bool g_stopPublishing;
extern char *g_RemoteServer;
extern int g_PortServer;
extern int g_defaultTimeout;
extern int g_ThresholdRange;
extern int g_AccThreshold;
extern char  *g_pairedMac;
extern int g_deviceMode;

/* Functions */
long WriteFileToDevice(const char *fName, const char *pData);
long ReadFileFromDevice(const _u8 *fName, _u8 *pData);
void pushButtonInterruptHandler2();
void pushButtonInterruptHandler3();
long ReadConfigAndConnectToNetwork();
void ReadConfiguration();
void parseAndProcess( const char *recvTopic, const char *recvPayload);
void InitPWMModules();
void SetupTimerPWMMode(unsigned long ulBase, unsigned long ulTimer,
                       unsigned long ulConfig, unsigned char ucInvert);
void UpdateDutyCycle(unsigned long ulBase, unsigned long ulTimer,
                     unsigned char ucLevel);

#endif /* MALS_CC3200_ADDITIONALFILES_H_ */
