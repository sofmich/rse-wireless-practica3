/*
 * accel.c
 *
 *  Created on: 1 dic. 2020
 *      Author: andys
 */
#include "accel.h"
#include "pin_mux.h"
#include "fsl_port.h"
#include "fsl_fxos.h"
#include "fsl_gpio.h"
#include "pin_mux.h"
#include <stdio.h>

/* I2C source clock */
#define ACCEL_I2C_CLK_SRC I2C1_CLK_SRC
#define I2C_BAUDRATE 100000U

#define I2C_RELEASE_SDA_PORT PORTC
#define I2C_RELEASE_SCL_PORT PORTC
#define I2C_RELEASE_SDA_GPIO GPIOC
#define I2C_RELEASE_SDA_PIN 3U
#define I2C_RELEASE_SCL_GPIO GPIOC
#define I2C_RELEASE_SCL_PIN 2U
#define I2C_RELEASE_BUS_COUNT 100U

#define PIN0_IDX                         0u   /*!< Pin number for pin 0 in a port */
#define PIN1_IDX                         1u   /*!< Pin number for pin 1 in a port */
#define PIN2_IDX                         2u   /*!< Pin number for pin 2 in a port */
#define PIN3_IDX                         3u   /*!< Pin number for pin 3 in a port */

#define BOARD_ACCEL_I2C_BASEADDR I2C1

static fxos_handle_t fxosHandle;
static fxos_data_t sensorData;

const uint8_t g_accel_address[] = {0x1CU, 0x1DU, 0x1EU, 0x1FU};
const uint8_t from_IPV6[] = " from IPv6 address: ";
static i2c_master_handle_t g_MasterHandle;
static void i2c_release_bus_delay(void)
{
    uint32_t i = 0;
    for (i = 0; i < I2C_RELEASE_BUS_COUNT; i++)
    {
        __NOP();
    }
}

void BOARD_I2C_ReleaseBus(void)
{
    uint8_t i = 0;
    gpio_pin_config_t pin_config;
    port_pin_config_t i2c_pin_config = {0};

    /* Config pin mux as gpio */
    i2c_pin_config.pullSelect = kPORT_PullUp;
    i2c_pin_config.mux = kPORT_MuxAsGpio;

    pin_config.pinDirection = kGPIO_DigitalOutput;
    pin_config.outputLogic = 1U;
    CLOCK_EnableClock(kCLOCK_PortC);
    PORT_SetPinConfig(I2C_RELEASE_SCL_PORT, I2C_RELEASE_SCL_PIN, &i2c_pin_config);
    PORT_SetPinConfig(I2C_RELEASE_SDA_PORT, I2C_RELEASE_SDA_PIN, &i2c_pin_config);

    GPIO_PinInit(I2C_RELEASE_SCL_GPIO, I2C_RELEASE_SCL_PIN, &pin_config);
    GPIO_PinInit(I2C_RELEASE_SDA_GPIO, I2C_RELEASE_SDA_PIN, &pin_config);

    /* Drive SDA low first to simulate a start */
    GPIO_WritePinOutput(I2C_RELEASE_SDA_GPIO, I2C_RELEASE_SDA_PIN, 0U);
    i2c_release_bus_delay();

    /* Send 9 pulses on SCL and keep SDA high */
    for (i = 0; i < 9; i++)
    {
        GPIO_WritePinOutput(I2C_RELEASE_SCL_GPIO, I2C_RELEASE_SCL_PIN, 0U);
        i2c_release_bus_delay();

        GPIO_WritePinOutput(I2C_RELEASE_SDA_GPIO, I2C_RELEASE_SDA_PIN, 1U);
        i2c_release_bus_delay();

        GPIO_WritePinOutput(I2C_RELEASE_SCL_GPIO, I2C_RELEASE_SCL_PIN, 1U);
        i2c_release_bus_delay();
        i2c_release_bus_delay();
    }

    /* Send stop */
    GPIO_WritePinOutput(I2C_RELEASE_SCL_GPIO, I2C_RELEASE_SCL_PIN, 0U);
    i2c_release_bus_delay();

    GPIO_WritePinOutput(I2C_RELEASE_SDA_GPIO, I2C_RELEASE_SDA_PIN, 0U);
    i2c_release_bus_delay();

    GPIO_WritePinOutput(I2C_RELEASE_SCL_GPIO, I2C_RELEASE_SCL_PIN, 1U);
    i2c_release_bus_delay();

    GPIO_WritePinOutput(I2C_RELEASE_SDA_GPIO, I2C_RELEASE_SDA_PIN, 1U);
    i2c_release_bus_delay();
}
void BOARD_I2C_ConfigurePins(void) {
  CLOCK_EnableClock(kCLOCK_PortC);                           /* Port C Clock Gate Control: Clock enabled */

  const port_pin_config_t portc2_pin38_config = {
    kPORT_PullUp,                                            /* Internal pull-up resistor is enabled */
    kPORT_FastSlewRate,                                      /* Fast slew rate is configured */
    kPORT_PassiveFilterDisable,                              /* Passive filter is disabled */
    kPORT_LowDriveStrength,                                  /* Low drive strength is configured */
    kPORT_MuxAlt3,                                           /* Pin is configured as I2C1_SCL */
  };
  PORT_SetPinConfig(PORTC, PIN2_IDX, &portc2_pin38_config);  /* PORTC2 (pin 38) is configured as I2C1_SCL */
  const port_pin_config_t portc3_pin39_config = {
    kPORT_PullUp,                                            /* Internal pull-up resistor is enabled */
    kPORT_FastSlewRate,                                      /* Fast slew rate is configured */
    kPORT_PassiveFilterDisable,                              /* Passive filter is disabled */
    kPORT_LowDriveStrength,                                  /* Low drive strength is configured */
    kPORT_MuxAlt3,                                           /* Pin is configured as I2C1_SDA */
  };
  PORT_SetPinConfig(PORTC, PIN3_IDX, &portc3_pin39_config);  /* PORTC3 (pin 39) is configured as I2C1_SDA */
}
void InitAccel(void){
	i2c_master_config_t i2cConfig;
	uint8_t sensorRange = 0;
	uint32_t i2cSourceClock;
	uint8_t regResult = 0;
	uint8_t dataScale = 0;
	uint8_t array_addr_size = 0;
	bool foundDevice = false;

	/*Accelerometer*/
		BOARD_I2C_ReleaseBus();
		BOARD_I2C_ConfigurePins();

		i2cSourceClock = CLOCK_GetFreq(ACCEL_I2C_CLK_SRC);
		fxosHandle.base = BOARD_ACCEL_I2C_BASEADDR;
		fxosHandle.i2cHandle = &g_MasterHandle;

		I2C_MasterGetDefaultConfig(&i2cConfig);
		I2C_MasterInit(BOARD_ACCEL_I2C_BASEADDR, &i2cConfig, i2cSourceClock);
		I2C_MasterTransferCreateHandle(BOARD_ACCEL_I2C_BASEADDR, &g_MasterHandle, NULL, NULL);

		/* Find sensor devices */
		array_addr_size = sizeof(g_accel_address) / sizeof(g_accel_address[0]);
		for (uint8_t i = 0; i < array_addr_size; i++)
		{
			fxosHandle.xfer.slaveAddress = g_accel_address[i];
			if (FXOS_ReadReg(&fxosHandle, WHO_AM_I_REG, &regResult, 1) == kStatus_Success)
			{
				foundDevice = true;
				break;
			}
			if ((i == (array_addr_size - 1)) && (!foundDevice))
			{
				while (1)
				{
				};
			}
		}

		/* Init accelerometer sensor */
		if (FXOS_Init(&fxosHandle) != kStatus_Success)
		{
		}

		 /* Get sensor range */
		if (FXOS_ReadReg(&fxosHandle, XYZ_DATA_CFG_REG, &sensorRange, 1) != kStatus_Success)
		{
		}
		if (sensorRange == 0x00)
		{
			dataScale = 2U;
		}
		else if (sensorRange == 0x01)
		{
			dataScale = 4U;
		}
		else if (sensorRange == 0x10)
		{
			dataScale = 8U;
		}
		else
		{
		}
}

