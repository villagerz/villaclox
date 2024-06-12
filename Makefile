CC = gcc
CFLAGS = -Wall -I./src
BUILD_DIR := build
SOURCE_DIR := src
OBJ_DIR = obj
HEADERS := $(wildcard $(SOURCE_DIR)/*.h)
SOURCES := $(wildcard $(SOURCE_DIR)/*.c)

NAME = clox

TARGET = $(BUILD_DIR)/clox
OBJECTS := $(addprefix $(BUILD_DIR)/$(OBJ_DIR)/, $(notdir $(SOURCES:.c=.o)))

default: $(TARGET)

# Remove all build outputs and intermediate files.
clean:
	@ rm -rf $(BUILD_DIR)

# Link the interpreter.
$(TARGET): $(OBJECTS) | $(BUILD_DIR)
	@ printf "%8s %-40s %s\n" $(CC) $@ "$(CFLAGS)"
	@ $(CC) $(CFLAGS) $^ -o $@
	@ cp build/clox clox # For convenience, copy the interpreter to the top level.



# Compile object files.
$(BUILD_DIR)/$(OBJ_DIR)/%.o: $(SOURCE_DIR)/%.c $(HEADERS) | $(BUILD_DIR)/$(OBJ_DIR)
	@ printf "%8s %-40s %s\n" $(CC) $< "$(CFLAGS)"
	$(CC) -c $(C_LANG) $(CFLAGS) -o $@ $<

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/$(OBJ_DIR):
	mkdir -p $(BUILD_DIR)/$(OBJ_DIR)

.PHONY:  clean clox  debug default 
