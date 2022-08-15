import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/nyxx_lavalink.dart';

late final ICluster cluster;

Future<void> node(INyxxWebsocket mainClient) async {
  cluster = ICluster.createCluster(mainClient, Snowflake("bot_id"));
  await cluster.addNode(NodeOptions(
      host: "target_host", port: 1337, password: "password (if any)"));
}
