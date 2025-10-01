```
 ╔═════════════════════════════════════════╗
 ║  ░░░░░ ░░░░ ░░░░░  ░░░░░ ░░░░░░  ░░░░░  ║
 ║     ░░  ░░  ░         ░░ ░░  ░░  ░      ║
 ║    ░░   ░░  ░  ░░    ░░  ░░░░░░  ░  ░░  ║
 ║   ░░    ░░  ░   ░   ░░   ░░  ░░  ░   ░  ║
 ║  ░░░░░ ░░░░ ░░░░░  ░░░░░ ░░  ░░  ░░░░░  ║
 ╚═════════════════════════════════════════╝
```

# zig_zag

[![CI](https://github.com/zkm/zig_zag/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/zkm/zig_zag/actions/workflows/ci.yml)

A Zig project featuring text art generation, mandelbrot fractals, and pattern creation with plenty of **zag**!

## Features ⚡ (with extra zag!)
- **ASCII Text Art**: Convert text to large ASCII art letters
- **Banners**: Create decorated text banners in multiple styles  
- **Patterns**: Generate geometric patterns (checkerboard, triangles, diamonds, waves, and zigzags!)
- **Mandelbrot Fractals**: Generate beautiful fractal images as PPM files
- **Zigzag Patterns**: Because you can never have too much zag!

## Requirements
- Zig 0.15.x (detected during setup)

## Quick start

Show usage help:
```sh
zig build run
```

Generate ASCII text art:
```sh
zig build run -- textart ZIG
zig build run -- textart "HELLO WORLD"
```

Create banners:
```sh
zig build run -- banner "Welcome!" simple
zig build run -- banner "Hello World" box
zig build run -- banner "ZIG ROCKS" ascii
```

Generate patterns (including zigzag!):
```sh
zig build run -- pattern triangle 10 10
zig build run -- pattern diamond 15 15
zig build run -- pattern checkerboard 20 10
zig build run -- pattern wave 30 10
zig build run -- pattern zigzag 25 8
```

Generate Mandelbrot fractal:
```sh
zig build run -- mandelbrot 800 600 100 mandelbrot.ppm
```

Simple hello:
```sh
zig build run -- hello
```

Run tests:
```sh
zig build test
```

Build the binary only:
```sh
zig build
./zig-out/bin/zig_zag
```

## Available Commands

| Command | Description | Example |
|---------|-------------|---------|
| `hello` | Simple greeting | `zig build run -- hello` |
| `textart [text]` | Generate ASCII art text | `zig build run -- textart ZIG` |
| `banner [text] [style]` | Create text banners | `zig build run -- banner "Hello" box` |
| `pattern [type] [width] [height]` | Generate patterns | `zig build run -- pattern triangle 10 10` |
| `mandelbrot [w] [h] [iter] [file]` | Generate fractal | `zig build run -- mandelbrot 400 300 50 out.ppm` |

### Banner Styles
- `simple` - Basic banner with equal signs
- `box` - Box border with ASCII characters
- `ascii` - Large ASCII art letters

### Pattern Types
- `checkerboard` - Alternating pattern
- `triangle` - Triangular star pattern  
- `diamond` - Diamond star pattern
- `wave` - Sine wave pattern
- `zigzag` - Classic zigzag pattern (the zag you've been waiting for!)

## Development

Format code:
```sh
zig fmt .
```

Cross-compile example (Linux x86_64 -> Windows x86_64):
```sh
zig build -Dtarget=x86_64-windows-gnu -Doptimize=ReleaseSmall
```

## Project layout
- `build.zig` – build script
- `src/main.zig` – entry point and command router
- `src/textart.zig` – ASCII art generation
- `src/mandelbrot.zig` – fractal generation

## Examples

**Create ASCII art for your name:**
```sh
zig build run -- textart "YOUR NAME"
```

**Generate a welcome banner:**
```sh
zig build run -- banner "Welcome to Zig!" box
```

**Create a diamond pattern:**
```sh
zig build run -- pattern diamond 11 11
```

**Generate a small Mandelbrot fractal:**
```sh
zig build run -- mandelbrot 200 200 50 small.ppm
```

**Create a zigzag pattern (the ultimate zag!):**
```sh
zig build run -- pattern zigzag 30 12
```

**Make some zag-tastic ASCII art:**
```sh
zig build run -- textart "ZAG ZAG ZAG"
```