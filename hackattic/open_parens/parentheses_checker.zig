const std = @import("std");

fn isBalanced(line: []const u8) bool {
    var count: i32 = 0;
    
    for (line) |char| {
        switch (char) {
            '(' => count += 1,
            ')' => {
                count -= 1;
                if (count < 0) return false;
            },
            else => {},
        }
    }
    
    return count == 0;
}

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();
    
    var buffer: [1024]u8 = undefined;
    
    while (try stdin.readUntilDelimiterOrEof(buffer[0..], '\n')) |line| {
        const trimmed = std.mem.trim(u8, line, " \t\r\n");
        if (trimmed.len == 0) continue;
        
        const result = if (isBalanced(trimmed)) "yes" else "no";
        try stdout.print("{s}\n", .{result});
    }
}