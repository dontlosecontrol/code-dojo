const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    while (stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024)) |line_opt| {
        const line = line_opt orelse break;
        const trimmed = std.mem.trim(u8, line, " \t\r\n");
        if (trimmed.len == 0) continue;

        const decoded_size = std.base64.standard.Decoder.calcSizeForSlice(trimmed) catch continue;
        const decoded = allocator.alloc(u8, decoded_size) catch continue;
        std.base64.standard.Decoder.decode(decoded, trimmed) catch continue;
        
        try stdout.print("{s}\n", .{decoded});
    } else |_| {}
}