import 'package:melo/modules/settings.dart';
import 'package:melo/modules/setup.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commander/nyxx_commander.dart';

Future<void> skipCommand(ICommandContext ctx, String args) async {
  final node = cluster.getOrCreatePlayerNode(ctx.member!.guild.id);

  if (node.players[ctx.member!.guild.id]!.queue.isEmpty) {
    ctx.channel.sendMessage(MessageBuilder.embed(EmbedBuilder()
      ..color = defaultEmbedColor
      ..description = "❌ No player found for this server."));
    return;
  }
  print(node.players[ctx.guild!.id]!.queue.length);
  ctx.channel.sendMessage(MessageBuilder.embed(EmbedBuilder()
    ..color = defaultEmbedColor
    ..description =
        "✅ **Skipped** ${node.players[ctx.guild!.id]?.nowPlaying?.track.info?.title ?? "Unknown"}"));
  node.skip(ctx.member!.guild.id);
}
