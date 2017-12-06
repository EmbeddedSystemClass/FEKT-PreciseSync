/** ***************************************************************************************************
 * @file main.c
 * @author Lovas Szilard <lovas.szilard@gmail.com>
 * @date 2016.02.22
 * @version 0.1
 * @copyright Lovas Szilard
 * GNU GENERAL PUBLIC LICENSE Version 2, June 1991
 *
 * Homepage: http://loszi.hu/works/ti_launchpad_freertos_demo/
 *
 * @brief FreeRTOS Demo project for Hercules LAUNCHXL2-570LC43 launchpad devboard.
 *
 * @details
 * Packages:
 * FreeRTOS+IO
 * FreeRTOS+CLI
 * FreeRTOS+TCP
 * FreeRTOS+FAT
 */

/* Include Files */
#include "HL_sys_common.h"

/* FreeRTOS headers */
#include "FreeRTOS.h"
#include "FreeRTOS_IO.h"
#include "os_task.h"
#include "os_queue.h"
#include "os_semphr.h"

#include "math.h"
#include "stdio.h"
#include "stdlib.h"

/* HALCoGen generated headers has moved to sys_main.h*/
#include "sys_main.h"

/* Time related functions */
#include "rti_runtimestats.h"

/* CLI related headers */
#include "FreeRTOS_CLI.h"
#include "UARTCommandConsole.h"		/* FreeRTOS-Plus-UART-Console includes. */
#include "UDPCommandConsole.h"		/* FreeRTOS-Plus-UDP-Console includes. */
#include "CLI_commands.h"			/* CLI commands */

/* TCPIP related headers */
#include "FreeRTOSIPConfig.h"
#include "FreeRTOS_IP.h"
#include "FreeRTOS_IP_Private.h"
#include "NetworkBufferManagement.h"
#include "FreeRTOS_TCP_server.h"

/* FreeRTOS+FAT includes. */
#include "ff_headers.h"
#include "ff_stdio.h"
#include "ff_ramdisk.h"

uint8 emacAddress[6U] =	{0x00U, 0x08U, 0xEEU, 0x03U, 0xA6U, 0x6DU};
uint32 emacPhyAddress =	1U;
static const uint8_t ucIPAddress[4] = {configIP_ADDR0, configIP_ADDR1, configIP_ADDR2, configIP_ADDR3};
static const uint8_t ucNetMask[4] = {configNET_MASK0, configNET_MASK1, configNET_MASK2, configNET_MASK3};
static const uint8_t ucGatewayAddress[4] = {configGATEWAY_ADDR0, configGATEWAY_ADDR1, configGATEWAY_ADDR2, configGATEWAY_ADDR3};
static const uint8_t ucDNSServerAddress[4] = {configDNS_SERVER_ADDR0, configDNS_SERVER_ADDR1, configDNS_SERVER_ADDR2, configDNS_SERVER_ADDR3};

/* Task handlers */
xTaskHandle xTask1Handle, xTask2Handle, xServerWorkTaskHandle;
extern xTaskHandle xIPTaskHandle;

/* Tasks */
static void vTask1(void *pvParameters);
static void vTask2(void *pvParameters);
static void vServerWorkTask(void *pvParameters);
void vStartNTPTask( uint16_t usTaskStackSize, UBaseType_t uxTaskPriority );
static void vUDPSendUsingStandardInterface( void *pvParameters );

static void vADCtoFile( void *pvParameters );

static void vUDPSendingUsingZeroCopyInterface( void *pvParameters );
static void vUDPReceivingUsingStandardInterface( void *pvParameters );

extern hdkif_t hdkif_data[MAX_EMAC_INSTANCE];
extern void vRegisterFileSystemCLICommands( void );
extern void vCreateAndVerifyExampleFiles( const char *pcMountPath );
extern void vStdioWithCWDTest( const char *pcMountPath );
float xConvertAdcValueToNtcTemperature(uint16_t xAdcValue, uint16_t xAdcMaxValue, float xR1, float xA, float xB, float xD);

/* Hook functions */
BaseType_t xApplicationDNSQueryHook( const char *pcName );
const char *pcApplicationHostnameHook( void );
void vApplicationTickHook(void);
void vApplicationIdleHook(void);
void vApplicationStackOverflowHook(TaskHandle_t xTask, signed char *pcTaskName);

