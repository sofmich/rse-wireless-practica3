################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../freertos/croutine.c \
../freertos/event_groups.c \
../freertos/fsl_tickless_lptmr.c \
../freertos/fsl_tickless_systick.c \
../freertos/heap_4.c \
../freertos/list.c \
../freertos/port.c \
../freertos/queue.c \
../freertos/tasks.c \
../freertos/timers.c 

OBJS += \
./freertos/croutine.o \
./freertos/event_groups.o \
./freertos/fsl_tickless_lptmr.o \
./freertos/fsl_tickless_systick.o \
./freertos/heap_4.o \
./freertos/list.o \
./freertos/port.o \
./freertos/queue.o \
./freertos/tasks.o \
./freertos/timers.o 

C_DEPS += \
./freertos/croutine.d \
./freertos/event_groups.d \
./freertos/fsl_tickless_lptmr.d \
./freertos/fsl_tickless_systick.d \
./freertos/heap_4.d \
./freertos/list.d \
./freertos/port.d \
./freertos/queue.d \
./freertos/tasks.d \
./freertos/timers.d 


# Each subdirectory must supply rules for building sources it contributes
freertos/%.o: ../freertos/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -std=gnu99 -D__REDLIB__ -DCPU_MKW41Z512VHT4 -DCPU_MKW41Z512VHT4_cm0plus -D__SEMIHOST_HARDFAULT_DISABLE=1 -DFSL_RTOS_FREE_RTOS -DFRDM_KW41Z -DFREEDOM -DSDK_DEBUGCONSOLE=1 -DCR_INTEGER_PRINTF -DPRINTF_FLOAT_ENABLE=0 -D__MCUXPRESSO -D__USE_CMSIS -DDEBUG -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\board" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\source" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\OSAbstraction\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\common" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\freertos" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\ieee_802.15.4\mac\source\App" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\ieee_802.15.4\mac\interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\ieee_802.15.4\phy\interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\GPIO" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\Keyboard\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\TimersManager\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\TimersManager\Source" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\LED\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\SerialManager\Source\SPI_Adapter" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\SerialManager\Source\UART_Adapter" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\SerialManager\Source\I2C_Adapter" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\Flash\Internal" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\MemManager\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\Lists" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\Messaging\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\Panic\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\RNG\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\SerialManager\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\SecLib" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\FunctionLib" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\ModuleInfo" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\MWSCoexistence\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\Shell\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\NVM\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\NVM\Source" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\FSCI\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\FSCI\Source" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\LowPower\Interface\MKW41Z" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\LowPower\Source\MKW41Z" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\nwk_ip\core\interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\nwk_ip\core\interface\modules" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\nwk_ip\core\interface\thread" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\nwk_ip\base\interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\nwk_ip\core\interface\http" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\nwk_ip\app\config" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\nwk_ip\app\common" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\drivers" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\CMSIS" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\utilities" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\DCDC\Interface" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\framework\XCVR\MKW41Z4" -I"D:\Andre\OneDrive - ITESO\7 Semestre\RSE\frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router\ieee_802.15.4\phy\source\MKW41Z" -Og -fno-common -g -Wall -Wno-missing-braces  -c  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin -imacros "D:/Andre/OneDrive - ITESO/7 Semestre/RSE/frdmkw41z_wireless_examples_thread_router_eligible_device_freertos_router/source/config.h" -fmacro-prefix-map="../$(@D)/"=. -mcpu=cortex-m0plus -mthumb -D__REDLIB__ -fstack-usage -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


