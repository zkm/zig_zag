const std = @import("std");

// ASCII art patterns for letters (5x7 bitmap)
const LETTER_HEIGHT = 7;
const LETTER_WIDTH = 5;

const LETTERS = [_][LETTER_HEIGHT][LETTER_WIDTH]u8{
    // A
    .{
        .{ ' ', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', '#', '#', '#', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // B
    .{
        .{ '#', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', '#', '#', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // C
    .{
        .{ ' ', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', '#', '#', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // D
    .{
        .{ '#', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', '#', '#', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // E
    .{
        .{ '#', '#', '#', '#', '#' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', '#', '#', '#', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // F
    .{
        .{ '#', '#', '#', '#', '#' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // G
    .{
        .{ ' ', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', '#', '#', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', '#', '#', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // H
    .{
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', '#', '#', '#', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // I
    .{
        .{ '#', '#', '#', '#', '#' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ '#', '#', '#', '#', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // J
    .{
        .{ '#', '#', '#', '#', '#' },
        .{ ' ', ' ', ' ', '#', ' ' },
        .{ ' ', ' ', ' ', '#', ' ' },
        .{ ' ', ' ', ' ', '#', ' ' },
        .{ '#', ' ', ' ', '#', ' ' },
        .{ ' ', '#', '#', ' ', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // K
    .{
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', '#', ' ' },
        .{ '#', ' ', '#', ' ', ' ' },
        .{ '#', '#', ' ', ' ', ' ' },
        .{ '#', ' ', '#', ' ', ' ' },
        .{ '#', ' ', ' ', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // L
    .{
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', '#', '#', '#', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // M
    .{
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', '#', ' ', '#', '#' },
        .{ '#', ' ', '#', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // N
    .{
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', '#', ' ', ' ', '#' },
        .{ '#', ' ', '#', ' ', '#' },
        .{ '#', ' ', ' ', '#', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // O
    .{
        .{ ' ', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', '#', '#', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // P
    .{
        .{ '#', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // Q
    .{
        .{ ' ', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', '#', ' ', '#' },
        .{ '#', ' ', ' ', '#', '#' },
        .{ ' ', '#', '#', '#', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // R
    .{
        .{ '#', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', '#', '#', '#', ' ' },
        .{ '#', ' ', '#', ' ', ' ' },
        .{ '#', ' ', ' ', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // S
    .{
        .{ ' ', '#', '#', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ ' ', '#', '#', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', '#' },
        .{ '#', '#', '#', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // T
    .{
        .{ '#', '#', '#', '#', '#' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // U
    .{
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', '#', '#', '#', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // V
    .{
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', '#', ' ', '#', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // W
    .{
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ '#', ' ', '#', ' ', '#' },
        .{ '#', '#', ' ', '#', '#' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // X
    .{
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', '#', ' ', '#', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', '#', ' ', '#', ' ' },
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // Y
    .{
        .{ '#', ' ', ' ', ' ', '#' },
        .{ ' ', '#', ' ', '#', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
    // Z
    .{
        .{ '#', '#', '#', '#', '#' },
        .{ ' ', ' ', ' ', '#', ' ' },
        .{ ' ', ' ', '#', ' ', ' ' },
        .{ ' ', '#', ' ', ' ', ' ' },
        .{ '#', ' ', ' ', ' ', ' ' },
        .{ '#', '#', '#', '#', '#' },
        .{ ' ', ' ', ' ', ' ', ' ' },
    },
};

// Space character pattern
const SPACE = [LETTER_HEIGHT][LETTER_WIDTH]u8{
    .{ ' ', ' ', ' ', ' ', ' ' },
    .{ ' ', ' ', ' ', ' ', ' ' },
    .{ ' ', ' ', ' ', ' ', ' ' },
    .{ ' ', ' ', ' ', ' ', ' ' },
    .{ ' ', ' ', ' ', ' ', ' ' },
    .{ ' ', ' ', ' ', ' ', ' ' },
    .{ ' ', ' ', ' ', ' ', ' ' },
};

pub fn printTextArt(text: []const u8) void {
    if (text.len == 0) return;

    // Print each row of the text art
    for (0..LETTER_HEIGHT) |row| {
        for (text) |char| {
            const pattern = getLetterPattern(char);
            for (pattern[row]) |pixel| {
                std.debug.print("{c}", .{pixel});
            }
            std.debug.print(" ", .{}); // Space between letters
        }
        std.debug.print("\n", .{});
    }
}

fn getLetterPattern(char: u8) *const [LETTER_HEIGHT][LETTER_WIDTH]u8 {
    const upper_char = std.ascii.toUpper(char);
    if (upper_char >= 'A' and upper_char <= 'Z') {
        return &LETTERS[upper_char - 'A'];
    }
    return &SPACE;
}

pub fn generateBanner(alloc: std.mem.Allocator, text: []const u8, style: []const u8) !void {
    _ = alloc; // Mark as unused for now
    if (std.mem.eql(u8, style, "simple")) {
        printSimpleBanner(text);
    } else if (std.mem.eql(u8, style, "box")) {
        printBoxBanner(text);
    } else if (std.mem.eql(u8, style, "ascii")) {
        printTextArt(text);
    } else {
        std.debug.print("Unknown style: {s}\n", .{style});
        std.debug.print("Available styles: simple, box, ascii\n", .{});
    }
}

fn printSimpleBanner(text: []const u8) void {
    const border = "=" ** 50;
    std.debug.print("{s}\n", .{border});
    std.debug.print("  {s}\n", .{text});
    std.debug.print("{s}\n", .{border});
}

fn printBoxBanner(text: []const u8) void {
    const padding = 4;
    const box_width = text.len + padding * 2;
    
    // Top border
    std.debug.print("+", .{});
    for (0..box_width) |_| {
        std.debug.print("-", .{});
    }
    std.debug.print("+\n", .{});
    
    // Empty line
    std.debug.print("|", .{});
    for (0..box_width) |_| {
        std.debug.print(" ", .{});
    }
    std.debug.print("|\n", .{});
    
    // Text line
    std.debug.print("|", .{});
    for (0..padding) |_| {
        std.debug.print(" ", .{});
    }
    std.debug.print("{s}", .{text});
    for (0..padding) |_| {
        std.debug.print(" ", .{});
    }
    std.debug.print("|\n", .{});
    
    // Empty line
    std.debug.print("|", .{});
    for (0..box_width) |_| {
        std.debug.print(" ", .{});
    }
    std.debug.print("|\n", .{});
    
    // Bottom border
    std.debug.print("+", .{});
    for (0..box_width) |_| {
        std.debug.print("-", .{});
    }
    std.debug.print("+\n", .{});
}

// Generate some fun patterns
pub fn generatePattern(pattern_type: []const u8, width: u32, height: u32) void {
    if (std.mem.eql(u8, pattern_type, "checkerboard")) {
        generateCheckerboard(width, height);
    } else if (std.mem.eql(u8, pattern_type, "triangle")) {
        generateTriangle(height);
    } else if (std.mem.eql(u8, pattern_type, "diamond")) {
        generateDiamond(height);
    } else if (std.mem.eql(u8, pattern_type, "wave")) {
        generateWave(width, height);
    } else if (std.mem.eql(u8, pattern_type, "zigzag")) {
        generateZigzag(width, height);
    } else {
        std.debug.print("Unknown pattern: {s}\n", .{pattern_type});
        std.debug.print("Available patterns: checkerboard, triangle, diamond, wave, zigzag\n", .{});
    }
}

fn generateCheckerboard(width: u32, height: u32) void {
    for (0..height) |y| {
        for (0..width) |x| {
            if ((x + y) % 2 == 0) {
                std.debug.print("#", .{});
            } else {
                std.debug.print(" ", .{});
            }
        }
        std.debug.print("\n", .{});
    }
}

fn generateTriangle(height: u32) void {
    for (0..height) |y| {
        const spaces = height - y - 1;
        const stars = y * 2 + 1;
        
        for (0..spaces) |_| {
            std.debug.print(" ", .{});
        }
        for (0..stars) |_| {
            std.debug.print("*", .{});
        }
        std.debug.print("\n", .{});
    }
}

fn generateDiamond(size: u32) void {
    const mid = size / 2;
    
    // Top half
    for (0..mid + 1) |y| {
        const spaces = mid - y;
        const stars = y * 2 + 1;
        
        for (0..spaces) |_| {
            std.debug.print(" ", .{});
        }
        for (0..stars) |_| {
            std.debug.print("*", .{});
        }
        std.debug.print("\n", .{});
    }
    
    // Bottom half
    for (0..mid) |y| {
        const row = mid - y - 1;
        const spaces = mid - row;
        const stars = row * 2 + 1;
        
        for (0..spaces) |_| {
            std.debug.print(" ", .{});
        }
        for (0..stars) |_| {
            std.debug.print("*", .{});
        }
        std.debug.print("\n", .{});
    }
}

fn generateWave(width: u32, height: u32) void {
    for (0..height) |y| {
        for (0..width) |x| {
            const wave = @sin(@as(f32, @floatFromInt(x)) * 0.3 + @as(f32, @floatFromInt(y)) * 0.1);
            if (wave > 0.0) {
                std.debug.print("~", .{});
            } else {
                std.debug.print(" ", .{});
            }
        }
        std.debug.print("\n", .{});
    }
}

fn generateZigzag(width: u32, height: u32) void {
    for (0..height) |row| {
        const y: i32 = @intCast(row);
        for (0..width) |col| {
            const x: i32 = @intCast(col);
            // Create zigzag pattern: alternates direction every few rows
            const zigzag_period: i32 = 4;
            const cycle_pos = @divTrunc(y, zigzag_period);
            const direction: i32 = if (@rem(cycle_pos, 2) == 0) 1 else -1;
            const offset: i32 = @rem(y, zigzag_period) * direction;
            const center: i32 = @intCast(width / 2);
            
            if (x == center + offset) {
                std.debug.print("/", .{});
            } else if (x == center + offset + direction) {
                std.debug.print("\\", .{});
            } else {
                std.debug.print(" ", .{});
            }
        }
        std.debug.print("\n", .{});
    }
}

test "text art basic functionality" {
    // Just test that it compiles and doesn't crash
    printTextArt("TEST");
}