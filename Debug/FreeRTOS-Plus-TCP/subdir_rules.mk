################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
FreeRTOS-Plus-TCP/FreeRTOS_ARP.obj: ../FreeRTOS-Plus-TCP/FreeRTOS_ARP.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/source" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/FreeRTOS_ARP.d_raw" --obj_directory="FreeRTOS-Plus-TCP" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

FreeRTOS-Plus-TCP/FreeRTOS_DHCP.obj: ../FreeRTOS-Plus-TCP/FreeRTOS_DHCP.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/source" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/FreeRTOS_DHCP.d_raw" --obj_directory="FreeRTOS-Plus-TCP" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

FreeRTOS-Plus-TCP/FreeRTOS_DNS.obj: ../FreeRTOS-Plus-TCP/FreeRTOS_DNS.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/source" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/FreeRTOS_DNS.d_raw" --obj_directory="FreeRTOS-Plus-TCP" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

FreeRTOS-Plus-TCP/FreeRTOS_IP.obj: ../FreeRTOS-Plus-TCP/FreeRTOS_IP.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/source" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/FreeRTOS_IP.d_raw" --obj_directory="FreeRTOS-Plus-TCP" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

FreeRTOS-Plus-TCP/FreeRTOS_Sockets.obj: ../FreeRTOS-Plus-TCP/FreeRTOS_Sockets.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/source" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/FreeRTOS_Sockets.d_raw" --obj_directory="FreeRTOS-Plus-TCP" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

FreeRTOS-Plus-TCP/FreeRTOS_Stream_Buffer.obj: ../FreeRTOS-Plus-TCP/FreeRTOS_Stream_Buffer.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/source" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/FreeRTOS_Stream_Buffer.d_raw" --obj_directory="FreeRTOS-Plus-TCP" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

FreeRTOS-Plus-TCP/FreeRTOS_TCP_IP.obj: ../FreeRTOS-Plus-TCP/FreeRTOS_TCP_IP.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/source" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/FreeRTOS_TCP_IP.d_raw" --obj_directory="FreeRTOS-Plus-TCP" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

FreeRTOS-Plus-TCP/FreeRTOS_TCP_WIN.obj: ../FreeRTOS-Plus-TCP/FreeRTOS_TCP_WIN.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/source" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/FreeRTOS_TCP_WIN.d_raw" --obj_directory="FreeRTOS-Plus-TCP" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

FreeRTOS-Plus-TCP/FreeRTOS_UDP_IP.obj: ../FreeRTOS-Plus-TCP/FreeRTOS_UDP_IP.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/source" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="E:/TI/workspace_v7/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/FreeRTOS_UDP_IP.d_raw" --obj_directory="FreeRTOS-Plus-TCP" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


