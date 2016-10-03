################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
LSS += \
test6.lss \

FLASH_IMAGE += \
test6.hex \

EEPROM_IMAGE += \
test6.eep \

SIZEDUMMY += \
sizedummy \


# All Target
all: test6.elf secondary-outputs

# Tool invocations
test6.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: AVR C Linker'
	avr-gcc -T ~/Dropbox/Research/BitGuard/projects/linker/mylinker.lds -Wl,-Map,test6.map -mmcu=atmega644 -o "test6.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

test6.lss: test6.elf
	@echo 'Invoking: AVR Create Extended Listing'
	-avr-objdump -h -S test6.elf  >"test6.lss"
	@echo 'Finished building: $@'
	@echo ' '

test6.hex: test6.elf
	@echo 'Create Flash image (ihex format)'
	-avr-objcopy -R .eeprom -O ihex test6.elf  "test6.hex"
	@echo 'Finished building: $@'
	@echo ' '

test6.eep: test6.elf
	@echo 'Create eeprom image (ihex format)'
	avr-objcopy -j .text -j .data -O ihex test6.elf test6.hex
	@echo 'Finished building: $@'
	@echo ' '

sizedummy: test6.elf
	@echo 'Invoking: Print Size'
	-avr-size --format=avr --mcu=atmega644 test6.elf
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(C_DEPS)$(ASM_DEPS)$(EEPROM_IMAGE)$(FLASH_IMAGE)$(ELFS)$(LSS)$(S_DEPS)$(SIZEDUMMY)$(S_UPPER_DEPS) test6.elf
	-@echo ' '

secondary-outputs: $(LSS) $(FLASH_IMAGE) $(EEPROM_IMAGE) $(SIZEDUMMY)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
