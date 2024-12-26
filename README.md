# telebot.zig
## Create telegram bot on your favourite zig simply
![Telegram Bot API](https://img.shields.io/badge/Telegram_Bot_Api-8.0-blue)
![Zig](https://img.shields.io/badge/Zig_version-0.13.0-orange)
![telebot.zig](https://img.shields.io/badge/telebot.zig-0.1.1-blue)

---
### Content:
- [Usage](#usage)
- [TODO](#todo)
---

### Usage:
#### Create bot object:
```zig
var bot = Bot.init(std.heap.page_allocator, TOKEN);
defer bot.deinit();
```

#### Get bot information:
```zig
/// Receive and print details about bot
fn printMe(bot: *Bot) !void {
    var me_res = try bot.getMe();
    defer me_res.deinit();

    const me = me_res.data;
    std.debug.print("Hi! Im bot on zig! My name is {s} (@{s}). My id: {d}\n", .{ me.first_name, me.username.?, me.id });
}
```

#### Send message:
```zig
/// Sends single message
fn sendTestMessage(bot: *Bot) !void {
    var msg = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = "Hi from zig!" });
    defer msg.deinit();

    const m = msg.data;
    const username = m.chat.username orelse "NoUsername";
    const name = m.chat.first_name orelse "NoFirstName";

    std.debug.print("I have sent message with id: {d} for {s} (@{s})\n", .{ m.message_id, name, username });

    var data = std.ArrayList(u8).init(std.heap.page_allocator);
    defer data.deinit();
    try std.fmt.format(data.writer(), "Hello, {s} (@{s})", .{ name, username });

    var m2 = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = data.allocatedSlice() });
    defer m2.deinit();
}
```

#### Forward single message:
```zig
/// Will send single message and then forward it to the same dialog
fn forwardTestMessage(bot: *Bot) !void {
    const real_text = "LA-LA-LA";
    var msg1 = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = real_text });
    defer msg1.deinit();
    const mid = msg1.data.message_id;

    var msg2 = try bot.forwardMessage(.{ .chat_id = TEST_RECEIVER, .from_chat_id = TEST_RECEIVER, .message_id = mid });
    defer msg2.deinit();
    const text = msg2.data.text orelse "no text";
    std.debug.print("Forwarded message text: {s} (expected: {s})\n", .{ text, real_text });
}
```

#### Copy message:
```zig
/// Will send message and then copy it to the same chat
fn copyTestMessage(bot: *Bot) !void {
    var msg = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = "Message to be copied!" });
    defer msg.deinit();

    const m_id = msg.data.message_id;
    var id = try bot.copyMessage(.{ .chat_id = TEST_RECEIVER, .message_id = m_id, .from_chat_id = TEST_RECEIVER });
    defer id.deinit();
}
```

#### Send photo:
```zig
/// Will send just photo by url, then extract file_id and send with caption, spoiler and caption above photo
/// Currently support sending photos by url or file_id (no file upload)
fn sendTestPhoto(bot: *Bot) !void {
    const PHOTO_URL = "https://picsum.photos/720";
    var msg = try bot.sendPhoto(.{ .chat_id = TEST_RECEIVER, .photo = PHOTO_URL });
    defer msg.deinit();

    const file_id = msg.data.photo.?[0].file_id;
    var m = try bot.sendPhoto(.{ .chat_id = TEST_RECEIVER, .photo = file_id, .caption = "BLAH-BLAH-BLAH1" });
    m.deinit();

    var m2 = try bot.sendPhoto(.{ .chat_id = TEST_RECEIVER, .photo = file_id, .caption = "BLAH-BLAH-BLAH2", .has_spoiler = true });
    m2.deinit();

    var m3 = try bot.sendPhoto(.{ .chat_id = TEST_RECEIVER, .photo = file_id, .caption = "BLAH-BLAH-BLAH3", .show_caption_above_media = true });
    m3.deinit();
}
```

#### Using inline keyboard:
```zig
const Keyboard = @import("types/types.zig").Keyboard;
const InlineKeyboardMarkup = Keyboard.InlineKeyboardMarkup;
const InlineBuilder = Keyboard.InlineKeyboardMarkupBuilder;
const InlineKeyboardButton = Keyboard.InlineKeyboardButton;

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var bot = Bot.init(allocator, TOKEN);
    defer bot.deinit();
    var inlineKb = try buildKeyboard(allocator);
    const json = try inlineKb.toReplyMarkup(allocator);
    defer allocator.free(json);

    var m = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = "Testing keyboard that sent with telebot.zig!", .reply_markup = json });
    defer m.deinit();
}

fn buildKeyboard(allocator: std.mem.Allocator) !InlineKeyboardMarkup {
    var builder = InlineBuilder.init(allocator);

    const dynamic_value: []const u8 = std.mem.span(std.os.argv[0]);

    const row1 = &[_]InlineKeyboardButton{
        .{ .text = "Row 1 Button 1", .callback_data = dynamic_value },
        .{ .text = "Row 1 Button 2", .url = "https://duckduckgo.com/" },
    };
    const row2 = &[_]InlineKeyboardButton{
        .{ .text = "Row 2 Button 1", .web_app = .{ .url = "https://spreadprivacy.com/" } },
    };

    try builder.addRow(row1);
    try builder.addRow(row2);
    return builder.build();
}
```
> And more methods avaliable in this lib (Most of them works similar)
---
## TODO:
- [x] TelegramBotAPI Types
- [ ] TelegramBotAPI Methods
- [x] Polling
- [ ] States
- [ ] Fix all `TODO`
