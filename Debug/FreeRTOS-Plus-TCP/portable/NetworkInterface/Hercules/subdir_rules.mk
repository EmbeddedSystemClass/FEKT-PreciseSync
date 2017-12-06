################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
FreeRTOS-Plus-TCP/portable/NetworkInterface/Hercules/NetworkInterface.obj: ../FreeRTOS-Plus-TCP/portable/NetworkInterface/Hercules/NetworkInterface.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccs730/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/bin/armcl" -mv7R5 --code_state=32 --float_support=VFPv3D16 -O4 --opt_for_speed=0 --fp_mode=relaxed --include_path="C:/ti/ccs730/ccsv7/tools/compiler/ti-cgt-arm_16.9.4.LTS/include" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/source" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/include" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-CLI/include" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Include" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/include" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-IO/Device/tms570ls20x31x/SupportedBoards" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/include" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/protocols/include" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP/portable/Compiler/CCS" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-TCP" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/include" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-FAT/portable/common" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-UDP-Console/include" --include_path="W:/Disk Google/FEKT VUT - MS/MSPS/CCS/LaunchPad_FreeRTOS/FreeRTOS-Plus-UART-Console/include" -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile --preproc_dependency="FreeRTOS-Plus-TCP/portable/NetworkInterface/Hercules/NetworkInterface.d_raw" --obj_directory="FreeRTOS-Plus-TCP/portable/NetworkInterface/Hercules" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


