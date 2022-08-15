import 'package:nyxx/nyxx.dart';
import 'package:melo/modules/settings.dart';
import 'package:melo/modules/setup.dart';
import 'package:nyxx_commander/nyxx_commander.dart';

Future<IMessage> stopCommand(ICommandContext ctx, String args) {
  final node = cluster.getOrCreatePlayerNode(ctx.member!.guild.id);

  if (node.players[ctx.member!.guild.id]!.queue.isEmpty) {
    return ctx.channel.sendMessage(MessageBuilder.embed(EmbedBuilder()
      ..color = defaultEmbedColor
      ..description = "❌ No player found for this server."));
  }
  node.destroy(ctx.member!.guild.id);
  return ctx.channel.sendMessage(MessageBuilder.embed(EmbedBuilder()
    ..color = defaultEmbedColor
    ..description = "Music has been stopped"));
}