/* FTP and HTTP servers execute in the TCP server work task. */
#define mainTCP_SERVER_TASK_PRIORITY	( tskIDLE_PRIORITY + 2 )
#define	mainTCP_SERVER_STACK_SIZE		( configMINIMAL_STACK_SIZE * 12 )

/* RAM disk parameters */
#define mainRAM_DISK_SECTOR_SIZE	512UL
#define mainRAM_DISK_SECTORS		((200UL*1024UL) / mainRAM_DISK_SECTOR_SIZE)
#define mainIO_MANAGER_CACHE_SIZE	(15UL * mainRAM_DISK_SECTOR_SIZE)
/* RAM disk mount point */
#define mainRAM_DISK_NAME			"/ram"
//static uint8_t ucRAMDisk[ mainRAM_DISK_SECTORS * mainRAM_DISK_SECTOR_SIZE ] __attribute__ ((section(".sdram")));
static uint8_t ucRAMDisk[ mainRAM_DISK_SECTORS * mainRAM_DISK_SECTOR_SIZE ];

/** ***************************************************************************************************
 * @fn		void main(void)
 * @brief	main function.
 */
void main(void)
{
	/* Initialize HALCoGen driver. */
	gioInit();
	gioSetDirection(hetPORT1, 0xAA07C821);
	gioSetDirection(hetPORT2, 0x00000000);
	sciInit();
	adcInit();
	adcMidPointCalibration(adcREG1);

	_enable_IRQ();

	/* Register some commands to CLI */
#if ( configGENERATE_RUN_TIME_STATS == 1 )
	FreeRTOS_CLIRegisterCommand( &xTaskStats );
	FreeRTOS_CLIRegisterCommand( &xRunTimeStats );
#endif
	// FreeRTOS_CLIRegisterCommand( &xMemTest ); /* Tests onboard 8M external memory on TMDX570LC43HDK devboard (and also ruins the ram disk) */
	FreeRTOS_CLIRegisterCommand( &xEmacStat );
	FreeRTOS_CLIRegisterCommand( &xPing );
	FreeRTOS_CLIRegisterCommand( &xNetStat );
	FreeRTOS_CLIRegisterCommand( &xReset );

	/* Register some more filesystem related commands, like dir, cd, pwd ... */
	vRegisterFileSystemCLICommands();

	/*uint32_t val;
    MDIOPhyRegRead(EMAC_0_BASE, 1U, 28, &val);
	val=val|(1<<13);
	MDIOPhyRegWrite(EMAC_0_BASE, 1U, 28, val);*/

	xTaskCreate(vTask1, "HeartBeat", configMINIMAL_STACK_SIZE * 10, NULL, tskIDLE_PRIORITY + 3  | portPRIVILEGE_BIT, &xTask1Handle);
	FreeRTOS_IPInit(ucIPAddress, ucNetMask, ucGatewayAddress, ucDNSServerAddress, emacAddress);
	//xTaskCreate(vUDPSendUsingStandardInterface, "UDPsend", configMINIMAL_STACK_SIZE * 20, NULL, tskIDLE_PRIORITY + 3  | portPRIVILEGE_BIT, &xTask1Handle);
	xTaskCreate(vADCtoFile, "ADCread", configMINIMAL_STACK_SIZE * 20, NULL, tskIDLE_PRIORITY + 3  | portPRIVILEGE_BIT, &xTask1Handle);
    //xTaskCreate(vUDPReceivingUsingStandardInterface, "UDPreceive", configMINIMAL_STACK_SIZE * 20, NULL, tskIDLE_PRIORITY + 3  | portPRIVILEGE_BIT, &xTask1Handle);

	/* Start the command interpreter */
	vStartUARTCommandInterpreterTask();

	vTaskStartScheduler();
	while(1);
}

extern Peripheral_Descriptor_t xConsoleUART;

