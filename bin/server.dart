import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  var conexao = MySqlConnection.connect(
    ConnectionSettings(
      host: await CustomEnv.get<String>(key: 'db_host'),
      port: await CustomEnv.get<int>(key: 'db_port'),
      user: await CustomEnv.get<String>(key: 'db_user'),
      password: await CustomEnv.get<String>(key: 'db_pass'),
      db: await CustomEnv.get<String>(key: 'db_schema'),
    ),
  );

  final _di = Injects.initialize();

  var cascateHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<BlogApi>().getHandler(isSecurity: true))
      .handler;

  final handler = Pipeline()
      .addMiddleware(logRequests()) // global Middlewares
      .addMiddleware(MiddlewareInterception().middleware) // global Middlewares
      .addHandler(cascateHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
