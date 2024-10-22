const std = @import("std");

pub fn log(comptime fmt: []const u8, args: anytype) void {
    switch (@import("builtin").mode) {
        .Debug => std.debug.print(fmt, args),
        else => {
            const stdout = std.io.getStdOut();
            stdout.writer().print(fmt, args) catch {
                std.debug.print("could not write to stdout :((", .{});
            };
        },
    }
}
