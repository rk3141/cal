const std = @import("std");
const log = @import("log.zig").log;

const Color = struct {
    r: u8,
    g: u8,
    b: u8,
};

pub const Fansi = struct {
    var fgo: ?Color = null;
    var bgo: ?Color = null;

    const Self = @This();
    pub inline fn foreground(self: Self, r: u8, g: u8, b: u8) Self {
        fgo = .{ .r = r, .g = g, .b = b };
        return self;
    }
    pub inline fn background(self: Self, r: u8, g: u8, b: u8) Self {
        bgo = .{ .r = r, .g = g, .b = b };
        return self;
    }

    pub inline fn print(self: Self, fmt: []const u8, args: anytype) Self {
        if (fgo) |fg| log("\x1B[38;2;{};{};{}m", .{ fg.r, fg.g, fg.b });
        if (bgo) |bg| log("\x1B[48;2;{};{};{}m", .{ bg.r, bg.g, bg.b });
        log(fmt, args);
        return self;
    }
    pub inline fn bold(self: Self) Self {
        log("\x1B[1m", .{});
        return self;
    }
    pub inline fn underline(self: Self) Self {
        log("\x1B[4m", .{});
        return self;
    }

    pub inline fn clear(self: Self) void {
        _ = self;
        log("\x1B[0m", .{});
    }
};

test "fansi_1" {
    const fansi = Fansi{};

    fansi.foreground(0x00, 0xaa, 0xff)
        .print("lolz", .{})
        .clear();
}

// fansi().red().bold()