uint8_t Get_Accel(uint8_t* Data){
	int16_t xData, yData,zData;
	uint8_t i = 0, n = 0;
	char  xDataString[10], yDataString[10],zDataString[10];
	if (FXOS_ReadSensorData(&fxosHandle, &sensorData) != kStatus_Success)
					{
					}

	/* Get the X, Y, Z data from the sensor data structure in 14 bit left format data*/
	xData = (int16_t)((uint16_t)((uint16_t)sensorData.accelXMSB << 8) | (uint16_t)sensorData.accelXLSB) / 4U;
	yData = (int16_t)((uint16_t)((uint16_t)sensorData.accelYMSB << 8) | (uint16_t)sensorData.accelYLSB) / 4U;
	zData = (int16_t)((uint16_t)((uint16_t)sensorData.accelZMSB << 8) | (uint16_t)sensorData.accelZLSB) / 4U;

	Data[0] = 'X';
	Data[1] = '=';

	sprintf(xDataString, "%d", (int)xData);
	i=2;
	n = 0;
	while(xDataString[n] != 0) n++;

	for(uint8_t j = 0; j < n ; j++, i++){
		Data[i] = xDataString[j];
	}

	Data[i] = ' ';
	i++;
	Data[i] = 'Y';
	i++;
	Data[i] = '=';
	i++;

	sprintf(yDataString, "%d", (int)yData);
	n = 0;
	while(yDataString[n] != 0) n++;

	for(uint8_t j = 0; j < n ; j++, i++){
		Data[i] = yDataString[j];
	}

	Data[i] = ' ';
	i++;
	Data[i] = 'Z';
	i++;
	Data[i] = '=';
	i++;

	sprintf(zDataString, "%d",(int)zData);
	n = 0;
	while(zDataString[n] != 0) n++;

	for(uint8_t j = 0; j < n ; j++, i++){
		Data[i] = zDataString[j];
	}

	n = sizeof(from_IPV6);

	for(uint8_t j = 0; j < n ; j++, i++){
			Data[i] = from_IPV6[j];
	}

	i--;

	return i;

}
