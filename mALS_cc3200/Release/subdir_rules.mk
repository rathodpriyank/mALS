################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
ADXL345.obj: ../ADXL345.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="ADXL345.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

additionalFiles.obj: ../additionalFiles.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="additionalFiles.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

button_if.obj: C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/button_if.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="button_if.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

gpio_if.obj: C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/gpio_if.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="gpio_if.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

i2c_if.obj: C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/i2c_if.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="i2c_if.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

main.obj: ../main.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="main.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

network_if.obj: C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/network_if.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="network_if.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

pinmux.obj: ../pinmux.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="pinmux.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

server_client_cbs.obj: ../server_client_cbs.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="server_client_cbs.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

simpleLinkExtra.obj: ../simpleLinkExtra.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="simpleLinkExtra.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

startup_ccs.obj: C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/startup_ccs.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="startup_ccs.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

timer_if.obj: C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/timer_if.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="timer_if.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

uart_if.obj: C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/uart_if.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/bin/armcl" -mv7M4 --code_state=16 --float_support=fpalib --abi=eabi -me -O2 --opt_for_speed=0 --include_path="C:/ti/ccsv6/tools/compiler/ti-cgt-arm_5.2.7/include" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/mqtt_server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/inc" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/simplelink/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/driverlib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/example/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/oslib/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/include/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/third_party/FreeRTOS/source/portable/CCS/ARM_CM3" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/common/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/server/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/client/" --include_path="C:/ti/CC3200SDK_1.1.0/cc3200-sdk/netapps/mqtt/include/" -g --gcc --define=ccs --define=cc3200 --define=USE_FREERTOS --define=SL_PLATFORM_MULTI_THREADED --diag_wrap=off --display_error_number --diag_warning=225 --preproc_with_compile --preproc_dependency="uart_if.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