static void vUDPReceivingUsingStandardInterface( void *pvParameters )
{
    Socket_t xSocket;
long lBytes;
uint8_t cReceivedString[ 60 ];
struct freertos_sockaddr xClient, xBindAddress;
uint32_t xClientLength = sizeof( xClient );
Socket_t xListeningSocket;
struct freertos_sockaddr xDestinationAddress;

   /* Attempt to open the socket. */
   xListeningSocket = FreeRTOS_socket( FREERTOS_AF_INET,
                                       FREERTOS_SOCK_DGRAM,/*FREERTOS_SOCK_DGRAM for UDP.*/
                                       FREERTOS_IPPROTO_UDP );

   /* Check the socket was created. */
   configASSERT( xListeningSocket != FREERTOS_INVALID_SOCKET );

   /* Bind to port 10000. */
   xBindAddress.sin_port = FreeRTOS_htons( 10000 );
   FreeRTOS_bind( xListeningSocket, &xBindAddress, sizeof( xBindAddress ) );

   xDestinationAddress.sin_addr = FreeRTOS_inet_addr( "192.168.1.4" );
      xDestinationAddress.sin_port = FreeRTOS_htons( 10080 );

   for( ;; )
   {
       /* Receive data from the socket.  ulFlags is zero, so the standard
       interface is used.  By default the block time is portMAX_DELAY, but it
       can be changed using FreeRTOS_setsockopt(). */
       lBytes = FreeRTOS_recvfrom( xListeningSocket,
                                   cReceivedString,
                                   sizeof( cReceivedString ),
                                   0,
                                   &xClient,
                                   &xClientLength );

       if( lBytes > 0 )
       {

           xSocket = FreeRTOS_socket( FREERTOS_AF_INET,
                                                    FREERTOS_SOCK_DGRAM,/*FREERTOS_SOCK_DGRAM for UDP.*/
                                                    FREERTOS_IPPROTO_UDP );

                         configASSERT( xSocket != FREERTOS_INVALID_SOCKET );

                  FreeRTOS_sendto( xSocket,
                                   cReceivedString,
                                   strlen( cReceivedString ),
                                   0,
                                   &xDestinationAddress,
                                   sizeof( xDestinationAddress ) );

       }
   }
}

static void vADCtoFile( void *pvParameters )
{
Socket_t xSocket;
struct freertos_sockaddr xDestinationAddress;
uint8_t cString[ 10 ];
uint32_t ulCount = 0UL;
uint64_t timeStamp = 0UL;
const TickType_t x1000ms = 1000UL / portTICK_PERIOD_MS;
const TickType_t x100ms = 100UL / portTICK_PERIOD_MS;
const TickType_t x10ms = 10UL / portTICK_PERIOD_MS;
const TickType_t x1ms = 1UL / portTICK_PERIOD_MS;

   /* Send strings to port 10000 on IP address 192.168.0.50. */
   xDestinationAddress.sin_addr = FreeRTOS_inet_addr( "192.168.1.4" );
   xDestinationAddress.sin_port = FreeRTOS_htons( 10080 );

   /* Create the socket. */
   xSocket = FreeRTOS_socket( FREERTOS_AF_INET,
                              FREERTOS_SOCK_DGRAM,/*FREERTOS_SOCK_DGRAM for UDP.*/
                              FREERTOS_IPPROTO_UDP );

   /* Check the socket was created. */
   configASSERT( xSocket != FREERTOS_INVALID_SOCKET );

   /* NOTE: FreeRTOS_bind() is not called.  This will only work if
   ipconfigALLOW_SOCKET_SEND_WITHOUT_BIND is set to 1 in FreeRTOSIPConfig.h. */


   xSocket = FreeRTOS_socket( FREERTOS_AF_INET,FREERTOS_SOCK_DGRAM,FREERTOS_IPPROTO_UDP );/*FREERTOS_SOCK_DGRAM for UDP.*/

                        /* Check the socket was created. */
                        configASSERT( xSocket != FREERTOS_INVALID_SOCKET );




    adcData_t Adc1Results[2];
    uint8_t data_buffer[100];


    while(1)
    {

        adcStartConversion(adcREG1, adcGROUP1);
        while(adcIsConversionComplete(adcREG1, adcGROUP1) == 0);
        adcGetData(adcREG1, adcGROUP1, Adc1Results);

       // uint32_t pot=Get_Pot_ADC_data();
        /* OnChip temperature sensor 1 */
        //sprintf(data_buffer,"%010d\r\n",pot);
      //  sprintf(data_buffer,"%2.2f\r\n",xConvertAdcValueToNtcTemperature(Adc1Results[1].value, 4095, 1000.0, 10.59719290e-3, -23.65584544e-4, 266.0378436e-7));
        sprintf(data_buffer,"%d\r\n",Adc1Results[0].value);



    if( *ipLOCAL_IP_ADDRESS_POINTER != 0x00UL )
    {


        /* Create the string that is sent. */
              //timeStamp=Dp83640GetTimeStamp(EMAC_0_BASE,1U,2U);
        sprintf( cString,"%s",data_buffer);

        /* Send the string to the UDP socket.  ulFlags is set to 0, so the standard
        semantics are used.  That means the data from cString[] is copied
        into a network buffer inside FreeRTOS_sendto(), and cString[] can be
        reused as soon as FreeRTOS_sendto() has returned. */
        FreeRTOS_sendto( xSocket,
                        cString,
                        strlen( cString ),
                        0,
                        &xDestinationAddress,
                        sizeof( xDestinationAddress ) );

        ulCount++;
        vTaskDelay( x10ms );
    }
    else
    /* Wait until it is time to send again. */
    vTaskDelay( x1000ms );

    }
}

