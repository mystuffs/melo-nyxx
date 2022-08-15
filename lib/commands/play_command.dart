import 'dart:async';

import 'package:melo/modules/settings.dart';
import 'package:nyxx/nyxx.dart';
import 'package:melo/modules/setup.dart';
import 'package:nyxx_commander/nyxx_commander.dart';

late ICommandContext ctx;
late IMessage msg;

Future<void> playCommand(ICommandContext ctx, String args) async {
  final channel = await ctx.client.fetchChannel<IVoiceGuildChannel>(
      ctx.message.member!.voiceState!.channel!.id);
  channel.connect(selfDeafen: true);

  final node = cluster.getOrCreatePlayerNode(ctx.member!.guild.id);
  final query = args.split(" ").skip(1).join(" ");

  final search = await node.searchTracks("ytsearch:$query");
  print(node.stats?.memory.free);
  ctx.channel.sendMessage(MessageBuilder.embed(EmbedBuilder()
    ..color = defaultEmbedColor
    ..description = "🎵 **Added:** ${search.tracks[0].info!.title}"));

  if (query.contains("playlist") ||
      query.contains("start_radio") ||
      query.contains("index")) {
    for (var track in search.tracks) {
      node.play(ctx.member!.guild.id, track).queue();
    }
  } else {
    node.play(ctx.member!.guild.id, search.tracks[0]).queue();
  }
}
