/*
 * simpleLinkExtra.h
 *
 *  Created on: Jul 30, 2015
 *      Author: Priyank
 */

#ifndef MALS_CC3200_SIMPLELINKEXTRA_H_
#define MALS_CC3200_SIMPLELINKEXTRA_H_

#include "simplelink.h"

 //*****************************************************************************
 // Device Defines
 //*****************************************************************************
#define DEVICE_VERSION			"1.0.0"
#define DEVICE_MANUFACTURE		"ALS_SOFTWARE"
#define DEVICE_NAME 			"CC3200BASE"
#define DEVICE_MODEL			"CC3200"
#define DEVICE_AP_DOMAIN_NAME	"cc3200server.net"
#define DEVICE_SSID_AP_NAME		"CC3200SERVERAP"
#define USER_CONFIG_FILE		"config.ini"

 //*****************************************************************************
 // mDNS Defines
 //*****************************************************************************
#define MDNS_SERVICE  "._control._udp.local"
#define TTL             120
#define UNIQUE_SERVICE  1       /* Set 1 for unique services, 0 otherwise */

 //*****************************************************************************
 // SimpleLink/WiFi Defines
 //*****************************************************************************
#define UDPPORT         4000 /* Port number to which the connection is bound */
#define UDPPACKETSIZE   1024
#define SPI_BIT_RATE    14000000
#define TIMEOUT 		5

 //*****************************************************************************
 // Function Declarations
 //*****************************************************************************
char *getMacAddress();
char *getDeviceName();
char *getApDomainName();
int setDeviceName();
int setApDomainName();
int registerMdnsService();
int unregisterMdnsService();

#endif /* MALS_CC3200_SIMPLELINKEXTRA_H_ */