static void vUDPSendUsingStandardInterface( void *pvParameters )
{
Socket_t xSocket;
struct freertos_sockaddr xDestinationAddress;
uint8_t cString[ 10 ];
uint32_t ulCount = 0UL;
uint64_t timeStamp = 0UL;
const TickType_t x1000ms = 1000UL / portTICK_PERIOD_MS;
const TickType_t x100ms = 100UL / portTICK_PERIOD_MS;
const TickType_t x1ms = 1UL / portTICK_PERIOD_MS;

   /* Send strings to port 10000 on IP address 192.168.0.50. */
   xDestinationAddress.sin_addr = FreeRTOS_inet_addr( "192.168.1.71" );
   xDestinationAddress.sin_port = FreeRTOS_htons( 10080 );

   /* Create the socket. */
   xSocket = FreeRTOS_socket( FREERTOS_AF_INET,
                              FREERTOS_SOCK_DGRAM,/*FREERTOS_SOCK_DGRAM for UDP.*/
                              FREERTOS_IPPROTO_UDP );

   /* Check the socket was created. */
   configASSERT( xSocket != FREERTOS_INVALID_SOCKET );

   /* NOTE: FreeRTOS_bind() is not called.  This will only work if
   ipconfigALLOW_SOCKET_SEND_WITHOUT_BIND is set to 1 in FreeRTOSIPConfig.h. */



    while(1)
    {

    if( *ipLOCAL_IP_ADDRESS_POINTER != 0x00UL )
    {

           xSocket = FreeRTOS_socket( FREERTOS_AF_INET,
                                         FREERTOS_SOCK_DGRAM,/*FREERTOS_SOCK_DGRAM for UDP.*/
                                         FREERTOS_IPPROTO_UDP );

              /* Check the socket was created. */
              configASSERT( xSocket != FREERTOS_INVALID_SOCKET );
        /* Create the string that is sent. */
              //timeStamp=Dp83640GetTimeStamp(EMAC_0_BASE,1U,2U);
        sprintf( cString,"PACKET DATA");

        /* Send the string to the UDP socket.  ulFlags is set to 0, so the standard
        semantics are used.  That means the data from cString[] is copied
        into a network buffer inside FreeRTOS_sendto(), and cString[] can be
        reused as soon as FreeRTOS_sendto() has returned. */
        FreeRTOS_sendto( xSocket,
                        cString,
                        strlen( cString ),
                        0,
                        &xDestinationAddress,
                        sizeof( xDestinationAddress ) );

        ulCount++;
        vTaskDelay( x100ms );
    }
    else
    /* Wait until it is time to send again. */
    vTaskDelay( x1000ms );

    }
}

