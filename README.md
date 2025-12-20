# Pascal Project

A Free Pascal project with containerized build system using multi-stage Docker builds for minimal image sizes.

## Project Structure

```
.
├── src/
│   ├── main.pas           # Main program entry point
│   └── utils/
│       └── greeter.pas    # Greeter unit
├── build/                 # Build output (gitignored)
│   ├── debug/
│   └── release/
├── Makefile              # Build configuration
├── Containerfile         # Multi-stage container build
├── .gitignore
├── .gitattributes
└── .dockerignore
```

## Prerequisites

### For Local Development
- Free Pascal Compiler (FPC) 3.2.2+
- Make
- VS Code (optional, for IDE support)

### For Container Builds
- Podman or Docker

## Building

### Local Build

```bash
# Debug build (with symbols)
make debug
./build/debug/main

# Release build (optimized, statically linked)
make release
./build/release/main

# Clean build artifacts
make clean
```

### Container Build

The Containerfile uses a multi-stage build to produce a minimal image (~1-5 MB) with a statically-linked binary.

```bash
# Build the container image
podman build -t myapp:latest .

# Run the container
podman run --rm myapp:latest
```

**From within Distrobox (Bazzite/immutable systems):**

```bash
# Build using host's Podman
distrobox-host-exec podman build -t myapp:latest .

# Run the container
distrobox-host-exec podman run --rm myapp:latest
```

## VS Code Setup

### Required Extensions

```bash
# Install all extensions
code --install-extension alefragnani.pascal-formatter
code --install-extension webfreak.debug
code --install-extension wosi.omnipascal
```

### Optional: Pascal Formatter Setup

The project uses [jcf-pascal-format](https://github.com/quadroid/jcf-pascal-format) for code formatting. This is optional but recommended.

**Installation:**

```bash
# Clone and build the formatter
cd ~/Dev/Projects
git clone https://github.com/quadroid/jcf-pascal-format.git
cd jcf-pascal-format

# Build (requires FPC)
make

# The binary will be at ./pascal_format
```

**VS Code Configuration:**

Add to your `.vscode/settings.json` or user settings:

```json
{
    "omnipascal.defaultDevelopmentEnvironment": "FreePascal",
    "omnipascal.freePascalSourcePath": "/usr/share/fpcsrc",
    "pascal.formatter.engine": "jcf-quadroid",
    "pascal.formatter.enginePath": "/path/to/jcf-pascal-format/pascal_format"
}
```

> **Note:** Fedora doesn't have `jcf-pascal-format` in its repositories, so manual build is required.

## Build Configuration

The Makefile automatically discovers all subdirectories under `src/` for unit paths, so you can organize your code freely:

```
src/
├── main.pas
├── utils/
│   └── greeter.pas
├── models/
│   └── user.pas
└── controllers/
    └── api/
        └── handlers.pas
```

All `.pas` files will be found automatically.

## Static Linking

Release builds use static linking (`-XS -Xt` flags) to create self-contained binaries that:
- Work on any Linux system (same architecture)
- Have no external dependencies
- Are perfect for containers and distribution
- Can use `FROM scratch` base image for minimal container size

## Development Workflow

1. Edit your Pascal source files in `src/`
2. Build and test locally: `make debug && ./build/debug/main`
3. Build optimized binary: `make release`
4. Build container: `podman build -t myapp .`
5. Deploy container or distribute the static binary