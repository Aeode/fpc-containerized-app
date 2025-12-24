# Project settings
PROJECT = main
SRC_DIR = src
BUILD_DIR = build
BIN_DIR = $(BUILD_DIR)/bin
LIB_DIR = $(BUILD_DIR)/lib

# Compiler
FPC = fpc
MAIN_SRC = "$(SRC_DIR)/main.pp"

# Config files
DEBUG_CFG = fpc-debug.cfg
RELEASE_CFG = fpc-release.cfg

# Targets
.PHONY: all debug release clean help

# Default target
all: debug

# Debug build
debug:
	@echo "Building debug..."
	@mkdir -p $(BIN_DIR) $(LIB_DIR)
	$(FPC) @$(DEBUG_CFG) $(MAIN_SRC) -o"$(BIN_DIR)/$(PROJECT)"
	@echo "Success: $(BIN_DIR)/$(PROJECT)"

# Release build
release:
	@echo "Building release..."
	@mkdir -p $(BIN_DIR) $(LIB_DIR)
	$(FPC) @$(RELEASE_CFG) $(MAIN_SRC) -o"$(BIN_DIR)/$(PROJECT)"
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