static void vUDPSendingUsingZeroCopyInterface( void *pvParameters )
{
Socket_t xSocket;
uint8_t *pucBuffer;
struct freertos_sockaddr xDestinationAddress;
BaseType_t lReturned;
uint32_t ulCount = 0UL;
const uint8_t *pucStringToSend = "Zero copy send message number ";
const TickType_t x1000ms = 1000UL / portTICK_PERIOD_MS;
/* 15 is added to ensure the number, \r\n and terminating zero fit. */
const size_t xStringLength = strlen( ( char * ) pucStringToSend ) + 15;

   /* Send strings to port 10000 on IP address 192.168.0.50. */
   xDestinationAddress.sin_addr = FreeRTOS_inet_addr( "192.168.1.2" );
   xDestinationAddress.sin_port = FreeRTOS_htons( 10080 );

   /* Create the socket. */
   xSocket = FreeRTOS_socket( FREERTOS_AF_INET,
                              FREERTOS_SOCK_DGRAM,/*FREERTOS_SOCK_DGRAM for UDP.*/
                              FREERTOS_IPPROTO_UDP );

   /* Check the socket was created. */
   configASSERT( xSocket != FREERTOS_INVALID_SOCKET );

   /* NOTE: FreeRTOS_bind() is not called.  This will only work if
   ipconfigALLOW_SOCKET_SEND_WITHOUT_BIND is set to 1 in FreeRTOSIPConfig.h. */

   for( ;; )
   {
       if( *ipLOCAL_IP_ADDRESS_POINTER != 0x00UL ) {
       /* This RTOS task is going to send using the zero copy interface.  The
       data being sent is therefore written directly into a buffer that is
       passed into, rather than copied into, the FreeRTOS_sendto()
       function.

       First obtain a buffer of adequate length from the TCP/IP stack into which
       the string will be written. */
       pucBuffer = FreeRTOS_GetUDPPayloadBuffer( xStringLength, portMAX_DELAY );

       /* Check a buffer was obtained. */
       configASSERT( pucBuffer );

       /* Create the string that is sent. */
       memset( pucBuffer, 0x00, xStringLength );
       sprintf( pucBuffer, "%s%lu\r\n", pucStringToSend, ulCount );
       //sprintf( pucBuffer,"0,808906");

       /* Pass the buffer into the send function.  ulFlags has the
       FREERTOS_ZERO_COPY bit set so the TCP/IP stack will take control of the
       buffer rather than copy data out of the buffer. */
       lReturned = FreeRTOS_sendto( xSocket,
                                   ( void * ) pucBuffer,
                                   strlen( ( const char * ) pucBuffer ) + 1,
                                   FREERTOS_ZERO_COPY,
                                   &xDestinationAddress,
                                   sizeof( xDestinationAddress ) );

       if( lReturned == 0 )
       {
           /* The send operation failed, so this RTOS task is still responsible
           for the buffer obtained from the TCP/IP stack.  To ensure the buffer
           is not lost it must either be used again, or, as in this case,
           returned to the TCP/IP stack using FreeRTOS_ReleaseUDPPayloadBuffer().
           pucBuffer can be safely re-used after this call. */
           FreeRTOS_ReleaseUDPPayloadBuffer( ( void * ) pucBuffer );
       }
       else
       {
           /* The send was successful so the TCP/IP stack is now managing the
           buffer pointed to by pucBuffer, and the TCP/IP stack will
           return the buffer once it has been sent.  pucBuffer can
           be safely re-used. */
       }

       ulCount++;

       vTaskDelay( x1000ms );
       }
       else
       /* Wait until it is time to send again. */
       vTaskDelay( x1000ms );
   }
}
#include "UARTCommandConsole.h"
/** ***************************************************************************************************
 * @fn		void vTask1(void *pvParameters)
 * @brief	Creates RAM disk and its contents, blink USER LED 2
 */
void vTask1(void *pvParameters)
{
	FF_Disk_t *pxDisk;

	/* Create the RAM disk. */
	pxDisk = FF_RAMDiskInit(mainRAM_DISK_NAME, ucRAMDisk, mainRAM_DISK_SECTORS, mainIO_MANAGER_CACHE_SIZE);
	configASSERT(pxDisk);

	/* Print out information on the disk. */
	FF_RAMDiskShowPartition(pxDisk);

	/* Create example files and web pages on the disk */
	vCreateAndVerifyExampleFiles(mainRAM_DISK_NAME);

	/* Creates temperature log task  */
	xTaskCreate(vTask2, "LogTask", configMINIMAL_STACK_SIZE * 10,NULL,2 | portPRIVILEGE_BIT, &xTask2Handle);

	/* After creating disk and files high priority not needed anymore. */
	vTaskPrioritySet(NULL,tskIDLE_PRIORITY);

	while(1)
	{
		/* USER LED 2 */
		gioToggleBit(gioPORTB, 6);
		vTaskDelay(pdMS_TO_TICKS(1000));
	}
}

/** ***************************************************************************************************
 * @fn		void vTask2(void *pvParameters)
 * @brief	Creates /ram/logfile.txt with onchip temperature sensor log data
 */
