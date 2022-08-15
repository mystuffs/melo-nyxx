import 'package:melo/modules/settings.dart';
import 'package:melo/modules/setup.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commander/nyxx_commander.dart';

Future<IMessage> queueCommand(ICommandContext ctx, String args) {
  final node = cluster.getOrCreatePlayerNode(ctx.member!.guild.id);

  if (node.players[ctx.member!.guild.id]!.queue.isEmpty) {
    return ctx.channel.sendMessage(MessageBuilder.embed(EmbedBuilder()
      ..color = defaultEmbedColor
      ..description = "❌ No player found for this server."));
  }

  final guildQueue = node.players[ctx.guild!.id];
  String filteredQueue = "";
  int i = 1;

  for (var track in guildQueue!.queue) {
    filteredQueue += "**$i.** ${track.track.info!.title}\n";
    i++;
  }
  return ctx.channel.sendMessage(MessageBuilder.embed(EmbedBuilder()
    ..color = defaultEmbedColor
    ..description = filteredQueue));
}
