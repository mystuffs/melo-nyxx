import 'dart:async';

import 'package:nyxx/nyxx.dart';

FutureOr<String?> prefixHandler(IMessage message) async => "!";

DiscordColor get defaultEmbedColor {
  return DiscordColor.blurple;
}