void vTask2(void *pvParameters)
{
	FF_FILE *pxLogFIle = NULL;
	FF_TimeStruct_t xTimeStruct;
	time_t uxCurrentSeconds;
	adcData_t Adc1Results[2];
	while(1)
	{
		pxLogFIle = ff_fopen("/ram/logfile.txt", "a+");
		uxCurrentSeconds = FreeRTOS_time(NULL);
		FreeRTOS_gmtime_r( &uxCurrentSeconds, &xTimeStruct );
		ff_fprintf(pxLogFIle,"%d/%d/%02d,%2d:%02d:%02d,",
				xTimeStruct.tm_mday,
				xTimeStruct.tm_mon + 1,
				xTimeStruct.tm_year + 1900,
				xTimeStruct.tm_hour,
				xTimeStruct.tm_min,
				xTimeStruct.tm_sec);
		adcStartConversion(adcREG1, adcGROUP1);
		while(adcIsConversionComplete(adcREG1, adcGROUP1) == 0);
		adcGetData(adcREG1, adcGROUP1, Adc1Results);
		/* OnChip temperature sensor 1 */
		ff_fprintf(pxLogFIle,"%2.2f\r\n",xConvertAdcValueToNtcTemperature(Adc1Results[1].value, 4095, 1000.0, 10.59719290e-3, -23.65584544e-4, 266.0378436e-7));
		ff_fclose(pxLogFIle);
		vTaskDelay(pdMS_TO_TICKS(60000)); /* Log period = 60 sec */
	}
}

static void vServerWorkTask(void *pvParameters)
{
TCPServer_t *pxTCPServer = NULL;
const TickType_t xInitialBlockTime = pdMS_TO_TICKS(200UL);

static const struct xSERVER_CONFIG xServerConfiguration[] =
	{
	/* Server type,		port number,	backlog, 	root dir. */
	{ eSERVER_HTTP, 	80, 			10, 		"/ram/web" },
	{ eSERVER_FTP,  	21, 			10, 		 "" }
	};

	/* Remove compiler warning about unused parameter. */
	( void ) pvParameters;

	/* Configuring RTI timer for serving system time. */
	vConfigureTimerForSysTime();
	vStartNTPTask(configMINIMAL_STACK_SIZE * 2, 4);

	/* Create the servers defined by the xServerConfiguration array above. */
	pxTCPServer = FreeRTOS_CreateTCPServer( xServerConfiguration, sizeof( xServerConfiguration ) / sizeof( xServerConfiguration[ 0 ] ) );
	configASSERT( pxTCPServer );

	while(1)
	{
		FreeRTOS_TCPServerWork(pxTCPServer, xInitialBlockTime);
	}
}


/** ***************************************************************************************************
 * @fn		const char *pcApplicationHostnameHook(void)
 * @brief	DHCP hostname register hook function.
 * @details
 * Assign the name defined with "mainDEVICE_NICK_NAME" to this network node during DHCP.
 */
BaseType_t xApplicationDNSQueryHook(const char *pcName)
{
BaseType_t xReturn;

	/* Determine if a name lookup is for this node.  Two names are given
	to this node: that returned by pcApplicationHostnameHook() and that set
	by mainDEVICE_NICK_NAME. */
	if( strcmp( pcName, pcApplicationHostnameHook() ) == 0 )
	{
		xReturn = pdPASS;
	}
	else if( strcmp( pcName, mainDEVICE_NICK_NAME ) == 0 )
	{
		xReturn = pdPASS;
	}
	else
	{
		xReturn = pdFAIL;
	}

	return xReturn;
}

/** ***************************************************************************************************
 * @fn		float xConvertAdcValueToNtcTemperature(uint16_t xAdcValue, uint16_t xAdcMaxValue, float xR1, float xA, float xB, float xD)
 * @brief	Converts raw ADC value into NTC sensor temperature using Steinhart-Hart equation.
 * @details
 * Converts raw ADC value (comes from the following circuit) into NTC sensor temperature, using Steinhart-Hart equation.
 *
 * Vref ---|
 *        |-|
 *   Rntc | |
 *        |-|
 *         |   |-------|
 *         o---|  ADC  |---->>> AdcValue
 *         |   |-------|
 *        |-|
 *    R1  | |
 *        |-|
 *  GND ---|
 *
 * @param	xAdcValue Raw ADC value
 * @param	xAdcMaxValue Maximum ADC value
 * @param	xR1 value of R1 resistor [Ohm]
 * @param	xA "A" NTC model parameter
 * @param	xB "B" NTC model parameter
 * @param	xD "D" NTC model parameter
 * @return	temperature [Celsius]
 */
