const std = @import("std");

pub fn run(alloc: std.mem.Allocator, width: u32, height: u32, max_iter: u16, out_path: []const u8) !void {
    // Prepare buffer: RGB per pixel
    const pixel_count = @as(usize, width) * @as(usize, height);
    const buf = try alloc.alloc(u8, pixel_count * 3);
    defer alloc.free(buf);

    const cpu_count = std.Thread.getCpuCount() catch 1;
    const job_count: u32 = if (cpu_count < 1) 1 else @intCast(cpu_count);
    const rows_per_job = (height + job_count - 1) / job_count;

    var threads = try alloc.alloc(std.Thread, job_count);
    defer alloc.free(threads);

    var i: u32 = 0;
    while (i < job_count) : (i += 1) {
        const start_row: u32 = i * rows_per_job;
        const end_row: u32 = @min(height, start_row + rows_per_job);
        if (start_row >= end_row) {
            // no work; spawn a no-op that returns immediately
            threads[i] = try std.Thread.spawn(.{}, noop, .{});
            continue;
        }
        threads[i] = try std.Thread.spawn(.{}, worker, .{ buf, width, height, max_iter, start_row, end_row });
    }

    for (threads) |t| t.join();

    // Write PPM (P6)
    var file = try std.fs.cwd().createFile(out_path, .{ .read = false, .truncate = true, .exclusive = false });
    defer file.close();

    // Write header
    var header_buf: [64]u8 = undefined;
    const header = try std.fmt.bufPrint(&header_buf, "P6\n{d} {d}\n255\n", .{ width, height });
    try file.writeAll(header);
    try file.writeAll(buf);
}

fn noop() void {}

fn worker(buf: []u8, width: u32, height: u32, max_iter: u16, start_row: u32, end_row: u32) void {
    const scale_x = 3.5 / @as(f64, @floatFromInt(width));
    const scale_y = 2.0 / @as(f64, @floatFromInt(height));
    var y: u32 = start_row;
    while (y < end_row) : (y += 1) {
        var x: u32 = 0;
        while (x < width) : (x += 1) {
            const cx = @as(f64, @floatFromInt(x)) * scale_x - 2.5;
            const cy = @as(f64, @floatFromInt(y)) * scale_y - 1.0;
            var zx: f64 = 0;
            var zy: f64 = 0;
            var iter: u16 = 0;
            while (iter < max_iter) : (iter += 1) {
                const zx2 = zx * zx - zy * zy + cx;
                const zy2 = 2.0 * zx * zy + cy;
                zx = zx2;
                zy = zy2;
                if (zx * zx + zy * zy > 4.0) break;
            }
            const idx = (@as(usize, y) * @as(usize, width) + @as(usize, x)) * 3;
            const color = colorize(iter, max_iter);
            buf[idx + 0] = color[0];
            buf[idx + 1] = color[1];
            buf[idx + 2] = color[2];
        }
    }
}

fn colorize(iter: u16, max_iter: u16) [3]u8 {
    if (iter >= max_iter) return .{ 0, 0, 0 };
    const t = @as(f64, @floatFromInt(iter)) / @as(f64, @floatFromInt(max_iter));
    // Smooth gradient using simple polynomial palette
    const r = @as(u8, @intFromFloat(@floor(9.0 * (1.0 - t) * t * t * t * 255.0)));
    const g = @as(u8, @intFromFloat(@floor(15.0 * (1.0 - t) * (1.0 - t) * t * t * 255.0)));
    const b = @as(u8, @intFromFloat(@floor(8.5 * (1.0 - t) * (1.0 - t) * (1.0 - t) * t * 255.0)));
    return .{ r, g, b };
}

test "colorize bounds" {
    const c0 = colorize(0, 10);
    _ = c0; // just ensure it compiles
    const c1 = colorize(10, 10);
    try std.testing.expectEqual(@as(u8, 0), c1[0]);
}
