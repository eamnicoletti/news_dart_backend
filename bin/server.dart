import 'package:shelf/shelf.dart';

import 'apis/noticias_api.dart';
import 'apis/login_api.dart';
import 'apis/usuario_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final di = Injects.initialize();

  var cascateHandler = Cascade()
      .add(di.get<LoginApi>().getHandler())
      .add(di.get<NoticiasApi>().getHandler(isSecurity: true))
      .add(di.get<UsuarioApi>().getHandler(isSecurity: true))
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
