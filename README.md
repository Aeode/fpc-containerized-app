## DISCLAIMER: THIS TEMPLATE IS 95% WRITTEN WITH CLAUDE AI. REMAINING 5% IS JUST ME AUDITING AND TRYING TO UNDERSTAND THE CODE BECAUSE I HAVE NEVER WROTE ONE WITH PASCAL BEFORE!

# Pascal Project

A Free Pascal project with containerized build system using multi-stage Docker builds for minimal image sizes.

## Project Structure

```
.
├── src/
│   ├── main.pp            # Main program entry point
│   ├── extrautils         # Main program entry point
│   │   └── calculator.pp  # Calculator unit
│   └── utils/
│       └── greeter.pp     # Greeter unit
├── build/                 # Build output (gitignored)
│   ├── bin/               # Executable output
│   └── lib/               # Unit output
├── Makefile               # Build configuration
├── Containerfile          # Multi-stage container build
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

# Release build (optimized, statically linked)
make release

# Clean build artifacts
make clean

# Run debug build
make run
```

### Container Build

```bash
# Build the container image
podman build -t myapp:latest

# Run the container
podman run --rm myapp:latest
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
├── main.pp
├── extrautils/
│   └── calculator.pp
├── utils/
│   └── greeter.pp
├── models/
│   └── user.pp
└── controllers/
    └── api/
        └── handlers.pp
```

All `.pas` files will be found automatically.

## Development Workflow

1. Edit your Pascal source files in `src/`
2. Build and test locally: `make debug && ./build/bin/main`
3. Build app with either local binary (`make release`) or containerized (`podman build -t myapp .`)
4. Deploy the container or distribute the static binary in `build/bin`
