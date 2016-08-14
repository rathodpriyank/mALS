/*
 * simpleLinkExtra.c
 *
 *  Created on: Jul 30, 2015
 *      Author: Priyank
 */

#include "simpleLinkExtra.h"
#include <stdio.h>

//*****************************************************************************
// Globals used by mDNS
//*****************************************************************************
static char mdnsServiceName[40] = "";
static char mdnsText[70] = "";

//*****************************************************************************
// Date and Time Global
//*****************************************************************************
SlDateTime_t dateTime;

//*****************************************************************************
//! getMacAddress
//!
//! Returns the MAC Address as string
//!
//****************************************************************************
char *getMacAddress()
{
	int i;
	unsigned char macAddressVal[SL_MAC_ADDR_LEN];
	unsigned char macAddressLen = SL_MAC_ADDR_LEN;
	char macAddressPart[2];
	static char macAddressFull[18]; //18
	sl_NetCfgGet(SL_MAC_ADDRESS_GET,NULL,&macAddressLen,(unsigned char *)macAddressVal);
	for (i = 0 ; i < 6 ; i++)
	{
		sprintf(macAddressPart, "%02X", macAddressVal[i]);
		strcat(macAddressFull, (char *)macAddressPart);
	}
	macAddressFull[12] = '\0'; // Replace the the last : with a zero termination
	return macAddressFull;
}

//*****************************************************************************
//! getApDomainName
//!
//! Returns the Access Point Domain Name as a string
//!
//****************************************************************************
char * getApDomainName()
{
	static char strDomainName[35];
	sl_NetAppGet (SL_NET_APP_DEVICE_CONFIG_ID, NETAPP_SET_GET_DEV_CONF_OPT_DOMAIN_NAME, (unsigned char *)strlen(strDomainName), (unsigned char *)strDomainName);
	return strDomainName;
}

//*****************************************************************************
//! setApDomainName
//!
//! Sets the name of the Access Point's Domain Name
//!
//! Returns: On success, zero is returned. On error, -1 is returned
//!
//****************************************************************************
int setApDomainName()
{
	int iretVal;
	unsigned char strDomain[32] = DEVICE_AP_DOMAIN_NAME;
	unsigned char lenDomain = strlen((const char *)strDomain);
	iretVal = sl_NetAppSet(SL_NET_APP_DEVICE_CONFIG_ID, NETAPP_SET_GET_DEV_CONF_OPT_DOMAIN_NAME, lenDomain, (unsigned char*)strDomain);
	return iretVal;
}

//*****************************************************************************
//! getDeviceName
//!
//! Returns the Device Name as a string
//!
//****************************************************************************
char * getDeviceName()
{
	static char strDeviceName[35];
	sl_NetAppGet (SL_NET_APP_DEVICE_CONFIG_ID, NETAPP_SET_GET_DEV_CONF_OPT_DEVICE_URN, (unsigned char *)strlen(strDeviceName), (unsigned char *)strDeviceName);
	return strDeviceName;
}

//*****************************************************************************
//! setDeviceName
//!
//! Sets the name of the Device
//!
//! Returns: On success, zero is returned. On error, -1 is returned
//!
//****************************************************************************
int setDeviceName()
{
	int iretVal;
	unsigned char strDeviceName[32] = DEVICE_NAME;
	iretVal = sl_NetAppSet (SL_NET_APP_DEVICE_CONFIG_ID, NETAPP_SET_GET_DEV_CONF_OPT_DEVICE_URN, strlen((const char *)strDeviceName), (unsigned char *) strDeviceName);
	return iretVal;
}

//*****************************************************************************
//! registerMdnsService
//!
//! Registers the mDNS Service.
//!
//! Service settings for type and port are set in simplelinklibrary.h
//!
//! Returns: On success returns 0
//!
//****************************************************************************
int registerMdnsService()
{
	int iretVal;
	unsigned int i;

	// Create mDNS Service Name
	for (i = 0; i < 40; i++)
		mdnsServiceName[i] = 0x00;

	// Obtain the device name
	char * deviceName = getDeviceName();

	strcat(mdnsServiceName, (const char *)deviceName);
	strcat(mdnsServiceName, MDNS_SERVICE);

	// Create mDNS Text
	for (i = 0; i < 50; i++)
		mdnsText[i] = 0x00;

	// Obtain the MAC Address
	char * macAddress = getMacAddress();

	strcat(mdnsText, "mac=");
	strcat(mdnsText, macAddress);
	strcat(mdnsText, ";ver=");
	strcat(mdnsText, DEVICE_VERSION);
	strcat(mdnsText, ";man=");
	strcat(mdnsText, DEVICE_MANUFACTURE);
	strcat(mdnsText, ";mod=");
	strcat(mdnsText, DEVICE_MODEL);
	strcat(mdnsText, "\0");

	int strSvrLength = strlen(mdnsServiceName);
	int strTxtLength = strlen(mdnsText);

	//Unregisters the mDNS service.
	unregisterMdnsService();

	//Registering for the mDNS service.
	iretVal = sl_NetAppMDNSRegisterService((const signed char *)mdnsServiceName,strlen(mdnsServiceName),
			(const signed char *)mdnsText,strlen(mdnsText)+1, UDPPORT, TTL, UNIQUE_SERVICE);

	return iretVal;
}

//*****************************************************************************
//! unregisterMdnsService
//!
//! Unregisters the mDNS Service.
//!
//! Returns: On success returns 0
//!
//****************************************************************************
int unregisterMdnsService()
{
	int iretVal;
	iretVal = sl_NetAppMDNSUnRegisterService((const signed char *)mdnsServiceName,strlen(mdnsServiceName));
	return iretVal;
}
