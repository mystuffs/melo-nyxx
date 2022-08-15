import 'package:melo/melo.dart';
import 'package:nyxx/nyxx.dart';
import 'package:melo/modules/setup.dart';
import 'package:nyxx_commander/nyxx_commander.dart';

late INyxxWebsocket client;

const String token = "BOT_TOKEN";

void main(List<String> arguments) async {
  client = NyxxFactory.createNyxxWebsocket(
      token,
      GatewayIntents.guilds |
          GatewayIntents.guildMessages |
          GatewayIntents.guildVoiceState |
          GatewayIntents.messageContent)
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions());

  await client.connect();
  ICommander.create(client, prefixHandler,
      afterCommandHandler: (ICommandContext context) => {})
    ..registerCommand("play", playCommand)
    ..registerCommand("stop", stopCommand)
    ..registerCommand("skip", skipCommand)
    ..registerCommand("queue", queueCommand);
  client.eventsWs.onReady.listen((event) async {
    await node(client);
  });
}