float xConvertAdcValueToNtcTemperature(uint16_t xAdcValue, uint16_t xAdcMaxValue, float xR1, float xA, float xB, float xD)
{
	float xRntc, xReturn;
	const float xKelvinOffset = 272.15;
	if(xAdcMaxValue <= xAdcValue || xAdcValue == 0 || xR1 == 0.0 )
		{
		return(NAN);
		}
	xRntc = xR1 * (((float)xAdcMaxValue / (float)xAdcValue) - 1.0);
	xReturn = 1.0 / (xA + xB * logf(xRntc) + xD * powf(logf(xRntc),3)) - xKelvinOffset;
	return(xReturn);
}

void vApplicationIPNetworkEventHook( eIPCallbackEvent_t eNetworkEvent )
{
static BaseType_t xTasksAlreadyCreated = pdFALSE;

if( eNetworkEvent == eNetworkUp )
    {
        if( xTasksAlreadyCreated == pdFALSE )
        {
        	/* Start the UDP command line on port 5001 */
        	vStartUDPCommandInterpreterTask( mainUDP_CLI_TASK_STACK_SIZE, mainUDP_CLI_PORT_NUMBER, mainUDP_CLI_TASK_PRIORITY );

        	/* Start TCP server task (HTTP, FTP) */
        	xTaskCreate(vServerWorkTask, "TCPSrv", mainTCP_SERVER_STACK_SIZE, NULL, tskIDLE_PRIORITY + 3 | portPRIVILEGE_BIT, &xServerWorkTaskHandle);

        	xTasksAlreadyCreated = pdTRUE;
        }

    }
}

/** ***************************************************************************************************
 * @fn		const char *pcApplicationHostnameHook(void)
 * @brief	DHCP hostname register hook function.
 * @details
 * Assign the name defined with "mainDEVICE_NICK_NAME" to this network node during DHCP.
 */
const char *pcApplicationHostnameHook(void)
{
	return mainDEVICE_NICK_NAME;
}

/** ***************************************************************************************************
 * @fn		void vApplicationTickHook(void)
 * @brief	TICK hook function.
 */
void vApplicationTickHook(void)
{
}

/** ***************************************************************************************************
 * @fn		void vApplicationIdleHook(void)
 * @brief	IDLE hook function.
 */
void vApplicationIdleHook(void)
{
}

/** ***************************************************************************************************
 * @fn		void vApplicationMallocFailedHook(void)
 * @brief	Malloc() fail hook function.
 */
void vApplicationMallocFailedHook(void)
{
	volatile uint32_t ulMallocFailures = 0;
	ulMallocFailures++;
}

/** ***************************************************************************************************
 * @fn		void vApplicationStackOverflowHook(TaskHandle_t xTask, signed char *pcTaskName)
 * @brief	Stack overflow hook function.
 */
void vApplicationStackOverflowHook(TaskHandle_t xTask, signed char *pcTaskName)
{
	( void ) pcTaskName;
	configASSERT(0);
}

#if(ipconfigSUPPORT_OUTGOING_PINGS == 1)
/** ***************************************************************************************************
 * @fn		void vApplicationPingReplyHook(ePingReplyStatus_t eStatus, uint16_t usIdentifier)
 * @brief	Ping reply hook function.
 */
void vApplicationPingReplyHook(ePingReplyStatus_t eStatus, uint16_t usIdentifier)
{
static const char *pcSuccess = "Ping reply received - identifier %d\r\n";
static const char *pcInvalidChecksum = "Ping reply received with invalid checksum - identifier %d\r\n";
static const char *pcInvalidData = "Ping reply received with invalid data - identifier %d\r\n";

	switch(eStatus)
	{
		case eSuccess	:
			FreeRTOS_printf((pcSuccess, (int)usIdentifier));
			break;
		case eInvalidChecksum :
			FreeRTOS_printf((pcInvalidChecksum, (int)usIdentifier));
			break;
		case eInvalidData :
			FreeRTOS_printf((pcInvalidData, (int)usIdentifier));
			break;
		default :
			/* It is not possible to get here as all enums have their own case. */
			break;
	}
	/* Prevent compiler warnings in case FreeRTOS_debug_printf() is not defined. */
	(void) usIdentifier;
}
#endif
