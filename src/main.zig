const std = @import("std");
const mandelbrot = @import("mandelbrot.zig");
const textart = @import("textart.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const args = try std.process.argsAlloc(alloc);
    defer std.process.argsFree(alloc, args);

    if (args.len == 1) {
        printUsage();
        return;
    }

    if (std.mem.eql(u8, args[1], "hello")) {
        std.debug.print("Hello from Zig!\n", .{});
        return;
    }

    if (std.mem.eql(u8, args[1], "mandelbrot")) {
        if (args.len < 6) {
            printUsage();
            return;
        }

        const width = try std.fmt.parseInt(u32, args[2], 10);
        const height = try std.fmt.parseInt(u32, args[3], 10);
        const max_iter = try std.fmt.parseInt(u16, args[4], 10);
        const output_path = args[5];

        try mandelbrot.run(alloc, width, height, max_iter, output_path);
        std.debug.print("Mandelbrot generated: {s}\n", .{output_path});
        return;
    }

    if (std.mem.eql(u8, args[1], "textart")) {
        if (args.len < 3) {
            printUsage();
            return;
        }
        const text = args[2];
        textart.printTextArt(text);
        return;
    }

    if (std.mem.eql(u8, args[1], "banner")) {
        if (args.len < 4) {
            printUsage();
            return;
        }
        const text = args[2];
        const style = args[3];
        try textart.generateBanner(alloc, text, style);
        return;
    }

    if (std.mem.eql(u8, args[1], "pattern")) {
        if (args.len < 5) {
            printUsage();
            return;
        }
        const pattern_type = args[2];
        const width = try std.fmt.parseInt(u32, args[3], 10);
        const height = try std.fmt.parseInt(u32, args[4], 10);
        textart.generatePattern(pattern_type, width, height);
        return;
    }

    printUsage();
}

fn printUsage() void {
    std.debug.print("Usage:\n", .{});
    std.debug.print("  zig build run -- hello\n", .{});
    std.debug.print("  zig build run -- mandelbrot [width] [height] [max_iter] [output.ppm]\n", .{});
    std.debug.print("  zig build run -- textart [text]\n", .{});
    std.debug.print("  zig build run -- banner [text] [style]  (styles: simple, box, ascii)\n", .{});
    std.debug.print("  zig build run -- pattern [type] [width] [height]  (types: checkerboard, triangle, diamond, wave, zigzag)\n", .{});
    std.debug.print("  zig build test\n", .{});
    std.debug.print("\nExamples:\n", .{});
    std.debug.print("  zig build run -- textart ZIG\n", .{});
    std.debug.print("  zig build run -- textart ZAG  (extra zag!)\n", .{});
    std.debug.print("  zig build run -- banner \"Hello World\" box\n", .{});
    std.debug.print("  zig build run -- pattern triangle 10 10\n", .{});
    std.debug.print("  zig build run -- pattern zigzag 25 8  (the ultimate zag!)\n", .{});
}

test "basic math works" {
    try std.testing.expect(2 + 2 == 4);
}
