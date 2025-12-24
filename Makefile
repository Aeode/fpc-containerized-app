# Project settings
PROJECT = main
SRC_DIR = src
BUILD_DIR = build
BIN_DIR = $(BUILD_DIR)/bin
LIB_DIR = $(BUILD_DIR)/lib

# Compiler settings
FPC = fpc
FPC_FLAGS = -Mobjfpc -Fu"$(SRC_DIR)/*" -FE"$(BIN_DIR)" -FU"$(LIB_DIR)"
DEBUG_FLAGS = -g -gl -O- -dDEBUG
RELEASE_FLAGS = -O2 -Xs -dRelease

# Source files
MAIN_SRC = $(SRC_DIR)/main.pp

# Targets
.PHONY: all debug release clean help

# Default target
all: debug

# Debug build
debug:
	@echo "Building debug..."
	@mkdir -p $(BIN_DIR) $(LIB_DIR)
	$(FPC) $(MAIN_SRC) $(FPC_FLAGS) $(DEBUG_FLAGS) -o"$(BIN_DIR)/$(PROJECT)"
	@echo "Success: $(BIN_DIR)/$(PROJECT)"

# Release build
release:
	@echo "Building release..."
	@mkdir -p $(BIN_DIR) $(LIB_DIR)
	$(FPC) $(MAIN_SRC) $(FPC_FLAGS) $(RELEASE_FLAGS) -o"$(BIN_DIR)/$(PROJECT)"
	@echo "Success: $(BIN_DIR)/$(PROJECT)"

# Clean build artifacts
clean:
	@echo "Cleaning..."
	@rm -rf $(BUILD_DIR)

# Run the program
run: debug
	@./$(BIN_DIR)/$(PROJECT)

# Help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  debug      Build debug version (default)"
	@echo "  release    Build release version"
	@echo "  clean      Remove build artifacts"
	@echo "  run        Build and run debug version"
	@echo "  help       Show this help"