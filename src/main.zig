const std = @import("std");

fn from_epoch(now: i64) void {
    var days_since = @divFloor(now, std.time.s_per_day); // 1 jan 1970

    const day = @mod(days_since, 7) - 3;

    var leap = false;

    var year: u32 = 1970;

    while (days_since > 365) {
        if (year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)) {
            leap = true;
            days_since -= 366;
        } else days_since -= 365;

        year += 1;
    }

    var month: u32 = 1;
    const feb: u32 = if (leap) 29 else 28;

    //jan
    if (days_since > 31) {
        days_since -= 31;
        month += 1;
    }
    //feb
    if (days_since > feb) {
        days_since -= feb;
        month += 1;
    }
    //mar
    if (days_since > 31) {
        days_since -= 31;
        month += 1;
    }
    //apr
    if (days_since > 30) {
        days_since -= 30;
        month += 1;
    }
    //may
    if (days_since > 31) {
        days_since -= 31;
        month += 1;
    }
    // june
    if (days_since > 30) {
        days_since -= 30;
        month += 1;
    }
    //jul
    if (days_since > 31) {
        days_since -= 31;
        month += 1;
    }
    //aug
    if (days_since > 31) {
        days_since -= 31;
        month += 1;
    }
    //sep
    if (days_since > 30) {
        days_since -= 30;
        month += 1;
    }
    //oct
    if (days_since > 31) {
        days_since -= 31;
        month += 1;
    }
    //nov
    if (days_since > 30) {
        days_since -= 30;
        month += 1;
    }
    //dec
    if (days_since > 31) {
        days_since -= 31;
        month += 1;
    }

    std.debug.print("     ({: >2}/{: >2}/{: >4})\n", .{ days_since + 1, month, year });
    // 21
    // 6 + 8 + 6
    print_month(month, @intCast(days_since), @intCast(day), leap);
}

pub fn main() !void {
    const now = std.time.timestamp();

    from_epoch(now);
}

fn print_month(month: u32, days_since: i64, day: i64, leap: bool) void {
    const days: u32 = switch (month) {
        1, 3, 5, 7, 8, 10, 12 => 31,
        4, 6, 9, 11 => 30,
        2 => if (leap) 29 else 28,
        else => 0,
    };

    const diff: u32 = @intCast(@mod((day - days_since), 7));
    // 13 + k % 7 = 1

    std.debug.print("\x1B[96;4;1m Su Mo Tu We Th Fr Sa\x1B[0m\n", .{});
    // std.debug.print("---------------------\n", .{});

    for (0..diff) |_| {
        std.debug.print("   ", .{});
    }

    for (0..days) |d| {
        if (d == days_since) {
            std.debug.print("\x1B[32;1m{: >3}\x1B[0m", .{d + 1});
        } else {
            std.debug.print("\x1B[31m{: >3}\x1B[0m", .{d + 1});
        }
        if ((d + diff + 1) % 7 == 0) {
            std.debug.print("\n", .{});
        }
    }
    std.debug.print("\n", .{});
}

test "simple test" {
    const now2: i64 = 1728905215;
    const now3: i64 = 1728991615;

    from_epoch(now2);
    from_epoch(now3);
}
